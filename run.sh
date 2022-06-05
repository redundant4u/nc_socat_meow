#!/bin/bash

docker rmi $(docker images -f "dangling=true" -q) 2> /dev/null

NC_PROBLEMS=("canary" "simple_bof" "fsb" "rop" "pie" "64bof")
PORT=9000
USER=keeper

for PROBLEM in ${NC_PROBLEMS[@]}
do
	docker build --build-arg PROBLEM=${PROBLEM} --build-arg PORT=${PORT} --build-arg USER=${USER} -t ${PROBLEM} -f Dockerfile.nc .
	docker run --name $PROBLEM -p $PORT:$PORT -i $PROBLEM &

	let PORT=${PORT}+1
done

###########################################################

PYTHON_PROBLEMS=("basic_zkp")

for PROBLEM in ${PYTHON_PROBLEMS[@]}
do
	docker build --build-arg PROBLEM=${PROBLEM} --build-arg PORT=${PORT} --build-arg USER=${USER} -t ${PROBLEM} -f Dockerfile.python .
	docker run --name $PROBLEM -p $PORT:$PORT -i $PROBLEM &

	let PORT=${PORT}+1

done

###########################################################

FLASK_PROBLEMS=("goback")

for PROBLEM in ${FLASK_PROBLEMS[@]}
do
	docker build --build-arg PROBLEM=${PROBLEM} --build-arg PORT=${PORT} --build-arg USER=${USER} -t ${PROBLEM} -f Dockerfile.flask .
	docker run --name $PROBLEM -p $PORT:$PORT -i $PROBLEM &

	let PORT=${PORT}+1

done

###########################################################

PHP_PROBLEMS=("xmlparser" "keeper_bird" "obfuscation" "shop" "lord")

for PROBLEM in ${PHP_PROBLEMS[@]}
do
	docker build --build-arg PROBLEM=${PROBLEM} --build-arg PORT=${PORT} --build-arg USER=${USER} -t ${PROBLEM} -f Dockerfile.php .
	docker run --name $PROBLEM -p $PORT:$PORT -i $PROBLEM &

	let PORT=${PORT}+1

done
