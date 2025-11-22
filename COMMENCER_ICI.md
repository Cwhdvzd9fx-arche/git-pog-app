# 🚀 Commencer Ici - Beta Sneaker-Trend Tracker

## ⚡ Démarrage en 3 étapes

### 1. Installer pnpm

```bash
npm install -g pnpm
```

### 2. Installer les dépendances

```bash
pnpm install
```

### 3. Configurer et lancer

```bash
# Créer .env
cp env.example.txt .env

# Éditer .env et remplir avec vos clés Supabase
# Puis lancer :
pnpm dev
```

## 📝 Configuration Supabase (5 minutes)

1. **Créer un projet** sur [supabase.com](https://supabase.com)

2. **Récupérer les clés** dans Settings → API :
   - URL du projet
   - anon key
   - service_role key

3. **Remplir `.env`** avec ces valeurs

4. **Exécuter les migrations SQL** dans Supabase → SQL Editor :
   - `supabase/migrations/001_initial_schema.sql`
   - `supabase/migrations/002_enable_realtime.sql`
   - `supabase/migrations/003_create_feature_flags.sql`

## ✅ Vérifier que ça marche

### Test rapide

```bash
# Terminal 1 : Lancer l'app
pnpm dev

# Terminal 2 : Tester
curl http://localhost:3333/health
```

**Réponse attendue** : `{"status":"ok","timestamp":"..."}`

### Test complet

1. Ouvrez http://localhost:3000
2. Créez un compte
3. Connectez-vous
4. Vérifiez le dashboard

## 🎯 (Optionnel) Ajouter des données de test

```bash
pnpm --filter @sneaker-tracker/backend seed
```

Cela créera 5 sneakers avec historique complet.

## 📚 Documentation complète

- **Guide détaillé** : `BETA_GUIDE.md`
- **Démarrage rapide** : `START_BETA.md`
- **Dépannage** : Voir section "Dépannage" dans `BETA_GUIDE.md`

## 🐛 Problème ?

### pnpm non trouvé
```bash
npm install -g pnpm
```

### Erreurs de dépendances
```bash
rm -rf node_modules apps/*/node_modules libs/*/node_modules
pnpm install
```

### Backend ne démarre pas
Vérifiez que `.env` contient `SUPABASE_URL` et `SUPABASE_SERVICE_ROLE_KEY`

## 🎉 C'est tout !

Une fois lancé :
- **Frontend** : http://localhost:3000
- **Backend** : http://localhost:3333
- **API Docs** : http://localhost:3333/docs

**Bon test ! 🚀**

