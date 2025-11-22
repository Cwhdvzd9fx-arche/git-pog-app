# Sneaker-Trend Tracker

Plateforme de suivi des tendances de sneakers en temps réel pour collectionneurs, boutiques et fans de sneakers.

## 🎯 Fonctionnalités MVP

- **API REST sécurisée** : Endpoints pour récupérer les données de sneakers (price, mentions, trendScore, trustScore)
- **Interface web SSR** : Tableau de bord avec graphiques, badges "Hot/Cold", filtres par marque/modèle/période
- **Authentification Supabase** : Gestion des utilisateurs et permissions
- **Webhooks temps réel** : Mise à jour automatique du frontend via Supabase Realtime

## 🚀 Démarrage Rapide

### Pour lancer la beta, suivez :

👉 **[COMMENCER_ICI.md](./COMMENCER_ICI.md)** - Guide ultra-rapide (3 étapes)

### Ou pour un guide complet :

👉 **[GUIDE_BETA_COMPLET.md](./GUIDE_BETA_COMPLET.md)** - Guide détaillé avec tous les détails

## 📋 Résumé des étapes

1. **Installer pnpm** : `npm install -g pnpm`
2. **Installer les dépendances** : `pnpm install`
3. **Configurer Supabase** : Créer un projet et exécuter les migrations
4. **Créer `.env`** : Copier `env.example.txt` et remplir avec vos clés
5. **Lancer** : `pnpm dev`

## 🛠️ Stack technique

| Layer | Tech | Pourquoi |
|-------|------|----------|
| **Backend** | **AdonisJS** (TypeScript) | MVC complet, validation, middleware facile à intégrer avec Supabase |
| **Frontend** | **Nuxt 3** (Vue 3, SSR) | Rendu côté serveur, SEO-friendly, hot-module-replacement |
| **Base de données** | **Supabase** (PostgreSQL) | Auth, Realtime, Storage prêts à l'emploi |
| **Monorepo** | **pnpm workspaces + Turborepo** | Gestion centralisée, caches de build, exécution parallèle |

## 📁 Structure du projet

```
sneaker-trend-tracker/
├── apps/
│   ├── backend/          # AdonisJS API
│   └── frontend/          # Nuxt 3 SSR
├── libs/
│   └── shared/            # Types, schemas, helpers partagés
├── supabase/
│   └── migrations/        # Migrations SQL
├── scripts/               # Scripts utilitaires
└── docs/                  # Documentation
```

## 📚 Documentation

- **[COMMENCER_ICI.md](./COMMENCER_ICI.md)** - Démarrage rapide
- **[GUIDE_BETA_COMPLET.md](./GUIDE_BETA_COMPLET.md)** - Guide complet
- **[BETA_GUIDE.md](./BETA_GUIDE.md)** - Guide beta détaillé
- **[DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md)** - Guide de déploiement
- **[CONTRIBUTING.md](./CONTRIBUTING.md)** - Guide de contribution
- **[MVP_FEATURES.md](./MVP_FEATURES.md)** - Liste des fonctionnalités

## 🧪 Tests

```bash
# Tests unitaires
pnpm test

# Tests e2e
pnpm --filter @sneaker-tracker/frontend test:e2e

# Lint
pnpm lint
```

## 🔐 Sécurité

- Authentification JWT via Supabase
- Rate limiting (100 req/min)
- Headers de sécurité
- CORS configuré
- Secrets via GCP Secret Manager (production)

## 📊 Endpoints API

- `GET /api/sneakers` - Liste des sneakers
- `GET /api/sneakers/:id` - Détails d'une sneaker
- `GET /api/sneakers/:id/trend` - Données de tendance
- `GET /docs` - Documentation API (Swagger)
- `GET /health` - Health check

## 🚀 Déploiement

Voir [DEPLOYMENT_GUIDE.md](./DEPLOYMENT_GUIDE.md) pour les instructions complètes.

## 📝 Licence

MIT

---

**Pour commencer rapidement, suivez [COMMENCER_ICI.md](./COMMENCER_ICI.md) ! 🚀**
