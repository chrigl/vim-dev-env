VIM_GO_VERSION=v1.22

.PHONY: all install_vimrc make_bundle vundle_install vundle_update go_install_binaries go_update
all: ${HOME}/.vimrc ${HOME}/.vim/bundle ${HOME}/.vim/vim-go ${HOME}/.vim/bundle.installed

install_vimrc: ${HOME}/.vimrc vundle_install
make_bundle: ${HOME}/.vim/bundle
vundle_install: ${HOME}/.vim/bundle/vim-fugitive

${HOME}/.vim/bundle/vim-fugitive:
	vim +PluginInstall +qall

vundle_update:
	vim +PluginUpdate +qall

go_install_binaries: ${HOME}/go/bin/gopls

go_update_binaries:
	GOPATH=${HOME}/go GO111MODULE=on vim +GoInstallBinaries +qall

update: vundle_update go_update_binaries

${HOME}/.vim/bundle/vim-go/running-${VIM_GO_VERSION}: ${HOME}/.vim/bundle
	if test -f ${HOME}/.vim/bundle/vim-go/README.md; then \
		cd ${HOME}/.vim/bundle/vim-go; \
		git checkout ${VIM_GO_VERSION}; \
	else \
		git clone --branch ${VIM_GO_VERSION} https://github.com/fatih/vim-go.git ${HOME}/.vim/bundle/vim-go; \
	fi;
	rm  -f ${HOME}/.vim/bundle/vim-go/running-*
	touch ${HOME}/.vim/bundle/vim-go/running-${VIM_GO_VERSION}

${HOME}/go/bin/gopls: ${HOME}/.vim/bundle/vim-go/running-${VIM_GO_VERSION}
	GOPATH=${HOME}/go GO111MODULE=on vim +GoInstallBinaries +qall
	touch ${HOME}/go/bin/gopls

${HOME}/.vimrc:
	install -m 644 dot_vimrc ${HOME}/.vimrc

${HOME}/.vim/bundle:
	mkdir -p ${HOME}/.vim/bundle

${HOME}/.vim/vim-go:
	mkdir -p ${HOME}/.vim/vim-go

${HOME}/.vim/bundle/Vundle.vim: 
	git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

${HOME}/.vim/bundle.installed: ${HOME}/.vim/bundle/Vundle.vim ${HOME}/.vim/bundle/vim-fugitive ${HOME}/go/bin/gopls
	touch ${HOME}/.vim/bundle.installed
