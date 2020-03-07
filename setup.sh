#!/bin/sh

REPO_PREZTO='https://github.com/sorin-ionescu/prezto.git'

if [ ! -d "${HOME}/.zprezto" ] ; then
  git clone --recursive $REPO_PREZTO "${HOME}/.zprezto"
  rm "${HOME}/.zprezto/runcoms/README.md"
  zsh -c 'setopt EXTENDED_GLOB; for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/* ; do ; ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}" ; done'
  git pull && git submodule update --init --recursive
fi

DOTPATH=~/dotfiles
for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    ln -snfv "$DOTPATH/$f" "$HOME"/"$f"
done
