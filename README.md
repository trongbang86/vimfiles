http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen/

SETUP:

cd ~
git clone https://github.com/trongbang86/vimfiles ~/.vim
ln -s ~/.vim/vimrc ~/.vimrc
ln -s ~/.vim/gvimrc ~/.gvimrc
cd ~/.vim
git submodule init
git submodule update

git submodule foreach git pull origin master

