#!/bin/zsh

v_path="$1"

get_field() { 
  local p_field="$1"
  tail -n 5 "${v_path}" | head -n 1 | cut -d',' -f "${p_field}"
}

get_field_time() {
	local p_field="$1"
	local p_value="$(get_field "${p_field}")"
	if [[ "$(echo "${p_value}" | grep -E -o "us")" == "us" ]];
	then
		p_value="$(echo "${p_value}" | grep -E -o "[[:digit:]]+")"
  else
		p_value="$(echo "${p_value}" | grep -E -o "[[:digit:]]+")"
		p_value=$(( p_value * 1000 ))
	fi
	echo "${p_value}"
}

get_time() {
	local p_field="$1"
	local v_time
	v_time="$(tail -n 3 "${v_path}" | grep "${p_field}" | grep -o -E "[[:digit:]]+m[[:digit:]]+\.[[:digit:]]+s" | grep -o -E "[[:digit:]]+m[[:digit:]]+\.[[:digit:]]+")"
	local v_minutes="$(echo "${v_time}" | cut -d'm' -f 1)"
	v_minutes=$(( v_minutes * 60 ))
	v_time="$(echo "${v_time}" | cut -d'm' -f 2)"
	v_time=$(( v_minutes + v_time ))
	v_time=$(( v_time * 1000000 ))
	echo "${v_time}"
}

v_concurrency="$(get_field 4)"
v_size="$(get_field 6)"
v_seq_out_block_speed="$(get_field 10)"
v_seq_out_block_cpu="$(get_field 11)"
v_seq_out_block_latency="$(get_field_time 38)"
v_seq_out_rw_speed="$(get_field 12)"
v_seq_out_rw_cpu="$(get_field 13)"
v_seq_out_rw_latency="$(get_field_time 39)"
v_seq_in_block_speed="$(get_field 16)"
v_seq_in_block_cpu="$(get_field 17)"
v_seq_in_block_latency="$(get_field_time 41)"
v_random_seek_speed="$(get_field 18)"
v_random_seek_cpu="$(get_field 19)"
v_random_seek_latency="$(get_field_time 42)"
v_real_time="$(get_time 'real')"
v_user_time="$(get_time 'user')"
v_sys_time="$(get_time 'sys')"

printf "\"${v_concurrency}\","
printf "\"${v_size}\","
printf "\"${v_seq_out_block_speed}\","
printf "\"${v_seq_out_block_cpu}\","
printf "\"${v_seq_out_block_latency}\","
printf "\"${v_seq_out_rw_speed}\","
printf "\"${v_seq_out_rw_cpu}\","
printf "\"${v_seq_out_rw_latency}\","
printf "\"${v_seq_in_block_speed}\","
printf "\"${v_seq_in_block_cpu}\","
printf "\"${v_seq_in_block_latency}\","
printf "\"${v_random_seek_speed}\","
printf "\"${v_random_seek_cpu}\","
printf "\"${v_random_seek_latency}\","
printf "\"${v_real_time}\","
printf "\"${v_user_time}\","
printf "\"${v_sys_time}\""
echo
