#!/bin/bash

# usage ./remove_loops.sh 23 38

for ((i=$1; i <= $2; i++))
do
  echo "$i"
  losetup -d /dev/loop$i
  echo "Removed loop $i"
done