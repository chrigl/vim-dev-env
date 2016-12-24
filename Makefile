all: ${HOME}/.vimrc ${HOME}/.vim/bundle ${HOME}/.vim/vim-go ${HOME}/.vim/bundle.installed


install_vimrc: ${HOME}/.vimrc vundle_install
make_bundle: ${HOME}/.vim/bundle
vundle_install: 
	vim +PluginInstall +qall

vundle_update:
	vim +PluginUpdate +qall


go_install_binaries:
	GOPATH=${HOME}/.vim/vim-go/vendor:${HOME}/.vim/vim-go vim +GoInstallBinaries +qall

${HOME}/.vimrc:
	install -m 644 dot_vimrc ${HOME}/.vimrc

${HOME}/.vim/bundle:
	mkdir -p ${HOME}/.vim/bundle

${HOME}/.vim/vim-go:
	mkdir -p ${HOME}/.vim/vim-go

${HOME}/.vim/bundle/Vundle.vim: 
	git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

${HOME}/.vim/bundle.installed: ${HOME}/.vim/bundle/Vundle.vim vundle_install go_install_binaries
	touch ${HOME}/.vim/bundle.installed
