#!/bin/bash

docker rmi $(docker images -f "dangling=true" -q) 2> /dev/null

PROBLEMS=("test1", "test2")
PORT=9000
USER=

for PROBLEM in ${PROBLEMS[@]}
do
    docker build --build-arg PROBLEM=${PROBLEM} --build-arg PORT=${PORT} --build-arg USER=${USER} -t ${PROBLEM} -f Dockerfile .
    docker run --name $PROBLEM -p $PORT:$PORT -i $PROBLEM &

    let PORT=${PORT}+1
done
