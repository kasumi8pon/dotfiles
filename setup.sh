#!/bin/sh

REPO_PREZTO='https://github.com/sorin-ionescu/prezto.git'

if [ ! -d "${HOME}/.zprezto" ] ; then
  git clone --recursive $REPO_PREZTO "${HOME}/.zprezto"
  rm "${HOME}/.zprezto/runcoms/README.md"
  zsh -c 'setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/* ; do ; ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}" ; done'
  git pull && git submodule update --init --recursive
fi

DOTPATH=~/dotfiles
for f in $DOTPATH/.??*
do
    fname=$(basename "$f")
    if [ "$fname" = ".git" ] || [ "$fname" = ".DS_Store" ]; then
        echo "Skipping $fname"
        continue
    else
        echo "Linking $fname"
        ln -snfv "$f" "$HOME/$fname"
    fi
done
