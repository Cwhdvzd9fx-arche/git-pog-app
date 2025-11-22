# Guide de Contribution

Merci de votre intérêt pour contribuer à Sneaker-Trend Tracker ! 🎉

## 🚀 Démarrage rapide

1. Fork le projet
2. Clone votre fork : `git clone https://github.com/votre-username/sneaker-trend-tracker.git`
3. Créez une branche : `git checkout -b feature/ma-fonctionnalite`
4. Installez les dépendances : `pnpm install`
5. Faites vos modifications
6. Testez vos changements : `pnpm test`
7. Committez : `git commit -m "feat: ajout de ma fonctionnalité"`
8. Push : `git push origin feature/ma-fonctionnalite`
9. Ouvrez une Pull Request

## 📝 Standards de code

### Formatage

- Utilisez Prettier : `pnpm format`
- Respectez ESLint : `pnpm lint`

### Conventions de commit

Nous utilisons [Conventional Commits](https://www.conventionalcommits.org/) :

- `feat:` Nouvelle fonctionnalité
- `fix:` Correction de bug
- `docs:` Documentation
- `style:` Formatage (pas de changement de code)
- `refactor:` Refactorisation
- `test:` Tests
- `chore:` Tâches de maintenance

Exemple : `feat(backend): ajout du middleware d'authentification`

### Structure des branches

- `main` - Production
- `develop` - Développement
- `feature/*` - Nouvelles fonctionnalités
- `fix/*` - Corrections de bugs
- `docs/*` - Documentation

## 🧪 Tests

### Tests unitaires

```bash
pnpm --filter @sneaker-tracker/backend test
```

### Tests e2e

```bash
pnpm --filter @sneaker-tracker/frontend test:e2e
```

### Couverture de code

Nous visons une couverture ≥ 80%. Vérifiez avec :

```bash
pnpm --filter @sneaker-tracker/backend test:coverage
```

## 📚 Documentation

- Documentez les nouvelles fonctionnalités
- Mettez à jour le README si nécessaire
- Ajoutez des exemples d'utilisation

## 🔍 Review Process

1. Toutes les PR doivent passer les checks CI
2. Au moins une approbation est requise
3. Les tests doivent passer
4. La couverture de code ne doit pas diminuer

## ❓ Questions ?

Ouvrez une issue pour toute question ou suggestion !

## 📄 Code of Conduct

Soyez respectueux et inclusif. Nous sommes tous ici pour apprendre et construire ensemble.

