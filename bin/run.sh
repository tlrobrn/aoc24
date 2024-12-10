#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: run.sh DAY"
  exit 1
fi

lua main.lua $1 $2 < input/day$1.txt
