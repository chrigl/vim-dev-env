all: ${HOME}/.vimrc ${HOME}/.vim/bundle ${HOME}/.vim/bundle.installed


install_vimrc: ${HOME}/.vimrc vundle_install
make_bundle: ${HOME}/.vim/bundle
vundle_install: 
	vim +PluginInstall +qall

vundle_update:
	vim +PluginUpdate +qall

${HOME}/.vimrc:
	install -m 644 dot_vimrc ${HOME}/.vimrc

${HOME}/.vim/bundle:
	mkdir -p ${HOME}/.vim/bundle

${HOME}/.vim/bundle/Vundle.vim: 
	git clone https://github.com/gmarik/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

${HOME}/.vim/bundle.installed: ${HOME}/.vim/bundle/Vundle.vim
	vim +PluginInstall +qall
	touch ${HOME}/.vim/bundle.installed
