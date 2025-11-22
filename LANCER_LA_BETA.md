# 🚀 Lancer la Beta - Guide Simple

## ⚡ Démarrage en 5 minutes

### Étape 1 : Installer pnpm

```bash
npm install -g pnpm
```

Vérifiez : `pnpm -v` (doit afficher 8+)

### Étape 2 : Installer les dépendances

```bash
cd "/Users/louishauguel/Downloads/dossier sans titre"
pnpm install
```

Cela peut prendre 2-3 minutes la première fois.

### Étape 3 : Configurer Supabase

1. **Créer un projet** sur [supabase.com](https://supabase.com)
2. **Récupérer les clés** dans Settings → API
3. **Créer `.env`** :

```bash
cp env.example.txt .env
```

4. **Éditer `.env`** et remplir avec vos clés Supabase

5. **Exécuter les migrations SQL** dans Supabase → SQL Editor :
   - `supabase/migrations/001_initial_schema.sql`
   - `supabase/migrations/002_enable_realtime.sql`
   - `supabase/migrations/003_create_feature_flags.sql`

### Étape 4 : Lancer l'application

```bash
pnpm dev
```

Attendez que les deux services démarrent (backend + frontend).

### Étape 5 : Tester

1. **Health check** : http://localhost:3333/health
2. **Frontend** : http://localhost:3000
3. **Créer un compte** et tester !

## ✅ Vérification rapide

```bash
# Vérifier que tout est prêt
./scripts/verify-setup.sh

# Tester les endpoints
./scripts/test-beta.sh
```

## 🎯 (Optionnel) Ajouter des données de test

```bash
pnpm --filter @sneaker-tracker/backend seed
```

Cela créera 5 sneakers avec historique complet.

## 📚 Documentation complète

- **Guide détaillé** : `GUIDE_BETA_COMPLET.md`
- **Démarrage rapide** : `COMMENCER_ICI.md`
- **Dépannage** : Voir section 9 dans `GUIDE_BETA_COMPLET.md`

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
Vérifiez que `.env` contient bien `SUPABASE_URL` et `SUPABASE_SERVICE_ROLE_KEY`

## 🎉 C'est tout !

Une fois lancé :
- **Frontend** : http://localhost:3000
- **Backend** : http://localhost:3333
- **API Docs** : http://localhost:3333/docs

**Bon test ! 🚀**

