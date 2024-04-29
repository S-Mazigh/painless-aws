#!/bin/sh

docker build --rm --no-cache -t satcomp-painless:common ../../ --file common/Dockerfile
docker build --rm --no-cache -t satcomp-painless:leader ../../ --file leader/Dockerfile
docker build --rm --no-cache -t satcomp-painless:worker ../../ --file worker/Dockerfile