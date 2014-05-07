SERVE = jekyll serve --detach

all: kill 
	$(SERVE)
	open 'http://0.0.0.0:4000'

kill:
	killall -9 '$(SERVE)' || true

build:
	jekyll build

deploy: build
	./deploy.sh

push: deploy
	git push
