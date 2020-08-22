#!/bin/bash

v_run="$1"

docker run --rm -e COUNT=100 -v $(pwd)/exp${v_run}:/experiment --cpus=4 -m 1g y-cruncher-exp:latest
