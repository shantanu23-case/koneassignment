#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --tool=*) TOOL="${1#*=}" ;;
        --environment=*) ENVIRONMENT="${1#*=}" ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

case $TOOL in
    docker)
        docker tag my-app:latest $DOCKER_REGISTRY/my-app:$ENVIRONMENT
        docker push $DOCKER_REGISTRY/my-app:$ENVIRONMENT
        ;;
    cdk)
        cdk deploy --context env=$ENVIRONMENT
        ;;
    *)
        echo "Unsupported tool: $TOOL"
        exit 1
        ;;
esac