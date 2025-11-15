#!/usr/bin/env bash

DOTFILES="$HOME/.dotfiles"
ALIASES="$DOTFILES/aliases"
LINK="$HOME/.aliases"
ZSHRC="$HOME/.zshrc"
BASHRC="$HOME/.bashrc"

#########################################
# 1. Criar diretório .dotfiles se não existir
#########################################
if [ ! -d "$DOTFILES" ]; then
  mkdir -p "$DOTFILES"
  echo "✔ Criado diretório: $DOTFILES"
fi

#########################################
# 2. Criar arquivo aliases se não existir
#########################################
if [ ! -f "$ALIASES" ]; then
  echo "# Meus atalhos" > "$ALIASES"
  echo "✔ Criado: $ALIASES"
fi

#########################################
# 3. Criar/atualizar symlink ~/.aliases
#########################################
if [ -e "$LINK" ] || [ -L "$LINK" ]; then
  rm -f "$LINK"
fi
ln -s "$ALIASES" "$LINK"
echo "✔ Symlink criado: ~/.aliases -> $ALIASES"

#########################################
# 4. Garantir que ZSH carregue ~/.aliases
#########################################
if [ -f "$ZSHRC" ]; then
  if ! grep -q "source ~/.aliases" "$ZSHRC"; then
    echo "" >> "$ZSHRC"
    echo "# Carregar aliases personalizados" >> "$ZSHRC"
    echo "[ -f ~/.aliases ] && source ~/.aliases" >> "$ZSHRC"
    echo "✔ Adicionado no .zshrc"
  else
    echo "ℹ .zshrc já contém 'source ~/.aliases'"
  fi
fi

#########################################
# 5. Garantir que Bash carregue ~/.aliases
#########################################
if [ -f "$BASHRC" ]; then
  if ! grep -q "source ~/.aliases" "$BASHRC"; then
    echo "" >> "$BASHRC"
    echo "# Carregar aliases personalizados" >> "$BASHRC"
    echo "[ -f ~/.aliases ] && source ~/.aliases" >> "$BASHRC"
    echo "✔ Adicionado no .bashrc"
  else
    echo "ℹ .bashrc já contém 'source ~/.aliases'"
  fi
fi

echo ""
echo "🎉 Configuração concluída!"
echo "Execute 'source ~/.zshrc' ou 'source ~/.bashrc' para aplicar as mudanças"
