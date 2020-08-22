#!/bin/bash

v_platform="$1"

IFS=$'\n' v_results=($(ls -1 "exp/${v_platform}"))

echo "run,real,user,system"

for v_result in "${v_results[@]}";
do
	v_result=$(echo "${v_result}" | grep -E -o '[[:digit:]]+')
	printf "%s," "${v_result}"
	./parse.sh "exp/${v_platform}/${v_result}.txt"
done
