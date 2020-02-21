VIM_GO_VERSION=v1.22
VIM_GO_CHECK_PREFIX=${HOME}/.vim/bundle-vim-go
VIM_GO_CHECKFILE=${VIM_GO_CHECK_PREFIX}-${VIM_GO_VERSION}
GOPLS_BIN=${HOME}/go/bin/gopls

.PHONY: all install_vimrc make_bundle vundle_install vundle_update go_install_binaries go_update_binaries update
all: ${HOME}/.vimrc ${HOME}/.vim/bundle ${HOME}/.vim/bundle.installed

install_vimrc: ${HOME}/.vimrc vundle_install
make_bundle: ${HOME}/.vim/bundle
vundle_install: ${HOME}/.vim/bundle/vim-fugitive

${HOME}/.vim/bundle/vim-fugitive:
	vim +PluginInstall +qall

vundle_update:
	vim +PluginUpdate +qall

go_install_binaries: ${GOPLS_BIN}

go_update_binaries:
	GOPATH=${HOME}/go GO111MODULE=on vim +GoInstallBinaries +qall

update: vundle_update go_update_binaries

${VIM_GO_CHECKFILE}: ${HOME}/.vim/bundle
	if test -f ${HOME}/.vim/bundle/vim-go/README.md; then \
		cd ${HOME}/.vim/bundle/vim-go; \
		git checkout ${VIM_GO_VERSION}; \
	else \
		git clone --branch ${VIM_GO_VERSION} https://github.com/fatih/vim-go.git ${HOME}/.vim/bundle/vim-go; \
	fi;
	rm  -f ${VIM_GO_CHECK_PREFIX}-*
	touch ${VIM_GO_CHECKFILE}

${GOPLS_BIN}: ${VIM_GO_CHECKFILE}
	GOPATH=${HOME}/go GO111MODULE=on vim +GoInstallBinaries +qall
	test -f ${GOPLS_BIN} && touch ${GOPLS_BIN}

${HOME}/.vimrc:
	install -m 644 dot_vimrc ${HOME}/.vimrc

${HOME}/.vim/bundle:
	mkdir -p ${HOME}/.vim/bundle

${HOME}/.vim/bundle/Vundle.vim: 
	git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim

${HOME}/.vim/bundle.installed: ${HOME}/.vim/bundle/Vundle.vim ${HOME}/.vim/bundle/vim-fugitive ${GOPLS_BIN}
	touch ${HOME}/.vim/bundle.installed
