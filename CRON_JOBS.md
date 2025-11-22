# Configuration des Jobs Automatiques

## Jobs disponibles

### 1. Collecte des données complètes

Collecte les mentions, analyse les images, calcule les scores pour toutes les sneakers.

```bash
# Depuis la racine du monorepo
pnpm --filter @sneaker-tracker/backend collect:data

# Ou depuis apps/backend
cd apps/backend
node ace collect:data
```

### 2. Collecte des prix uniquement

Collecte uniquement les données de prix depuis différentes sources.

```bash
pnpm --filter @sneaker-tracker/backend collect:prices
```

## Configuration Cron (Linux/Mac)

### Option 1 : Cron système

Éditer le crontab :

```bash
crontab -e
```

Ajouter les lignes suivantes :

```cron
# Collecte complète toutes les 6 heures
0 */6 * * * cd /path/to/sneaker-trend-tracker && pnpm --filter @sneaker-tracker/backend collect:data >> /var/log/sneaker-tracker/collect.log 2>&1

# Collecte des prix toutes les heures
0 * * * * cd /path/to/sneaker-trend-tracker && pnpm --filter @sneaker-tracker/backend collect:prices >> /var/log/sneaker-tracker/prices.log 2>&1
```

### Option 2 : Google Cloud Scheduler

Pour déployer sur Google Cloud, utilisez Cloud Scheduler :

1. Créez une Cloud Function ou Cloud Run job
2. Configurez Cloud Scheduler pour l'appeler périodiquement

Exemple de configuration Cloud Scheduler :

```yaml
name: collect-sneaker-data
schedule: "0 */6 * * *"  # Toutes les 6 heures
target:
  httpTarget:
    uri: https://your-backend-url/api/jobs/collect-data
    httpMethod: POST
    headers:
      Authorization: "Bearer YOUR_SECRET_TOKEN"
```

## Configuration avec Bull/BullMQ (Recommandé pour production)

Pour une meilleure gestion des jobs en production, utilisez une queue :

### Installation

```bash
pnpm add bullmq ioredis
```

### Configuration

Créer `apps/backend/app/queues/sneaker_queue.ts` :

```typescript
import { Queue } from 'bullmq'
import { CollectSneakerDataJob } from '../jobs/collect_sneaker_data_job.js'

const connection = {
  host: process.env.REDIS_HOST || 'localhost',
  port: Number(process.env.REDIS_PORT) || 6379,
}

export const sneakerQueue = new Queue('sneaker-data', { connection })

// Ajouter un job
export async function scheduleDataCollection() {
  await sneakerQueue.add('collect-data', {}, {
    repeat: {
      pattern: '0 */6 * * *', // Toutes les 6 heures
    },
  })
}

// Worker pour traiter les jobs
import { Worker } from 'bullmq'

export const sneakerWorker = new Worker(
  'sneaker-data',
  async (job) => {
    if (job.name === 'collect-data') {
      await CollectSneakerDataJob.run()
    } else if (job.name === 'collect-prices') {
      await CollectSneakerDataJob.collectPrices()
    }
  },
  { connection }
)
```

## Monitoring

### Logs

Les jobs écrivent dans les logs. Surveillez :

- Succès : `✓ Updated data for sneaker {id}`
- Erreurs : `✗ Error updating sneaker {id}: {message}`

### Métriques

Ajoutez des métriques pour suivre :
- Nombre de sneakers traitées
- Temps d'exécution
- Taux de succès/échec
- Données collectées (mentions, prix, etc.)

## Recommandations

1. **Fréquence** :
   - Collecte complète : Toutes les 6 heures
   - Collecte des prix : Toutes les heures
   - Analyse OCR : Lors de l'upload d'une nouvelle image

2. **Limites** :
   - Limiter le nombre de sneakers traitées par batch (ex: 100)
   - Ajouter des retries en cas d'échec
   - Gérer les rate limits des APIs externes

3. **Performance** :
   - Utiliser des workers parallèles
   - Mettre en cache les résultats
   - Optimiser les requêtes Supabase

