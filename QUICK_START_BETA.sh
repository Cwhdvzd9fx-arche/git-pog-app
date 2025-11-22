#!/bin/bash

# Script de démarrage rapide pour la beta
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🚀 Démarrage de la beta Sneaker-Trend Tracker${NC}"
echo ""

# 1. Installer pnpm si nécessaire
if ! command -v pnpm &> /dev/null; then
    echo "📦 Installation de pnpm..."
    npm install -g pnpm || {
        echo "❌ Impossible d'installer pnpm. Installez-le manuellement : npm install -g pnpm"
        exit 1
    }
fi

echo -e "${GREEN}✅ pnpm: $(pnpm -v)${NC}"

# 2. Installer les dépendances
if [ ! -d "node_modules" ]; then
    echo ""
    echo "📦 Installation des dépendances..."
    pnpm install
    echo -e "${GREEN}✅ Dépendances installées${NC}"
else
    echo -e "${GREEN}✅ Dépendances déjà installées${NC}"
fi

# 3. Vérifier .env
if [ ! -f ".env" ]; then
    echo ""
    echo -e "${YELLOW}⚠️  Fichier .env non trouvé${NC}"
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo -e "${YELLOW}📝 Fichier .env créé. Veuillez le remplir avec vos clés Supabase !${NC}"
        echo ""
        echo "Appuyez sur Entrée après avoir configuré .env..."
        read
    fi
fi

# 4. Build de la librairie partagée
echo ""
echo "🔨 Build de la librairie partagée..."
pnpm --filter @sneaker-tracker/shared build 2>/dev/null || echo -e "${YELLOW}⚠️  Build shared (peut être normal)${NC}"

echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}✨ Prêt à démarrer !${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo "Prochaines étapes :"
echo ""
echo "1️⃣  Configurez Supabase :"
echo "   - Créez un projet sur supabase.com"
echo "   - Exécutez les migrations SQL (voir supabase/migrations/)"
echo "   - Remplissez .env avec vos clés"
echo ""
echo "2️⃣  (Optionnel) Seed de données :"
echo "   pnpm --filter @sneaker-tracker/backend seed"
echo ""
echo "3️⃣  Lancez l'application :"
echo "   pnpm dev"
echo ""
echo "4️⃣  Testez :"
echo "   - Frontend: http://localhost:3000"
echo "   - Backend:  http://localhost:3333"
echo "   - Health:   http://localhost:3333/health"
echo ""

