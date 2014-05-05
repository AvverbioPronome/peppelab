SERVE = jekyll serve --detach

all: 
	killall -9 '$(SERVE)' || echo 0
	$(SERVE)
	open 'http://0.0.0.0:4000'

build:
	jekyll build

deploy: build
	./deploy.sh

push: deploy
	git push
