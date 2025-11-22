# 🚀 Lancer la Beta - Guide Rapide

## Prérequis

1. **Node.js 20+** installé
2. **pnpm** installé : `npm install -g pnpm`
3. **Compte Supabase** créé

## 🎯 Démarrage en 5 minutes

### 1. Installer pnpm (si pas déjà fait)

```bash
npm install -g pnpm
```

### 2. Installer les dépendances

```bash
cd "/Users/louishauguel/Downloads/dossier sans titre"
pnpm install
```

### 3. Configurer Supabase

1. Créez un projet sur [supabase.com](https://supabase.com)
2. Copiez l'URL et les clés API
3. Créez un fichier `.env` à la racine :

```bash
cat > .env << EOF
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre_cle_anon
SUPABASE_SERVICE_ROLE_KEY=votre_cle_service_role
SUPABASE_JWT_AUDIENCE=authenticated
APP_KEY=une_cle_secrete_aleatoire_32_caracteres_minimum
WEBHOOK_SECRET=un_secret_webhook
BACKEND_URL=http://localhost:3333
FRONTEND_URL=http://localhost:3000
EOF
```

4. Dans Supabase → SQL Editor, exécutez les migrations :
   - `supabase/migrations/001_initial_schema.sql`
   - `supabase/migrations/002_enable_realtime.sql`
   - `supabase/migrations/003_create_feature_flags.sql`

### 4. (Optionnel) Seed de données

```bash
pnpm --filter @sneaker-tracker/backend seed
```

### 5. Lancer l'application

```bash
# Démarrer backend + frontend
pnpm dev
```

### 6. Tester

1. **Backend** : http://localhost:3333/health
2. **Frontend** : http://localhost:3000
3. **API Docs** : http://localhost:3333/docs

## ✅ Vérifications rapides

### Test 1 : Health Check

```bash
curl http://localhost:3333/health
```

Doit retourner : `{"status":"ok","timestamp":"..."}`

### Test 2 : API Sneakers

```bash
curl http://localhost:3333/api/sneakers
```

Doit retourner une liste (vide si pas de seed, ou avec données si seedé)

### Test 3 : Frontend

1. Ouvrez http://localhost:3000
2. Cliquez "S'inscrire"
3. Créez un compte
4. Connectez-vous
5. Vérifiez le dashboard

## 🐛 Si ça ne marche pas

### Erreur "pnpm not found"

```bash
npm install -g pnpm
```

### Erreur "Cannot find module"

```bash
# Nettoyer et réinstaller
rm -rf node_modules apps/*/node_modules libs/*/node_modules
pnpm install
```

### Backend ne démarre pas

Vérifiez que `.env` contient bien `SUPABASE_URL` et `SUPABASE_SERVICE_ROLE_KEY`

### Frontend ne démarre pas

```bash
cd apps/frontend
rm -rf node_modules .nuxt
pnpm install
pnpm dev
```

## 📝 Commandes utiles

```bash
# Voir les logs
pnpm dev

# Build tout
pnpm build

# Tests
pnpm test

# Lint
pnpm lint
```

## 🎉 C'est parti !

Une fois que tout fonctionne :
- ✅ Backend accessible sur :3333
- ✅ Frontend accessible sur :3000
- ✅ Vous pouvez créer un compte et tester

**Bon test ! 🚀**

