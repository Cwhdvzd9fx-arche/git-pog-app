# Fonctionnalités MVP - Sneaker-Trend Tracker

## ✅ Fonctionnalités implémentées

### 1. API REST sécurisée

#### Endpoints disponibles :

- `GET /api/sneakers` - Liste des sneakers avec filtres (brand, model)
- `GET /api/sneakers/:id` - Détails complets d'une sneaker
- `GET /api/sneakers/:id/trend` - Données de tendance sur une période
- `POST /api/sneakers/:id/update` - Déclencher une mise à jour manuelle
- `POST /api/sneakers/:id/process-image` - Traiter une nouvelle image
- `POST /api/webhooks/supabase` - Webhook pour recevoir les mises à jour

#### Données renvoyées :

- **price** : Prix actuel de la sneaker
- **mentions** : Nombre de mentions sur les réseaux sociaux
- **trendScore** : Score de tendance (0-100) calculé à partir de :
  - Mentions (40%)
  - Tendance des prix (30%)
  - Rareté (30%)
- **trustScore** : Score de confiance (0-100) calculé à partir de :
  - Score OCR (50%)
  - Détecteur d'image (30%)
  - Qualité de la source (20%)

### 2. Interface web SSR (Nuxt 3)

#### Pages disponibles :

- `/` - Page d'accueil
- `/login` - Connexion
- `/signup` - Inscription
- `/dashboard` - Tableau de bord principal
- `/sneakers/:id` - Page de détails d'une sneaker

#### Fonctionnalités du tableau de bord :

- ✅ Liste des sneakers avec badges "Hot/Cold/Neutre"
- ✅ Filtres par marque, modèle et statut
- ✅ Affichage des métriques principales (prix, trend score, trust score)
- ✅ Graphique d'évolution de la tendance (30 jours)
- ✅ Historique des prix (90 jours)
- ✅ Prévision de tendance sur 7 jours
- ✅ Liste des hashtags populaires
- ✅ Scores OCR et rareté

### 3. Gestion d'utilisateurs & permissions

- ✅ Authentification via Supabase Auth
- ✅ Inscription/Connexion/Déconnexion
- ✅ Middleware de protection des routes
- ✅ Row Level Security (RLS) configuré dans Supabase
- ✅ Gestion des sessions

### 4. Webhooks & Mises à jour en temps réel

- ✅ Webhook Supabase pour recevoir les notifications
- ✅ Supabase Realtime activé pour les tables :
  - `sneaker_data`
  - `price_history`
  - `sneakers`
- ✅ Composable Vue `useRealtime` pour s'abonner aux changements
- ✅ Mise à jour automatique du frontend lors des changements

## 🔧 Services backend

### TrendCalculatorService

Calcule le score de tendance d'une sneaker basé sur :
- Les mentions sur les réseaux sociaux
- La tendance des prix
- La rareté

### TrustCalculatorService

Calcule le score de confiance basé sur :
- Le score OCR (qualité de l'extraction de texte)
- Le détecteur d'image (confiance dans la détection)
- La qualité de la source

### SocialMediaService

Collecte les mentions sur les réseaux sociaux :
- Instagram
- Twitter
- TikTok
- Reddit

**MVP** : Simulation avec données factices
**TODO** : Intégrer les vraies APIs

### OcrService

Analyse les images pour :
- Extraire le texte (marque, modèle)
- Détecter les objets (sneakers, logos)
- Calculer un score de confiance

**MVP** : Simulation avec données factices
**TODO** : Intégrer Google Cloud Vision API / AWS Rekognition

### SneakerDataService

Orchestre la collecte et le traitement des données :
- Collecte des mentions
- Analyse OCR des images
- Calcul des scores
- Persistance dans Supabase

## 📊 Jobs & Workers

### CollectSneakerDataJob

Job pour collecter automatiquement les données :
- Met à jour toutes les sneakers actives
- Collecte les mentions
- Calcule les scores
- Sauvegarde dans la base

**À exécuter** : Via cron job ou queue (ex: Bull, BullMQ)

## 🚀 Prochaines étapes

### Intégrations à faire :

1. **APIs Réseaux sociaux** :
   - Instagram Graph API
   - Twitter API v2
   - TikTok API
   - Reddit API

2. **Services OCR** :
   - Google Cloud Vision API
   - AWS Rekognition
   - Azure Computer Vision

3. **APIs de prix** :
   - StockX API
   - GOAT API
   - Flight Club API
   - Stadium Goods API

4. **Queue system** :
   - Bull/BullMQ pour les jobs asynchrones
   - Cloud Tasks (Google Cloud)
   - SQS (AWS)

5. **Notifications** :
   - Push notifications
   - Email alerts
   - Webhooks personnalisés

## 📝 Notes MVP

- Les services d'intégration (réseaux sociaux, OCR) sont simulés avec des données factices
- Les calculs de scores sont fonctionnels et peuvent être ajustés
- L'architecture est prête pour intégrer les vraies APIs
- Le système de webhooks et temps réel est opérationnel

