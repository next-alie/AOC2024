#/bin/bash
docker run $(docker build . -q) --module $1
