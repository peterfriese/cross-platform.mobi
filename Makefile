SERVER = ssh.strato.de
USERNAME = peterfriese.de
NAME = cross-platform.mobi
DEPLOY_PATH = /mnt/weba/12/59/51205159/htdocs/sites/$(NAME)
DEV_NAME = dev.cross-platform.mobi
DEV_DEPLOY_PATH = /mnt/weba/12/59/51205159/htdocs/sites/$(DEV_NAME)
DEPLOY_OPTIONS = -az --checksum --delete --chmod=Du=rwx,Dgo=rx,Fu=rwx,Fgo=r
TMP = /tmp/

all:
	@echo "Makefile specifies the following tasks:\n"
	@echo "make\t\tCompile $(NAME).hs"
	@echo "build\t\tCompile the site"
	@echo "preview\t\tAuto-compile and preview the site on port 8000"
	@echo "deploy\t\tDeploy onto specified server"
	@echo "publish\t\tDeploy and push repository"

make:
	@ghc --make $(NAME).hs -outputdir $(TMP)$(NAME)/ -o $(TMP)$(NAME).hakyll

build: make
	@$(TMP)$(NAME).hakyll rebuild

preview: make
	@$(TMP)$(NAME).hakyll clean
	@$(TMP)$(NAME).hakyll preview

deploy: build
	@echo "Deploying as $(NAME)..."
	@rsync $(DEPLOY_OPTIONS) _site/ $(SERVER):$(DEPLOY_PATH)/

deploy_dev: build
	@echo "Deploying as $(DEV_NAME)..."
	@rsync $(DEPLOY_OPTIONS) _site/ $(USERNAME)@$(SERVER):$(DEV_DEPLOY_PATH)/

publish: deploy
	@echo "Pushing repository..."
	@git push origin

.PHONY: all make build preview deploy deploy_dev publish