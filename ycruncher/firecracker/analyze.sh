#!/bin/zsh

select_pid() {
	local v_selected="$1"
	head -n "${v_selected}" pids | tail -n 1
}

select_columns() {
	local v_selected="$1"
	grep "$(select_pid "${v_selected}")" runs.log | grep -o -E "S [[:digit:]]+\.[[:digit:]]+ +[[:digit:]]+\.[[:digit:]]+ +[[:digit:]]+:[[:digit:]]+\.[[:digit:]]+" | sed -E 's/S ([[:digit:]]+\.[[:digit:]]+) +[[:digit:]]+\.[[:digit:]]+ +([[:digit:]]+:[[:digit:]]+\.[[:digit:]]+)/\2,\1/'
}

parse_time() {
	local v_time="$1"
	local v_millis="$(echo "${v_time}" | cut -d'.' -f 2)"
	v_time="$(echo "${v_time}" | cut -d'.' -f 1)"
	local v_seconds="$(echo "${v_time}" | cut -d':' -f 2)"
	local v_minutes="$(echo "${v_time}" | cut -d':' -f 1)"
	v_millis=$(( v_millis * 10 ))
	v_seconds=$(( v_seconds * 1000 ))
	v_minutes=$(( v_minutes * 60000 ))
	v_time=0
	v_time=$(( v_millis + v_seconds + v_minutes ))
	echo "${v_time}"
}

convert_values() {
	local v_selected="$1"
	local v_rows
	IFS=$'\n' v_rows=( $(select_columns "${v_selected}") )
	local v_row
	local v_time
	local v_cpus
	for v_row in "${v_rows[@]}";
	do
		v_time="$(echo "${v_row}" | cut -d',' -f 1)"
		v_cpus="$(echo "${v_row}" | cut -d',' -f 2)"
		v_time="$(parse_time "${v_time}")"
		echo "${v_time},${v_cpus}"
	done
}

echo "Time (ms),CPUs"
convert_values "$1"
