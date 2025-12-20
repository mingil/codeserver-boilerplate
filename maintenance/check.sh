#!/bin/bash
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'
echo -e "${BLUE}🛡️ [DTx Maintenance] SYSTEM CHECK${NC}"
if [[ "$SHELL" == *"zsh"* ]]; then echo -e "${GREEN}✅ Shell${NC}"; else echo -e "${RED}❌ Shell${NC}"; fi
if ! sudo -n true 2>/dev/null; then echo -e "${GREEN}✅ Secure Sudo${NC}"; else echo -e "${RED}❌ Insecure Sudo${NC}"; fi
if docker ps &> /dev/null; then echo -e "${GREEN}✅ Docker${NC}"; else echo -e "${RED}❌ Docker${NC}"; fi
if command -v python3 &>/dev/null; then echo -e "${GREEN}✅ Python${NC}"; else echo -e "${RED}❌ Python${NC}"; fi
