# Guide de Déploiement

## 🌍 Environnements

| Environnement | GCP Project | Cloud Run Service | URL |
|---------------|-------------|-------------------|-----|
| **Staging**   | `sneaker-tracker-stg` | `sneaker-api-stg` | `https://api-stg.example.com` |
| **Production** | `sneaker-tracker-prd` | `sneaker-api` | `https://api.example.com` |

## 🔐 Variables d'environnement

### Staging

Variables stockées dans GCP Secret Manager :

- `SUPABASE_URL`
- `SUPABASE_ANON_KEY`
- `SUPABASE_SERVICE_ROLE_KEY`
- `APP_KEY`
- `SENTRY_DSN`
- `REDIS_HOST`
- `REDIS_PASSWORD`

### Production

Mêmes variables que staging, avec des valeurs différentes.

## 🚀 Déploiement

### Via Cloud Build (automatique)

1. **Staging** : Push sur `develop` → Déploiement automatique
2. **Production** : Tag `v*` → Déploiement automatique

### Manuel

```bash
# Build
gcloud builds submit --config cloudbuild.yaml

# Deploy staging
gcloud run deploy sneaker-api-stg \
  --image gcr.io/sneaker-tracker-stg/backend:latest \
  --region europe-west1 \
  --platform managed

# Deploy production
gcloud run deploy sneaker-api \
  --image gcr.io/sneaker-tracker-prd/backend:latest \
  --region europe-west1 \
  --platform managed
```

## 🔄 Rollback

### Via Cloud Console

1. Aller dans Cloud Run
2. Sélectionner le service
3. Cliquer sur "Revisions"
4. Sélectionner une ancienne révision
5. Cliquer sur "Manage Traffic" → "100%"

### Via CLI

```bash
gcloud run services update-traffic sneaker-api \
  --to-revisions PREVIOUS_REVISION=100 \
  --region europe-west1
```

## ✅ Vérifications post-déploiement

1. **Health check** :
```bash
curl https://api.example.com/health
```

2. **Vérifier les logs** :
```bash
gcloud logging read "resource.type=cloud_run_revision" --limit 50
```

3. **Vérifier Sentry** : Aucune erreur critique

4. **Vérifier les métriques** :
   - Taux d'erreur < 1%
   - Latence p95 < 500ms
   - Disponibilité > 99.9%

## 🔍 Monitoring

### Cloud Monitoring

- Dashboard : `https://console.cloud.google.com/monitoring`
- Alertes configurées pour :
  - Taux d'erreur > 5%
  - Latence p95 > 1s
  - Disponibilité < 99%

### Sentry

- Dashboard : `https://sentry.io/organizations/your-org/projects/`
- Alertes pour les erreurs critiques

## 📊 Backup & Restore

### Backup Supabase

```bash
# Backup
supabase db dump -f backup_$(date +%Y%m%d).sql

# Restore
supabase db reset
psql -h db.xxx.supabase.co -U postgres -d postgres < backup_20240101.sql
```

### Backup automatique

Configuré via Cloud Scheduler (quotidien à 2h du matin).

## 🚨 Procédure d'urgence

1. **Incident détecté** → Vérifier les logs
2. **Rollback immédiat** si nécessaire
3. **Notification** de l'équipe
4. **Post-mortem** dans les 48h

## 📝 Checklist de déploiement

- [ ] Tests passent localement
- [ ] CI/CD passe
- [ ] Secrets à jour dans Secret Manager
- [ ] Migration DB exécutée (si nécessaire)
- [ ] Health checks OK
- [ ] Monitoring actif
- [ ] Documentation à jour

