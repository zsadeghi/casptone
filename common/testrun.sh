#!/bin/bash

v_path="/experiment"
v_count="$1"
v_digits=$(printf "%d" "${v_count}" | wc -m)
shift
v_cmd="$*"

rm -rf "${v_path}/*"

v_num=1
while [[ ${v_num} -lt ${v_count} || ${v_num} -eq ${v_count} ]];
do
	v_exp="$(printf "%0${v_digits}d" "${v_num}")"
	printf "\r                                                     "
	printf "\r [${v_exp}/${v_count}] Running ..."
	{ time ${v_cmd} 2> /dev/null > "${v_path}/${v_exp}.txt" ; } 2>> "${v_path}/${v_exp}.txt"
	v_num=$(( v_num + 1))
done

printf "\r                                                                 "
echo -e "\rDone."
