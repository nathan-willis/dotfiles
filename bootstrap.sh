#!/bin/bash
# bootstrap.sh — setup dotfiles and Vim plugins

# --- Symlink configs ---
ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# --- Install vim-plug ---
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# --- Install Vim plugins ---
vim +PlugInstall +qall

echo "Bootstrap complete!"
