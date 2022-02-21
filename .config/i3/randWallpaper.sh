#!/bin/bash

while true
do
  local p=$HOME/Wallpapers
  ls $p | sort -R | tail -$N |  read file 
  feh --bg-fill $p/$file
  sleep 10m
done
