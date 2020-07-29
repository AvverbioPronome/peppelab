## always remember. you need to escape dollar signs. everywhere.

all: kill
	docker-compose up -d && xdg-open "http://localhost:4000"

clean: kill
	docker-compose run builder jekyll clean

kill:
	docker-compose down

build: clean
	docker-compose run -e JEKYLL_ENV=production builder

upload: build
	lftp -f lftp.script #&& make purge_cache

push: upload
	git push github
	git push gitlab
	git push bitbucket
