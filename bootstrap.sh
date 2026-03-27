#!/bin/bash
# bootstrap.sh — safe setup for dotfiles and Vim plugins

# --- Helper function to backup existing files ---
backup_file() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        local backup="${file}.backup.$(date +%Y%m%d%H%M%S)"
        echo "Backing up $file → $backup"
        mv "$file" "$backup"
    fi
}

# --- Symlink configs safely ---
configs=(.vimrc .tmux.conf)
for cfg in "${configs[@]}"; do
    backup_file "$HOME/$cfg"
    ln -sf "$HOME/dotfiles/$cfg" "$HOME/$cfg"
    echo "Linked $cfg"
done

# --- Install vim-plug if missing ---
if [ ! -f "$HOME/.vim/autoload/plug.vim" ]; then
    echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# --- Install Vim plugins ---
echo "Installing Vim plugins..."
vim +PlugInstall +qall

echo "Bootstrap complete!"
