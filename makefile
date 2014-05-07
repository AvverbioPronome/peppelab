SERVE = jekyll serve --detach

all: kill 
	$(SERVE)
	open 'http://0.0.0.0:4000'

kill:
	killall -9 '$(SERVE)' || echo 0

build:
	jekyll build

deploy: build
	./deploy.sh

push: deploy
	git push
