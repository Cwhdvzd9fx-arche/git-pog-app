# 🚀 Guide de démarrage Beta - Sneaker-Trend Tracker

## Étape 1 : Installation des outils

### Option A : Utiliser pnpm (recommandé)

```bash
# Installer pnpm globalement
npm install -g pnpm

# Vérifier l'installation
pnpm --version
```

### Option B : Utiliser npm (alternative)

Le projet est configuré pour pnpm, mais vous pouvez adapter :

```bash
# Installer les dépendances avec npm
npm install

# Note: Vous devrez peut-être ajuster les scripts dans package.json
```

## Étape 2 : Configuration

### 2.1 Créer le fichier .env

```bash
# À la racine du projet
cp .env.example .env
```

### 2.2 Remplir les variables Supabase

1. Créez un projet sur [Supabase](https://supabase.com)
2. Allez dans Settings → API
3. Copiez les valeurs dans `.env` :

```env
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_ANON_KEY=eyJhbGc...
SUPABASE_SERVICE_ROLE_KEY=eyJhbGc...
SUPABASE_JWT_AUDIENCE=authenticated
APP_KEY=une_cle_secrete_aleatoire_ici
WEBHOOK_SECRET=un_secret_webhook_ici
```

## Étape 3 : Initialiser la base de données

### 3.1 Exécuter les migrations SQL

Dans le dashboard Supabase → SQL Editor, exécutez dans l'ordre :

1. **Migration initiale** : Copiez-collez le contenu de `supabase/migrations/001_initial_schema.sql`
2. **Realtime** : Copiez-collez `supabase/migrations/002_enable_realtime.sql`
3. **Feature flags** : Copiez-collez `supabase/migrations/003_create_feature_flags.sql`

### 3.2 (Optionnel) Seed de données

```bash
# Après avoir installé les dépendances
pnpm --filter @sneaker-tracker/backend seed
```

Cela créera 5 sneakers de test avec historique complet.

## Étape 4 : Lancer l'application

### Option 1 : Mode développement (recommandé pour la beta)

```bash
# Installer les dépendances
pnpm install

# Démarrer backend + frontend en parallèle
pnpm dev
```

Les services seront disponibles sur :
- **Frontend** : http://localhost:3000
- **Backend** : http://localhost:3333
- **Health check** : http://localhost:3333/health
- **API Docs** : http://localhost:3333/docs

### Option 2 : Avec Docker Compose

```bash
# Démarrer tous les services
docker compose up --build

# Voir les logs
docker compose logs -f
```

## Étape 5 : Vérifications

### 5.1 Health Check

```bash
curl http://localhost:3333/health
```

Réponse attendue :
```json
{"status":"ok","timestamp":"2024-01-01T12:00:00.000Z"}
```

### 5.2 Test de l'API

```bash
# Liste des sneakers
curl http://localhost:3333/api/sneakers

# Si vous avez seedé, vous devriez voir 5 sneakers
```

### 5.3 Test du frontend

1. Ouvrez http://localhost:3000
2. Cliquez sur "S'inscrire"
3. Créez un compte (ex: test@example.com / password123)
4. Connectez-vous
5. Vous devriez voir le dashboard avec les sneakers

## Étape 6 : Tests automatisés

### Tests unitaires

```bash
# Backend
pnpm --filter @sneaker-tracker/backend test

# Avec couverture
pnpm --filter @sneaker-tracker/backend test:coverage
```

### Tests e2e

```bash
# Démarrer le frontend d'abord (dans un terminal)
pnpm --filter @sneaker-tracker/frontend dev

# Dans un autre terminal
pnpm --filter @sneaker-tracker/frontend test:e2e
```

## 📋 Checklist Beta

Avant de partager avec les testeurs :

- [ ] Variables d'environnement configurées (`.env`)
- [ ] Migrations Supabase exécutées
- [ ] Health check backend OK
- [ ] Frontend accessible
- [ ] Authentification fonctionne
- [ ] Dashboard affiche les sneakers
- [ ] Tests unitaires passent
- [ ] Lint OK (`pnpm lint`)
- [ ] Documentation à jour

## 🐛 Dépannage rapide

### Le backend ne démarre pas

```bash
# Vérifier les logs
cd apps/backend
pnpm dev

# Erreur commune : variables d'environnement manquantes
# Vérifiez que .env contient SUPABASE_URL et SUPABASE_SERVICE_ROLE_KEY
```

### Le frontend ne démarre pas

```bash
# Nettoyer et réinstaller
cd apps/frontend
rm -rf node_modules .nuxt
pnpm install
pnpm dev
```

### Erreur "Cannot find module"

```bash
# Réinstaller toutes les dépendances
pnpm clean
pnpm install
```

### Erreur de connexion Supabase

- Vérifiez que les clés dans `.env` sont correctes
- Vérifiez que les migrations sont exécutées
- Vérifiez les politiques RLS dans Supabase Dashboard

## 🎯 Scénarios de test recommandés

### Scénario 1 : Parcours utilisateur
1. Inscription → Connexion → Dashboard
2. Cliquer sur une sneaker
3. Vérifier les graphiques et métriques

### Scénario 2 : Filtres
1. Filtrer par marque (ex: "Nike")
2. Filtrer par statut (ex: "Hot")
3. Vérifier les résultats

### Scénario 3 : API
1. Tester `GET /api/sneakers`
2. Tester `GET /api/sneakers/:id`
3. Vérifier la documentation `/docs`

## 📊 Commandes utiles

```bash
# Build tout
pnpm build

# Lint
pnpm lint

# Format
pnpm format

# Type check
pnpm type-check

# Seed de données
pnpm --filter @sneaker-tracker/backend seed

# Collecter les données (job)
pnpm --filter @sneaker-tracker/backend collect:data
```

## 🚀 Prêt pour la beta !

Une fois toutes les vérifications passées, vous pouvez :

1. Partager l'URL avec les testeurs
2. Surveiller les logs
3. Collecter les retours
4. Corriger les bugs

**Bon test ! 🎉**

