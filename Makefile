.DEFAULT_GOAL := prod

.PHONY: install
install:
	echo
.PHONY: format
format:
	eslint --fix "src/**/*.{js,ts,vue}"
	prettier src/**/*.vue --parser=vue --write

.PHONY: lint
lint:
	eslint "src/**/*.{js,ts,vue}"
	prettier src/**/*.vue --check

.PHONY: build
build: lint
	NODE_OPTIONS=--max_old_space_size=24096;quasar build --debug

.PHONY: build-pwa
build-pwa: lint audit
	NODE_OPTIONS=--max_old_space_size=24096;quasar build -m pwa

.PHONY: clean
clean:
	quasar clean

.PHONY: dev
dev:
	( quasar dev --debug)

.PHONY: pwa
pwa:
	quasar dev -m pwa

.PHONY: update
update:
	( pnpm update --save; git diff package.json )

.PHONY: audit
audit:
	@pnpm audit -prod

.PHONY: all
all: clean update lint format build
	git status
