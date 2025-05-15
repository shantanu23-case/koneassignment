#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --tool=*) TOOL="${1#*=}" ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

case $TOOL in
    wheel)
        python -m build
        ;;
    maven)
        mvn package
        ;;
    cmake)
        mkdir -p build && cd build && cmake .. && make
        ;;
    docker)
        docker build -t my-app:latest .
        ;;
    *)
        echo "Unsupported tool: $TOOL"
        exit 1
        ;;
esac