# Guide de démarrage Beta - Sneaker-Trend Tracker

## 🚀 Démarrage rapide

### Prérequis

- Node.js 20+
- pnpm 8+ (ou installer avec `npm install -g pnpm`)
- Docker & Docker Compose (optionnel, pour le dev local)
- Compte Supabase

### 1️⃣ Installation

```bash
# Cloner le repo (si pas déjà fait)
git clone <repo-url>
cd sneaker-trend-tracker

# Installer les dépendances
pnpm install
```

### 2️⃣ Configuration

#### 2.1 Variables d'environnement

Créez un fichier `.env` à la racine :

```bash
cp .env.example .env
```

Remplissez avec vos clés Supabase :

```env
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_cle_anon
SUPABASE_SERVICE_ROLE_KEY=votre_cle_service_role
SUPABASE_JWT_AUDIENCE=authenticated
APP_KEY=votre_app_key_ici
WEBHOOK_SECRET=votre_secret_webhook
SENTRY_DSN=votre_sentry_dsn (optionnel)
REDIS_HOST=localhost (optionnel)
REDIS_PORT=6379 (optionnel)

# URLs
BACKEND_URL=http://localhost:3333
FRONTEND_URL=http://localhost:3000
```

#### 2.2 Initialiser Supabase

1. Créez un projet sur [Supabase](https://supabase.com)
2. Récupérez l'URL et les clés API
3. Exécutez les migrations SQL dans l'éditeur SQL de Supabase :

```bash
# Exécutez dans l'ordre :
# 1. supabase/migrations/001_initial_schema.sql
# 2. supabase/migrations/002_enable_realtime.sql
# 3. supabase/migrations/003_create_feature_flags.sql
```

### 3️⃣ Lancer l'application

#### Option 1 : Avec Docker Compose (recommandé)

```bash
# Démarrer tous les services
docker compose up --build

# Les services seront disponibles sur :
# - Frontend: http://localhost:3000
# - Backend:  http://localhost:3333
# - Supabase DB: localhost:5432
```

#### Option 2 : Mode développement (sans Docker)

```bash
# Dans un seul terminal (Turborepo lance tout en parallèle)
pnpm dev

# Ou séparément :
# Terminal 1 - Backend
cd apps/backend
pnpm dev

# Terminal 2 - Frontend
cd apps/frontend
pnpm dev
```

### 4️⃣ Vérifier que tout fonctionne

#### 4.1 Health Check API

```bash
curl http://localhost:3333/health
```

Réponse attendue :
```json
{
  "status": "ok",
  "timestamp": "2024-01-01T12:00:00.000Z"
}
```

#### 4.2 Frontend

1. Ouvrez http://localhost:3000
2. Créez un compte via `/signup`
3. Connectez-vous via `/login`
4. Accédez au dashboard `/dashboard`

#### 4.3 Seed de données (optionnel)

Pour peupler la base avec des données de test :

```bash
pnpm --filter @sneaker-tracker/backend seed
```

Cela créera 5 sneakers avec historique complet.

### 5️⃣ Tests

#### Tests unitaires

```bash
# Backend
pnpm --filter @sneaker-tracker/backend test

# Avec couverture
pnpm --filter @sneaker-tracker/backend test:coverage
```

#### Tests e2e

```bash
# Démarrer le frontend d'abord
pnpm --filter @sneaker-tracker/frontend dev

# Dans un autre terminal
pnpm --filter @sneaker-tracker/frontend test:e2e
```

### 6️⃣ Checklist "Prêt pour la beta"

- [ ] Variables d'environnement configurées (`.env`)
- [ ] Migrations Supabase exécutées
- [ ] Health check backend OK (`/health`)
- [ ] Frontend accessible (`http://localhost:3000`)
- [ ] Authentification fonctionne (inscription/connexion)
- [ ] Dashboard affiche les sneakers
- [ ] Tests unitaires passent
- [ ] Lint OK (`pnpm lint`)
- [ ] Docker Compose fonctionne (si utilisé)

### 7️⃣ Endpoints API à tester

```bash
# Liste des sneakers
curl http://localhost:3333/api/sneakers

# Détails d'une sneaker (remplacer {id})
curl http://localhost:3333/api/sneakers/{id}

# Tendance d'une sneaker
curl http://localhost:3333/api/sneakers/{id}/trend?days=30

# Documentation API
curl http://localhost:3333/docs
```

### 8️⃣ Scénarios de test

#### Scénario 1 : Parcours utilisateur complet

1. Inscription → `/signup`
2. Connexion → `/login`
3. Dashboard → `/dashboard`
4. Voir une sneaker → Cliquer sur une carte
5. Vérifier les graphiques et métriques

#### Scénario 2 : Filtres

1. Aller sur `/dashboard`
2. Filtrer par marque (ex: "Nike")
3. Filtrer par statut (ex: "Hot")
4. Vérifier que les résultats sont filtrés

#### Scénario 3 : Temps réel

1. Ouvrir deux onglets sur `/dashboard`
2. Dans un onglet, déclencher une mise à jour (via API ou webhook)
3. Vérifier que l'autre onglet se met à jour automatiquement

### 9️⃣ Surveillance pendant la beta

#### Logs

```bash
# Docker Compose
docker compose logs -f

# Backend seul
docker compose logs -f backend

# Frontend seul
docker compose logs -f frontend
```

#### Métriques à surveiller

- **Health checks** : Vérifier `/health` toutes les 5 minutes
- **Erreurs** : Surveiller Sentry (si configuré)
- **Performance** : Temps de réponse API < 500ms
- **Base de données** : Vérifier les requêtes lentes dans Supabase

### 🔟 Commandes utiles

```bash
# Build tout le projet
pnpm build

# Lint
pnpm lint

# Format
pnpm format

# Type check
pnpm type-check

# Nettoyer
pnpm clean

# Seed de données
pnpm --filter @sneaker-tracker/backend seed

# Collecter les données (job)
pnpm --filter @sneaker-tracker/backend collect:data
```

### 🐛 Dépannage

#### Le backend ne démarre pas

```bash
# Vérifier les variables d'environnement
cat apps/backend/.env

# Vérifier les logs
cd apps/backend
pnpm dev
```

#### Le frontend ne démarre pas

```bash
# Vérifier les variables d'environnement
cat apps/frontend/.env

# Nettoyer et réinstaller
cd apps/frontend
rm -rf node_modules .nuxt
pnpm install
pnpm dev
```

#### Erreurs de connexion Supabase

- Vérifier que `SUPABASE_URL` et `SUPABASE_ANON_KEY` sont corrects
- Vérifier que les migrations sont exécutées
- Vérifier les politiques RLS dans Supabase

#### Erreurs de build

```bash
# Nettoyer tout
pnpm clean
rm -rf node_modules apps/*/node_modules libs/*/node_modules

# Réinstaller
pnpm install

# Rebuild
pnpm build
```

### 📝 Prochaines étapes après la beta

1. Collecter les retours des testeurs
2. Corriger les bugs critiques
3. Améliorer les performances
4. Ajouter les fonctionnalités manquantes
5. Préparer le déploiement en production

---

**Bon test ! 🚀**

