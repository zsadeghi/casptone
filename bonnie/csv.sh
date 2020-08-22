#!/bin/zsh

v_path="$1"

IFS=$'\n' v_files=($(ls -1 "${v_path}" | grep '.txt' | sort))

printf "Run,"
printf "\"Concurrency\","
printf "\"Size\","
printf "\"Seq. Out. Block Speed\","
printf "\"Seq. Out. Block CPU\","
printf "\"Seq. Out. Block Latency\","
printf "\"Seq. Out. Rewrite Speed\","
printf "\"Seq. Out. Rewrite CPU\","
printf "\"Seq. Out. Rewrite Latency\","
printf "\"Seq. In. Block Sped\","
printf "\"Seq. In. Block CPU\","
printf "\"Seq. In. Block Latency\","
printf "\"Random Seek Speed\","
printf "\"Random Seek CPU\","
printf "\"Random Seek Latency\","
printf "\"Real time\","
printf "\"User time\","
printf "\"System time\""
echo

v_run=1
for v_file in "${v_files[@]}";
do
  printf "%d," "${v_run}"
  ./parse.sh "${v_path}/${v_file}"
  v_run=$(( v_run + 1 ))
done
