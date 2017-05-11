## always remember. you need to escape dollar signs. everywhere.

FTPASSWORD := $(shell security find-internet-password -gs peppelab.altervista.org 2>&1 | grep "password" | sed 's/.*"\(.*\)"/\1/')

FTPOPTIONS = -q ignoremask='^\.|^a$$'

## The difference between _config and _config-local is one:
## _config-local disables any output compression, so compilation is
## much quicker

all: kill 
	jekyll serve --detach --incremental --config _config-local.yml
	open 'http://0.0.0.0:4000'

kill:
	pkill -f jekyll || true

build: kill
	jekyll build --config _config.yml

upload: build
	@echo "uploading... "
	@ftpsync $(FTPOPTIONS) ./_site ftp://peppelab:$(FTPASSWORD)@ftp.peppelab.altervista.org// 

push: deploy
	git push
