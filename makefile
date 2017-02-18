SERVE = jekyll serve --detach --incremental


## always remember. you need to escape dollar signs. everywhere.

FTPASSWORD := $(shell security find-internet-password -gs peppelab.altervista.org 2>&1 | grep "password" | sed 's/.*"\(.*\)"/\1/')

FTPOPTIONS = -q ignoremask='^\.|^a$$'


all: kill 
	$(SERVE)
	open 'http://0.0.0.0:4000'

kill:
	pkill -f jekyll || true

build:
	jekyll build --incremental

deploy: build upload

upload:
	@echo "uploading... "
	@ftpsync $(FTPOPTIONS) ./_site ftp://peppelab:$(FTPASSWORD)@peppelab.altervista.org// 

push: deploy
	git push
