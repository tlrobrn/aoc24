#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: bench.sh DAY"
  exit 1
fi

hyperfine -N -w3 -n"DAY $1 PART(s) $2" "bin/run.sh $1 $2"
