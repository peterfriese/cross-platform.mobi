# cross-platform.mobi

This repo contains the source for my book on cross-platform mobile development.

## Prerequisites

I use [Hakyll](http://jaspervdj.be/hakyll/) to build this book and the accompanying website. In order to build the book yourself, you'll need:

* [Haskell](http://www.haskell.org/)
* Hakyll(http://jaspervdj.be/hakyll/)

## Building

The project comes with a make file to facilitate building. Do one of the following:

* `make build` - builds the static site
* `make preview` - builds the static site and starts a local web server on port 8000
* `make deploy_dev`- builds the static site and uploads it to your development server
* `make deploy` - builds the static site and uploads it to your webserver
* `make publish` - pushes the local repo to Github

In order to deploy to a web server, you need to provide some options - see the beginning of the build script. The scripts logs in to your server using `rsync`/ `scp`. In order to log in without having to nter your password (or storing it in the script). follow the steps outlined in [this post](http://sleeplessgeek.blogspot.de/2011/03/authorizedkeys-and-scp.html) to set up scp to use authorized keys.

## Branches

In order to be able to develop material while at the same time being able to publish stuff, I use the following very simple scheme:

* The `master` branch contains the most current version that can be published.
* The `development` branch contains stuff that is not yet ready for publishing.

Simple, isn't it? I might later add code to the make script to prevent execution of the `publish`target when not on the `master`branch in order to prevent accidentally publishing work in progress material.