# 🧪 Beta Sneaker-Trend Tracker - Guide Complet

## 🎯 Objectif

Lancer une beta fonctionnelle pour tester toutes les fonctionnalités du MVP.

## ⚡ Démarrage Ultra-Rapide

```bash
# 1. Installer pnpm (si nécessaire)
npm install -g pnpm

# 2. Installer les dépendances
pnpm install

# 3. Configurer .env (voir ci-dessous)

# 4. Lancer
pnpm dev
```

## 📋 Checklist avant de lancer

### ✅ Étape 1 : Prérequis

- [ ] Node.js 20+ installé (`node -v`)
- [ ] pnpm installé (`pnpm -v`)
- [ ] Docker installé (optionnel, pour docker-compose)

### ✅ Étape 2 : Configuration Supabase

1. **Créer un projet Supabase**
   - Allez sur [supabase.com](https://supabase.com)
   - Créez un nouveau projet
   - Notez l'URL et les clés API

2. **Exécuter les migrations**
   - Dans Supabase Dashboard → SQL Editor
   - Exécutez dans l'ordre :
     ```
     supabase/migrations/001_initial_schema.sql
     supabase/migrations/002_enable_realtime.sql
     supabase/migrations/003_create_feature_flags.sql
     ```

3. **Configurer les variables d'environnement**
   - Créez `.env` à la racine
   - Copiez depuis `.env.example`
   - Remplissez avec vos clés Supabase

### ✅ Étape 3 : Lancer l'application

```bash
# Option 1 : Mode développement (recommandé)
pnpm dev

# Option 2 : Avec Docker
docker compose up --build
```

### ✅ Étape 4 : Vérifications

#### Test 1 : Health Check
```bash
curl http://localhost:3333/health
```
**Attendu** : `{"status":"ok","timestamp":"..."}`

#### Test 2 : API Sneakers
```bash
curl http://localhost:3333/api/sneakers
```
**Attendu** : Liste de sneakers (vide ou avec données)

#### Test 3 : Frontend
1. Ouvrez http://localhost:3000
2. Créez un compte
3. Connectez-vous
4. Vérifiez le dashboard

#### Test 4 : Documentation API
Ouvrez http://localhost:3333/docs

## 🎮 Scénarios de test

### Scénario A : Parcours utilisateur complet

1. **Inscription**
   - Aller sur http://localhost:3000
   - Cliquer "S'inscrire"
   - Créer un compte (ex: test@example.com / password123)

2. **Connexion**
   - Se connecter avec les identifiants créés
   - Vérifier la redirection vers `/dashboard`

3. **Dashboard**
   - Vérifier que les sneakers s'affichent
   - Tester les filtres (marque, modèle, statut)
   - Cliquer sur une sneaker

4. **Détail sneaker**
   - Vérifier les métriques (prix, trend score, trust score)
   - Vérifier les graphiques (tendance, prix)
   - Vérifier la prévision 7 jours
   - Vérifier les hashtags

### Scénario B : API REST

```bash
# 1. Liste des sneakers
curl http://localhost:3333/api/sneakers

# 2. Détails d'une sneaker (remplacer {id})
curl http://localhost:3333/api/sneakers/{id}

# 3. Tendance d'une sneaker
curl http://localhost:3333/api/sneakers/{id}/trend?days=30

# 4. Documentation
curl http://localhost:3333/docs
```

### Scénario C : Seed de données

```bash
# Générer des données de test
pnpm --filter @sneaker-tracker/backend seed

# Vérifier dans Supabase Dashboard
# → Table "sneakers" devrait contenir 5 sneakers
# → Table "sneaker_data" devrait contenir des données
# → Table "price_history" devrait contenir un historique
```

## 🔍 Points à vérifier

### Backend

- [ ] Health check répond OK
- [ ] API `/api/sneakers` retourne des données
- [ ] Authentification fonctionne (middleware JWT)
- [ ] Rate limiting actif (tester avec 100+ requêtes)
- [ ] Documentation API accessible sur `/docs`

### Frontend

- [ ] Page d'accueil s'affiche
- [ ] Inscription fonctionne
- [ ] Connexion fonctionne
- [ ] Dashboard affiche les sneakers
- [ ] Filtres fonctionnent
- [ ] Page détail sneaker fonctionne
- [ ] Graphiques s'affichent
- [ ] Temps réel fonctionne (si testé avec 2 onglets)

### Base de données

- [ ] Tables créées (sneakers, sneaker_data, price_history, feature_flags)
- [ ] Realtime activé
- [ ] RLS configuré
- [ ] Seed fonctionne (si exécuté)

## 🐛 Problèmes courants

### "pnpm: command not found"
```bash
npm install -g pnpm
```

### "Cannot find module"
```bash
# Nettoyer et réinstaller
rm -rf node_modules apps/*/node_modules libs/*/node_modules
pnpm install
```

### "Supabase connection error"
- Vérifiez que `.env` contient les bonnes clés
- Vérifiez que les migrations sont exécutées
- Vérifiez les politiques RLS dans Supabase

### "Port already in use"
```bash
# Tuer le processus sur le port 3333
lsof -ti:3333 | xargs kill -9

# Ou changer le port dans .env
PORT=3334
```

## 📊 Métriques à surveiller

- **Temps de réponse API** : < 500ms
- **Taux d'erreur** : < 1%
- **Disponibilité** : > 99%
- **Couverture de tests** : ≥ 80%

## 🎯 Checklist finale

Avant de partager avec les testeurs :

- [ ] Tous les tests passent
- [ ] Health checks OK
- [ ] Frontend accessible
- [ ] Authentification fonctionne
- [ ] Dashboard fonctionne
- [ ] API documentée
- [ ] Logs propres (pas d'erreurs critiques)
- [ ] Variables d'environnement configurées
- [ ] Migrations exécutées

## 🚀 C'est parti !

Une fois toutes les vérifications passées, vous pouvez partager l'URL avec vos testeurs.

**Bon test ! 🎉**

