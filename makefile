all:
	echo "make push to deploy"

push:
	git push && ./push-to-ftp.sh
