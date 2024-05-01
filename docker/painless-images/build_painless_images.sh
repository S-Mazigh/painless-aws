#!/bin/sh

docker build -t satcomp-painless:common --file common/Dockerfile .
docker build -t satcomp-painless:leader  --file leader/Dockerfile .
docker build -t satcomp-painless:worker  --file worker/Dockerfile .