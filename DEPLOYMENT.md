# Guide de déploiement

## Prérequis

- Compte Supabase
- Node.js 18+ installé
- Compte de déploiement (Vercel recommandé pour Next.js)

## Étapes de déploiement

### 1. Configuration Supabase

1. Créez un nouveau projet sur [Supabase](https://supabase.com)
2. Récupérez les clés API :
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`
3. Exécutez la migration SQL dans `supabase/migrations/001_initial_schema.sql`
4. Configurez les webhooks (voir `supabase/README.md`)

### 2. Configuration locale

1. Clonez le projet
2. Installez les dépendances :
```bash
npm install
```

3. Créez un fichier `.env` :
```bash
cp .env.example .env
```

4. Remplissez les variables d'environnement dans `.env`

5. Lancez le serveur de développement :
```bash
npm run dev
```

### 3. Déploiement sur Vercel

1. Connectez votre repository GitHub à Vercel
2. Ajoutez les variables d'environnement dans les paramètres du projet Vercel :
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - `SUPABASE_SERVICE_ROLE_KEY`
   - `WEBHOOK_SECRET`
   - `NEXT_PUBLIC_SITE_URL` (URL de votre déploiement)

3. Déployez !

### 4. Configuration des webhooks Supabase

Après le déploiement, mettez à jour les URLs des webhooks dans Supabase pour pointer vers votre domaine de production.

## Structure de production

- **Frontend** : Next.js (SSR) sur Vercel
- **Backend API** : Next.js API Routes (inclus dans le même déploiement)
- **Base de données** : Supabase (PostgreSQL)
- **Authentification** : Supabase Auth
- **Webhooks** : Supabase → API Next.js

## Notes importantes

- Les webhooks nécessitent une URL HTTPS en production
- Configurez `NEXT_PUBLIC_SITE_URL` avec votre domaine de production
- Le secret du webhook doit être identique dans Supabase et dans vos variables d'environnement

