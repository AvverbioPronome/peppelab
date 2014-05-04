all:
	jekyll build && echo "make push to deploy"

push:
	git push && ./deploy.sh
