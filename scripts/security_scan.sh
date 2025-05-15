#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --tool=*) TOOL="${1#*=}" ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

case $TOOL in
    trivy)
        trivy image --severity CRITICAL,HIGH my-app:latest || exit 1
        ;;
    *)
        echo "Unsupported tool: $TOOL"
        exit 1
        ;;
esac