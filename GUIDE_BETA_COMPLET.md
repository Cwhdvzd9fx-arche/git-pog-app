# 🚀 Guide Complet - Beta Sneaker-Trend Tracker

## 1️⃣ Prérequis : Outils à installer

| Outil | Pourquoi | Commande d'installation |
|-------|----------|------------------------|
| **Node.js** (v20+ recommandé) | Runtime JavaScript | `brew install node` (macOS) ou [nodejs.org](https://nodejs.org) |
| **pnpm** (gestionnaire de paquets) | Plus rapide que npm & yarn, gère les workspaces | `npm i -g pnpm` |
| **Git** | Versionnage | `brew install git` (déjà présent si vous avez cloné) |
| **Supabase CLI** (facultatif) | Exécuter les migrations depuis le terminal | `npm i -g supabase` |
| **Docker** (optionnel) | Isolation dans des conteneurs | [docker.com/get-started](https://www.docker.com/get-started) |
| **VS Code** (ou autre) | Éditeur de code | [code.visualstudio.com](https://code.visualstudio.com) |

### Vérifier les versions

```bash
node -v      # >= 20
pnpm -v      # >= 8
supabase -v  # (optionnel)
```

## 2️⃣ Clone du dépôt & mise en place

Vous avez déjà le dossier : `/Users/louishauguel/Downloads/dossier sans titre`

Si vous partez d'un nouveau clone :

```bash
git clone <votre-repo-url>
cd sneaker-trend-tracker
```

## 3️⃣ Installation des dépendances

```bash
# Depuis la racine du projet
pnpm install
```

`pnpm` va installer automatiquement les dépendances pour :
- `apps/backend` (AdonisJS)
- `apps/frontend` (Nuxt 3)
- `libs/shared` (librairie partagée)

Grâce aux **workspaces**, tout est géré depuis la racine.

## 4️⃣ Configuration de Supabase

### 4.1 Créez un projet Supabase

1. Allez sur [supabase.com](https://supabase.com)
2. Cliquez sur **New project**
3. Choisissez un nom, un mot de passe pour la base
4. Cliquez sur **Create**

### 4.2 Récupérez les clés

Dans le tableau de bord du projet → **Settings → API** :

| Variable | Où la trouver |
|----------|--------------|
| `SUPABASE_URL` | Settings → API → **Project URL** |
| `SUPABASE_ANON_KEY` | Settings → API → **anon public** |
| `SUPABASE_SERVICE_ROLE_KEY` | Settings → API → **service_role** |
| `SUPABASE_JWT_AUDIENCE` | Par défaut : `authenticated` |

### 4.3 Créez le fichier .env

```bash
# Copiez le template
cp env.example.txt .env
```

Éditez `.env` avec votre éditeur :

```env
# ------------------------------
# Supabase
# ------------------------------
SUPABASE_URL=https://xxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SUPABASE_JWT_AUDIENCE=authenticated

# ------------------------------
# Application
# ------------------------------
APP_KEY=uneCleSecreteTresLongueEtAleatoire32CaracteresMinimum
WEBHOOK_SECRET=unSecretWebhookAleatoire

# ------------------------------
# URLs
# ------------------------------
BACKEND_URL=http://localhost:3333
FRONTEND_URL=http://localhost:3000

# ------------------------------
# Observabilité (optionnel)
# ------------------------------
SENTRY_DSN=https://xxx@sentry.io/xxx

# ------------------------------
# Cache Redis (optionnel)
# ------------------------------
REDIS_HOST=localhost
REDIS_PORT=6379
REDIS_PASSWORD=
```

**Important** : Ne commettez jamais `.env` dans Git ! Il est déjà dans `.gitignore`.

### 4.4 Exécutez les migrations SQL

#### Option A – Via le Dashboard Supabase (recommandé)

1. Dans le tableau de bord → **SQL Editor**
2. Exécutez dans l'ordre :

```sql
-- 1. Migration initiale
-- Copiez-collez le contenu de : supabase/migrations/001_initial_schema.sql
-- Cliquez sur "Run"

-- 2. Activer Realtime
-- Copiez-collez : supabase/migrations/002_enable_realtime.sql
-- Cliquez sur "Run"

-- 3. Feature flags
-- Copiez-collez : supabase/migrations/003_create_feature_flags.sql
-- Cliquez sur "Run"
```

#### Option B – Via Supabase CLI

```bash
# Si vous avez installé supabase CLI
supabase link --project-ref votre-project-ref
supabase db push
```

### 4.5 Vérifier les tables

Dans Supabase Dashboard → **Table Editor**, vous devriez voir :
- ✅ `sneakers`
- ✅ `sneaker_data`
- ✅ `price_history`
- ✅ `feature_flags`

## 5️⃣ Lancement de l'application

### 5.1 Méthode « script tout-en-un » (recommandé)

```bash
# Rendre exécutable (une seule fois)
chmod +x QUICK_START_BETA.sh

# Lancer le script
./QUICK_START_BETA.sh
```

Ce script fait automatiquement :
- Vérifie les prérequis
- Installe pnpm si nécessaire
- Installe les dépendances
- Build la librairie partagée
- Prépare le démarrage

### 5.2 Démarrage manuel

#### Option A : Avec Turborepo (tout en parallèle)

```bash
# Depuis la racine
pnpm dev
```

Cela démarre automatiquement :
- Backend sur http://localhost:3333
- Frontend sur http://localhost:3000

#### Option B : Séparément (si vous préférez)

```bash
# Terminal 1 - Backend
cd apps/backend
pnpm dev

# Terminal 2 - Frontend
cd apps/frontend
pnpm dev
```

### Ports par défaut

| Service | Port | URL |
|---------|------|-----|
| **Backend** | 3333 | http://localhost:3333 |
| **Frontend** | 3000 | http://localhost:3000 |
| **Health Check** | 3333 | http://localhost:3333/health |
| **API Docs** | 3333 | http://localhost:3333/docs |

## 6️⃣ Vérifications rapides

### 6.1 Tests manuels

| Cible | URL | Que vérifier |
|-------|-----|--------------|
| **Health-check backend** | http://localhost:3333/health | Réponse JSON `{ "status":"ok", "timestamp":"..." }` (code 200) |
| **Documentation API** | http://localhost:3333/docs | Swagger/OpenAPI s'affiche |
| **Interface UI** | http://localhost:3000 | Page d'accueil (ou login) |
| **API Sneakers** | http://localhost:3333/api/sneakers | Liste de sneakers (JSON) |

### 6.2 Utiliser le script quick-check.sh

```bash
chmod +x scripts/quick-check.sh
./scripts/quick-check.sh
```

Ce script vérifie :
- ✅ pnpm installé
- ✅ Node.js version
- ✅ Fichier .env présent
- ✅ Variables Supabase configurées
- ✅ Dépendances installées
- ✅ Structure du projet

### 6.3 Exécuter les tests d'API

```bash
chmod +x scripts/test-beta.sh
./scripts/test-beta.sh
```

Ce script teste :
- Health check backend
- Frontend accessible
- Endpoints API

### 6.4 Tests automatisés

```bash
# Tests unitaires backend
pnpm --filter @sneaker-tracker/backend test

# Tests e2e frontend (nécessite le frontend démarré)
pnpm --filter @sneaker-tracker/frontend test:e2e
```

## 7️⃣ Que voir dans le navigateur ?

### 7.1 Frontend – UI principale

1. **Page d'accueil** (`http://localhost:3000`)
   - Titre "Sneaker-Trend Tracker"
   - Boutons "Se connecter" / "S'inscrire"

2. **Inscription** (`/signup`)
   - Formulaire email + mot de passe
   - Créez un compte de test

3. **Connexion** (`/login`)
   - Connectez-vous avec vos identifiants

4. **Tableau de bord** (`/dashboard`)
   - Liste des sneakers avec badges "Hot/Cold/Neutre"
   - Filtres par marque, modèle, statut
   - Métriques : prix, trend score, trust score
   - Cliquez sur une sneaker pour voir les détails

5. **Détail sneaker** (`/sneakers/:id`)
   - Image de la sneaker
   - Toutes les métriques (prix, mentions, scores)
   - Graphique de tendance (30 jours)
   - Historique des prix (90 jours)
   - Prévision sur 7 jours
   - Hashtags populaires

### 7.2 Backend – API & Docs

#### Endpoints disponibles

```bash
# Health check
curl http://localhost:3333/health

# Liste des sneakers
curl http://localhost:3333/api/sneakers

# Détails d'une sneaker
curl http://localhost:3333/api/sneakers/{id}

# Tendance d'une sneaker
curl http://localhost:3333/api/sneakers/{id}/trend?days=30

# Documentation API (Swagger)
open http://localhost:3333/docs
```

#### Exemple avec authentification

```bash
# Récupérer un token (après connexion via frontend)
TOKEN="votre_token_jwt"

# Requête authentifiée
curl -H "Authorization: Bearer $TOKEN" \
  http://localhost:3333/api/sneakers/{id}/update
```

## 8️⃣ (Optionnel) Seed de données

Pour peupler la base avec des données de test :

```bash
pnpm --filter @sneaker-tracker/backend seed
```

Cela créera :
- 5 sneakers (Nike, Adidas, Jordan, etc.)
- Données historiques (30 jours)
- Historique des prix (90 jours)
- Feature flags par défaut

## 9️⃣ Dépannage : problèmes fréquents

| Symptôme | Cause fréquente | Solution |
|----------|----------------|----------|
| **Port 3333 déjà utilisé** | Un autre service Node lancé | `lsof -i :3333` → `kill -9 <PID>` ou changer `PORT=3334` dans `.env` |
| **Erreur "ENOENT: .env"** | Fichier .env manquant | `cp env.example.txt .env` et remplissez-le |
| **Connexion Supabase refusée** | URL ou clé erronée | Vérifiez les valeurs dans Dashboard → API |
| **Migrations non appliquées** | Étape 4.4 sautée | Réexécutez les scripts SQL dans Supabase |
| **CORS error** | Backend n'autorise pas localhost:3000 | Vérifiez `config/cors.ts` (déjà configuré) |
| **"Cannot find module"** | Dépendances non installées | `rm -rf node_modules` puis `pnpm install` |
| **Tests échouent** | Packages manquants | `pnpm install` et vérifiez Node 20+ |
| **Backend ne démarre pas** | Variables d'environnement manquantes | Vérifiez que `.env` contient `SUPABASE_URL` et `SUPABASE_SERVICE_ROLE_KEY` |
| **Frontend erreur 500** | Backend non démarré | Démarrez le backend d'abord (`pnpm dev`) |

### Commandes de dépannage

```bash
# Nettoyer et réinstaller
pnpm clean
pnpm install

# Vérifier les variables d'environnement
cat .env | grep SUPABASE

# Vérifier les ports utilisés
lsof -i :3333
lsof -i :3000

# Voir les logs backend
cd apps/backend && pnpm dev

# Voir les logs frontend
cd apps/frontend && pnpm dev
```

## 🔟 (Optionnel) Lancer avec Docker Compose

Pour isoler complètement l'environnement :

```bash
# Démarrer tous les services
docker compose up --build

# Voir les logs
docker compose logs -f

# Arrêter
docker compose down
```

Le `docker-compose.yml` inclut :
- ✅ Supabase PostgreSQL (port 5432)
- ✅ Backend AdonisJS (port 3333)
- ✅ Frontend Nuxt 3 (port 3000)

**Note** : Les variables `SUPABASE_URL` dans `.env` pointent vers votre projet Supabase hébergé (pas le conteneur local).

## 1️⃣1️⃣ Récapitulatif des commandes « one-liner »

```bash
# 1️⃣ Prérequis
npm i -g pnpm supabase

# 2️⃣ Installation
pnpm install

# 3️⃣ .env
cp env.example.txt .env
# → Éditez .env avec vos clés Supabase

# 4️⃣ Migrations Supabase
# → Exécutez les SQL dans le Dashboard Supabase

# 5️⃣ Seed (optionnel)
pnpm --filter @sneaker-tracker/backend seed

# 6️⃣ Lancement
pnpm dev

# 7️⃣ Vérifications
curl http://localhost:3333/health
open http://localhost:3000

# 8️⃣ Tests
pnpm test
```

## 1️⃣2️⃣ Checklist "Prêt pour la beta"

Avant de partager avec les testeurs :

- [ ] Node.js 20+ installé
- [ ] pnpm installé
- [ ] Dépendances installées (`pnpm install`)
- [ ] Projet Supabase créé
- [ ] Migrations SQL exécutées (3 fichiers)
- [ ] Fichier `.env` configuré avec toutes les clés
- [ ] Health check backend OK (`/health`)
- [ ] Frontend accessible (`http://localhost:3000`)
- [ ] Inscription/Connexion fonctionne
- [ ] Dashboard affiche les sneakers
- [ ] Tests unitaires passent
- [ ] Lint OK (`pnpm lint`)
- [ ] (Optionnel) Seed de données exécuté

## 🎯 Scénarios de test recommandés

### Scénario 1 : Parcours utilisateur complet
1. Inscription → Connexion → Dashboard
2. Cliquer sur une sneaker
3. Vérifier les graphiques et métriques
4. Tester les filtres

### Scénario 2 : API REST
1. Tester `GET /api/sneakers`
2. Tester `GET /api/sneakers/:id`
3. Tester `GET /api/sneakers/:id/trend`
4. Consulter `/docs`

### Scénario 3 : Temps réel
1. Ouvrir 2 onglets sur `/dashboard`
2. Déclencher une mise à jour (via API)
3. Vérifier que l'autre onglet se met à jour

## 📊 Surveillance pendant la beta

### Logs

```bash
# Docker Compose
docker compose logs -f

# Backend seul
cd apps/backend && pnpm dev

# Frontend seul
cd apps/frontend && pnpm dev
```

### Métriques à surveiller

- **Health checks** : Vérifier `/health` toutes les 5 minutes
- **Temps de réponse API** : < 500ms
- **Taux d'erreur** : < 1%
- **Erreurs Sentry** : Surveiller les exceptions

## 🎉 C'est parti !

Une fois toutes les vérifications passées, vous pouvez :

1. ✅ Partager l'URL avec les testeurs
2. ✅ Surveiller les logs
3. ✅ Collecter les retours
4. ✅ Corriger les bugs

**Bon test ! 🚀**

