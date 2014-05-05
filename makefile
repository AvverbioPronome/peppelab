all:
	jekyll build && echo "make push to deploy"

push: all
	git push && ./deploy.sh
