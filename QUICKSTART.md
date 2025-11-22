# Guide de démarrage rapide

## Installation

```bash
# Installer les dépendances
pnpm install

# Créer le fichier .env
cp .env.example .env
```

## Configuration

1. **Créer un projet Supabase** :
   - Allez sur [supabase.com](https://supabase.com)
   - Créez un nouveau projet
   - Récupérez l'URL et les clés API

2. **Configurer `.env`** :
```env
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_cle_anon
SUPABASE_SERVICE_ROLE_KEY=votre_cle_service_role
APP_KEY=votre_app_key_ici
WEBHOOK_SECRET=votre_secret_webhook
BACKEND_URL=http://localhost:3333
FRONTEND_URL=http://localhost:3000
```

3. **Exécuter la migration SQL** :
   - Ouvrez l'éditeur SQL dans Supabase
   - Copiez-collez le contenu de `supabase/migrations/001_initial_schema.sql`
   - Exécutez la migration

## Lancer l'application

### Option 1 : Avec Docker Compose

```bash
docker compose up --build
```

### Option 2 : Sans Docker (mode développement)

```bash
# Démarrer backend + frontend en parallèle
pnpm dev
```

L'application sera accessible sur :
- Frontend : `http://localhost:3000`
- Backend API : `http://localhost:3333`

## Tester l'application

1. Créez un compte via `/signup`
2. Connectez-vous via `/login`
3. Accédez au tableau de bord via `/dashboard`

## Ajouter des données de test

Vous pouvez insérer des données de test directement dans Supabase :

```sql
-- Insérer une sneaker de test
INSERT INTO sneakers (brand, model, colorway, release_date)
VALUES ('Nike', 'Air Jordan 1', 'Chicago', '2023-01-01')
RETURNING id;

-- Récupérer l'ID de la sneaker créée, puis insérer des données
INSERT INTO sneaker_data (sneaker_id, price, mentions, trend_score, trust_score, ocr_score, rarity)
VALUES (
  'id_de_la_sneaker',
  150.00,
  1250,
  75,
  85,
  90,
  80
);

-- Insérer un historique de prix
INSERT INTO price_history (sneaker_id, price, date, source)
VALUES ('id_de_la_sneaker', 150.00, CURRENT_DATE, 'StockX');
```

## Prochaines étapes

- Configurer les webhooks Supabase (voir `supabase/README.md`)
- Intégrer les APIs de réseaux sociaux pour les mentions
- Intégrer un service OCR pour l'analyse d'images
- Déployer sur Google Cloud (voir `DEPLOYMENT.md`)

## Commandes utiles

```bash
# Build toutes les applications
pnpm build

# Linter toutes les applications
pnpm lint

# Nettoyer les builds
pnpm clean

# Build uniquement le backend
pnpm --filter @sneaker-tracker/backend build

# Build uniquement le frontend
pnpm --filter @sneaker-tracker/frontend build

# Build uniquement la librairie partagée
pnpm --filter @sneaker-tracker/shared build
```
