#!/bin/sh

docker build --no-cache -t satcomp-painless:common --file common/Dockerfile .
docker build --no-cache -t satcomp-painless:leader --file leader/Dockerfile .
docker build --no-cache -t satcomp-painless:worker --file worker/Dockerfile .