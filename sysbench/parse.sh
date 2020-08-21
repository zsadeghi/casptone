#!/bin/bash

v_platform="$1"
v_run="$2"
v_path="$1/${v_run}.txt"

num_from_line() {
  local v_header="$1"
  grep "${v_header}" "${v_path}" | grep -E -o "[[:digit:]]+(.[[:digit:]]+)?"
}

thread_from_line() {
  local v_header="$1"
  grep "${v_header}" "${v_path}" | grep -E -o "[[:digit:]]+.[[:digit:]]+/[[:digit:]]+.[[:digit:]]+"
}

time_from_line() {
  local v_header="$1"
  grep "${v_header}" "${v_path}" | grep -E -o "([[:digit:]]+m)?[[:digit:]]+.[[:digit:]]+s"
}

v_cpu_events=$(num_from_line "events per second:")
v_sysbench_time=$(time_from_line "total time:")
v_sysbench_events=$(num_from_line "total number of events:")
v_latency_min=$(num_from_line "min:")
v_latency_avg=$(num_from_line "avg:")
v_latency_max=$(num_from_line "max:")
v_latency_95p=$(num_from_line "95th percentile:" | tail -n 1)
v_latency_sum=$(num_from_line "sum:")
v_thread_events=$(thread_from_line "events (avg/stddev):")
v_thread_time=$(thread_from_line "execution time (avg/stddev):")
v_system_real=$(time_from_line "real")
v_system_user=$(time_from_line "user")
v_system_system=$(time_from_line "sys")

printf "\"${v_cpu_events}\","
printf "\"${v_sysbench_time}\","
printf "\"${v_sysbench_events}\","
printf "\"${v_latency_min}\","
printf "\"${v_latency_avg}\","
printf "\"${v_latency_max}\","
printf "\"${v_latency_95p}\","
printf "\"${v_latency_sum}\","
printf "\"${v_thread_events}\","
printf "\"${v_thread_time}\","
printf "\"${v_system_real}\","
printf "\"${v_system_user}\","
printf "\"${v_system_system}\""
echo
