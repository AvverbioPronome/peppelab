## always remember. you need to escape dollar signs. everywhere.

all: kill
	jekyll serve --detach --incremental --open-url

clean: kill
	jekyll clean

kill:
	killall -9 jekyll || true

build: clean
	JEKYLL_ENV=production jekyll build

upload: build
	lftp -f lftp.script && make purge_cache

push: upload
	git push github
	git push gitlab
	git push bitbucket

purge_cache:
	curl -X DELETE "https://api.cloudflare.com/client/v4/zones/${CF_PEPPELAB_ZONEID}/purge_cache" \
	-H "X-Auth-Email: peppelab@altervista.org" \
	-H "X-Auth-Key: ${CF_PEPPELAB_APIKEY}" \
	-H "Content-Type:application/json" \
	--data '{"purge_everything":true}'
