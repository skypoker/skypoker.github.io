GIT_REMOTE := $(shell git config remote.origin.url)

build:
	bundle exec jekyll contentful || true

travis: build
ifeq ($(TRAVIS_PULL_REQUEST), true)
	@echo 'Travis target not executed for pull requests.'
else
	git config user.name $(GIT_NAME)
	git config user.email $(GIT_EMAIL)
	git add -f _data
	git commit -m 'Updated GitHub Pages'

	git push -fq "https://$(GIT_TOKEN)@$(word 2,$(subst ://, ,$(GIT_REMOTE)))" HEAD:refs/heads/$(GIT_BRANCH)
endif
