## always remember. you need to escape dollar signs. everywhere.

all: kill
	docker-compose run builder
	docker-compose up -d
	2>/dev/null xdg-open "http://localhost:4000"

update:
	docker-compose run builder bundle update

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
