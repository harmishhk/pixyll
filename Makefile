.PHONY: all update build deploy

SOURCE := /writing/notes
SERVER := user@ssh.server.com
DEST := /net/notes

all: update build deploy

update:
	rm -rf _posts/*
	cp -rp  $(SOURCE)/* _posts/

build:
	jekyll build

deploy:
	ssh $(SERVER) 'rm -rf $(DEST)/*'
	scp -rp _site/* $(SERVER):$(DEST)/
