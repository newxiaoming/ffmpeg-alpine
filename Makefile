# created at 2021-06-03
PROJECT=yijuan-client-front
GIT_PROD_BRANCH="master"
GIT_DEVELOP_BRANCH="develop"
DOCKER_REPO_NAMESPACE="mynew5tt"
DOCEER_REPO_PROVIDER="registry.cn-shenzhen.aliyuncs.com"
DOMAIN=

BUILDTIME=$(shell echo `date +%FT%T%z`)
BUILDTIME_VERSION=$(shell echo `date +%Y%m%d%H%M`)
GITREV=$(shell echo `git rev-parse --short HEAD`)
GIT_CURRENT_BRANCH=$(shell echo `git rev-parse --abbrev-ref HEAD`)
DOCKER_REPO="${DOCEER_REPO_PROVIDER}/${DOCKER_REPO_NAMESPACE}/$(PROJECT)"
VERSION=$(shell echo `git describe --abbrev=0`)

buildfile:
	echo "git current branch is "$(GIT_CURRENT_BRANCH)
	@touch buildfile.json
	$(eval VERSION := $(BUILDTIME_VERSION)-$(GIT_CURRENT_BRANCH))
	@echo "{\"image\": \""$(DOCKER_REPO)"\", \"tag\": \""$(VERSION)"\", \"project\": \""$(PROJECT)"\"}" > buildfile.json

docker:buildfile
	$(eval VERSION := $(shell cat buildfile.json | sed 's/,/\n/g' |grep tag  |sed 's/:/\n/g' | sed '1d' | sed 's/"//g' | sed "s/,//g"))
	docker build --force-rm --rm --tag $(DOCKER_REPO):"$(VERSION)" .

push:
	$(eval VERSION := $(shell cat buildfile.json | sed 's/,/\n/g' |grep tag  |sed 's/:/\n/g' | sed '1d' | sed 's/"//g' | sed "s/,//g"))
	@docker push $(DOCKER_REPO):$(VERSION)