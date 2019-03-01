#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
ROOT_DIR="$( dirname "${SCRIPT_DIR}" )"

# Copy Papyrus bridge contracts settings
cp ${SCRIPT_DIR}/papyrus-bridge-contracts.env ${ROOT_DIR}/deploy/.env

# Set up docker image for deploying Papyrus bridge contracts
( cd ${ROOT_DIR} && docker-compose build )

# Compile and deploy Papyrus bridge contracts
( cd ${ROOT_DIR} && docker-compose run --name papyrus-bridge-contracts-deployer bridge-contracts deploy.sh )

# Prepare output directory to store useful files from docker container
rm -rf ${ROOT_DIR}/output 2> /dev/null
mkdir ${ROOT_DIR}/output

# Copy useful files from docker container to output directory
docker cp papyrus-bridge-contracts-deployer:/contracts/build ${ROOT_DIR}/output/build
docker cp papyrus-bridge-contracts-deployer:/contracts/flats ${ROOT_DIR}/output/flats
docker cp papyrus-bridge-contracts-deployer:/contracts/deploy/bridgeDeploymentResults.json ${ROOT_DIR}/output/deploy-result.json

# Also save log to a file
docker logs papyrus-bridge-contracts-deployer > ${ROOT_DIR}/output/deploy.log

# Stop and remove docker container
( cd ${ROOT_DIR} && docker-compose down )