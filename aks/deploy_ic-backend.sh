#!/bin/bash

echo "Construyendo imagen de docker!:"
docker build . -t ic-backend:v0.1

echo "Haciendo tag:"
docker tag ic-backend:v0.1 ripleycontainerregistry.azurecr.io/ic-backend:v0.1

echo "Subiendo al ACR:"

docker push ripleycontainerregistry.azurecr.io/ic-backend:v0.1