## always remember. you need to escape dollar signs. everywhere.

FTPASSWORD := $(shell security find-internet-password -gs peppelab.altervista.org 2>&1 | grep "password" | sed 's/.*"\(.*\)"/\1/')

FTPOPTIONS = -q ignoremask='^\.|^a$$'

all: kill
	jekyll serve --detach --incremental
	open 'http://0.0.0.0:4000'

kill:
	cp _sass/bootstrap/dist/js/bootstrap.min.js files/
	pkill -f jekyll || true

clean:
	jekyll clean

build: kill clean
	JEKYLL_ENV=production jekyll build

upload: build
	@echo "uploading... "
	@ftpsync $(FTPOPTIONS) ./_site ftp://peppelab:$(FTPASSWORD)@ftp.peppelab.altervista.org// 

push: upload
	git push github
	git push gitlab
