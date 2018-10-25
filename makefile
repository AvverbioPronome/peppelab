## always remember. you need to escape dollar signs. everywhere.

FTPASSWORD := $(shell security find-internet-password -gs peppelab.altervista.org 2>&1 | grep "password" | sed 's/.*"\(.*\)"/\1/')

FTPOPTIONS = -q ignoremask='^\.|^a$$'

all: 
	jekyll serve --detach --incremental --open-url

clean:
	jekyll clean

build:  clean
	JEKYLL_ENV=production jekyll build

upload: build
	lftp -f lftp.script

push: upload
	git push github
	git push gitlab
