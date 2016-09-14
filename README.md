http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/

SETUP:

1. cd ~
2. git clone https://github.com/trongbang86/vimfiles ~/.vim
3. ln -s ~/.vim/vimrc ~/.vimrc
4. ln -s ~/.vim/gvimrc ~/.gvimrc
5. cd ~/.vim
6. git submodule init
7. git submodule update

git submodule foreach git pull origin master

