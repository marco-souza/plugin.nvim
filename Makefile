# plugin.nvim — make targets
#
#   make help        — list targets
#   make install     — install nvim + stylua + luacheck
#   make tests       — run the specs (needs nvim)
#   make fmt          — format lua/ with stylua
#   make fmt-check    — check formatting without writing
#   make lint         — luacheck
#   make rename NAME=you/plugin.nvim — rename the template
#   make pr-ready     — fmt-check, lint, tests

NAME ?= marco-souza/plugin.nvim

.PHONY: help install tests fmt fmt-check lint rename pr-ready

help: ## show this help
	@grep -E '^[a-zA-Z_-]+:.*?## ' $(MAKEFILE_LIST) | \
	  awk 'BEGIN{FS=":.*?## "}{printf "  \033[36m%-14s\033[0m %s\n",$$1,$$2}'

install: ## install toolchain
	@echo "===> Installing stylua + luacheck (needs cargo) or luarocks"
	cargo install stylua || luarocks install stylua
	luarocks install luacheck

tests: ## run specs with plenary (auto-bootstrapped)
	@echo "===> Tests"
	nvim --headless -c 'luafile tests/bootstrap.lua' -c 'PlenaryBustedDirectory tests/'

fmt: ## format
	stylua lua/ --config-path=.stylua.toml

fmt-check: ## check formatting
	stylua --check lua/ --config-path=.stylua.toml

lint: ## lint
	luacheck lua/ --globals vim

rename: ## rename the template; usage: make rename NAME=you/plugin.nvim
	@./scripts/rename.sh $(NAME)

pr-ready: fmt-check lint tests ## prep PR (fmt-check, lint, tests)