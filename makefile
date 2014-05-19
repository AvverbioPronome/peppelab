SERVE = jekyll serve --detach


## always remember. you need to escape dollar signs. everywhere.

FTPASSWORD := $(shell security find-internet-password -gs peppelab.altervista.org 2>&1 >/dev/null | sed 's/.*"\(.*\)"[^"]*$$/\1/')

FTPOPTIONS = -q ignoremask='^\.|^a$$|^storiarte$$'


all: kill 
	$(SERVE)
	open 'http://0.0.0.0:4000'

kill:
	killall -9 '$(SERVE)' || true

build:
	jekyll build

deploy: build
	@echo "uploading... "
	@ftpsync $(FTPOPTIONS) ./_site ftp://peppelab:$(FTPASSWORD)@peppelab.altervista.org// 

push: deploy
	git push
