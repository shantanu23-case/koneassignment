#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --tool=*) TOOL="${1#*=}" ;;
        --coverage-threshold=*) COVERAGE_THRESHOLD="${1#*=}" ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

case $TOOL in
    pytest)
        pytest --cov=src --cov-report=xml --cov-fail-under=$COVERAGE_THRESHOLD tests/ || exit 1
        ;;
    mvn)
        mvn test || exit 1
        ;;
    gtest)
        ./build/tests/test_suite || exit 1
        ;;
    *)
        echo "Unsupported tool: $TOOL"
        exit 1
        ;;
esac