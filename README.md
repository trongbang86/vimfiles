http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/

SETUP:

1. cd ~
2. git clone https://github.com/trongbang86/vimfiles ~/.vim
3. ln -s ~/.vim/vimrc ~/.vimrc
4. ln -s .vim/common_keys.vim ~/common_keys.vim
5. ln -s ~/.vim/gvimrc ~/.gvimrc
6. cd ~/.vim
7. git submodule init
8. git submodule update
9. touch ~/.vimrc_after

git submodule foreach git pull origin master

