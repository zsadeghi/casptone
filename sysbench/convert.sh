#!/bin/bash

# Converts a file containing a number of sysbench results into individual files for each experiment.

v_platform="$1"
v_path="${v_platform}/all.txt"
v_lines="$(cat "${v_path}")"
v_file_number=1
while [[ -n "$(echo "${v_lines}" | grep "CPU speed:")" ]];
do
  v_file="${v_platform}/$(printf "%02d" ${v_file_number}).txt"
  echo "=========================================================================" > "${v_file}"
  v_from=$(echo "${v_lines}" | grep -n "CPU speed:" | head -n 1 | cut -d':' -f 1)
  v_to=$(echo "${v_lines}" | grep -n "sys " | head -n 1 | cut -d':' -f 1)
  echo "${v_file_number}: ${v_from} --> ${v_to}"
  v_count=$(( v_to - v_from + 2 ))
  v_lines=$(echo "${v_lines}" | tail -n +"${v_from}")
  v_selection=$(echo "${v_lines}" | head -n "${v_count}")
  v_lines=$(echo "${v_lines}" | tail -n +"${v_count}")
  echo "${v_selection}" >> "${v_file}"
  v_file_number=$(( v_file_number + 1 ))
done
