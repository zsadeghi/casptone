#!/bin/zsh

v_path="$1"

get_time() {
  local p_field="$1"
  local v_time
  v_time="$(tail -n 3 "${v_path}" | grep "${p_field}" | grep -o -E "[[:digit:]]+m[[:digit:]]+\.[[:digit:]]+s" | grep -o -E "[[:digit:]]+m[[:digit:]]+\.[[:digit:]]+")"
  local v_minutes="$(echo "${v_time}" | cut -d'm' -f 1)"
  v_minutes=$(( v_minutes * 60000 ))
  v_time="$(echo "${v_time}" | cut -d'm' -f 2)"
	local v_seconds=$(echo "${v_time}" | cut -d'.' -f 1)
	v_seconds=$(( v_seconds * 1000 ))
	v_time=$(echo "${v_time}" | cut -d'.' -f 2)
	v_time=$(( v_time + v_seconds + v_minutes ))
  echo "${v_time}"
}

echo "$(get_time 'real'),$(get_time 'user'),$(get_time 'sys')"
