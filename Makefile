.DEFAULT_GOAL=help
help: ALIGN=32
help: ## pritn this help message
	@awk -F '::? .*## ' -- "/^[^':]+::? .*## /"' { printf "'$$(tput bold)$$(tput setaf 207)'  %-$(ALIGN)s'$$(tput sgr0)' %s\n", $$1, $$2  }' $(MAKEFILE_LIST)

.PHONY: check
check: ## check if all tools are installed
check: check/go
check: check/node
check: check/terraform
check: check/luarocks

.PHONY: check/go
check/go: ## check if go is installed
	$(call check_exists,go)

.PHONY: check/node
check/node: ## check if node is installed
	$(call check_exists,node)

.PHONY: check/terraform
check/terraform: ## check if terraform is installed
	$(call check_exists,terraform)

.PHONY: check/luarocks
check/luarocks: ## check if luarocks is installed
	$(call check_exists,luarocks)

.PHONY: instal
install: ## install tools and lsp servers
install: install/actionlint
install: install/autotools-language-server
install: install/bash-language-server
install: install/buf
install: install/checkmake
install: install/compose-language-service
install: install/copilot-language-server
install: install/gh-actions-language-server
install: install/go-carpet
install: install/go-test-coverage
install: install/golangci-lint-langserver
install: install/markdown-oxide
install: install/markdownlint-cli2
install: install/shellcheck
install: install/shfmt
install: install/sqlfluff
install: install/sqls
install: install/terraform-ls
install: install/viu
install: install/vscode-langserver
install: install/yaml-language-server
install: install/yamlfmt
install: install/yamllint

install/golangci-lint-langserver:
	go install github.com/nametake/golangci-lint-langserver@latest

install/shfmt:
	go install mvdan.cc/sh/v3/cmd/shfmt@latest

install/gh-actions-language-server:
	npm install --global gh-actions-language-server

install/compose-language-service:
	npm install --global @microsoft/compose-language-service

install/bash-language-server:
	npm install --global bash-language-server

install/shellcheck:
	sudo apt install shellcheck

install/yaml-language-server:
	npm install --global yaml-language-server

install/terraform-ls:
	go install github.com/hashicorp/terraform-ls@latest

install/autotools-language-server:
	pipx install autotools-language-server

install/markdown-oxide:
	cargo install --locked --git https://github.com/Feel-ix-343/markdown-oxide.git markdown-oxide

install/buf:
	go install github.com/bufbuild/buf/cmd/buf@latest

install/vscode-langserver:
	npm install --global vscode-langservers-extracted

install/sqlfluff:
	pipx install sqlfluff

install/viu:
	cargo install viu

install/sqls:
	go install github.com/sqls-server/sqls@latest

install/markdownlint-cli2:
	npm install --global markdownlint-cli2

install/copilot-language-server:
	npm install --global @github/copilot-language-server

install/yamlfmt:
	go install github.com/google/yamlfmt/cmd/yamlfmt@latest

install/yamllint:
	pipx install yamllint

install/actionlint:
	go install github.com/rhysd/actionlint/cmd/actionlint@latest

install/checkmake:
	go install github.com/mrtazz/checkmake/cmd/checkmake@latest

install/go-test-coverage:
	go install github.com/vladopajic/go-test-coverage/v2@latest

install/go-carpet:
	go install github.com/msoap/go-carpet@latest


config: ## copy configs
config: config/sqlfluff
config: config/yamllint
config: config/yamlfmt

config/sqlfluff:
	@mkdir -p ~/.config/sqlfluff
	@cp ./config/sqlfluff/* ~/.config/sqlfluff/

config/yamllint:
	@mkdir -p ~/.config/yamllint
	@cp ./config/yamlfmt/* ~/.config//yamlfmt/

config/yamlfmt:
	@mkdir -p ~/.config/yamlfmt
	@cp ./config/yamlfmt/* ~/.config/yamlfmt/

## check if given command exists
define check_exists
	@command -v $1 >/dev/null 2>&1 || { echo >&2 "$1 is not found."; exit 1; }
endef
