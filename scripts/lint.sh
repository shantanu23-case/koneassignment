#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --tool=*) TOOL="${1#*=}" ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
    shift
done

case $TOOL in
    flake8)
        flake8 src/ tests/ --max-line-length=88 || exit 1
        ;;
    checkstyle)
        java -jar checkstyle.jar -c /sun_checks.xml src/ || exit 1
        ;;
    cppcheck)
        cppcheck --enable=all --suppress=missingIncludeSystem src/ || exit 1
        ;;
    *)
        echo "Unsupported tool: $TOOL"
        exit 1
        ;;
esac