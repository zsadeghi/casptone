#!/bin/bash

v_platform="$1"

echo '"Run","CPU speed","Total time","Total events","Latency (min)","Latency (avg)","Latency (max)","Latency (95th-p)","Latency (sum)","Thread events","Thread time","Real time","User time","Kernel time"'

for i in {01..12};
do
  printf "\"${i}\","
  ./parse.sh "${v_platform}/exp" "${i}"
done
