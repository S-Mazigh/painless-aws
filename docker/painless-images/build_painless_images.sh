#!/bin/sh

docker build --rm -t satcomp-painless:common ../../ --file common/Dockerfile
docker build --rm -t satcomp-painless:leader ../../ --file leader/Dockerfile
docker build --rm -t satcomp-painless:worker ../../ --file worker/Dockerfile