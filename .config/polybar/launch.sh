#!/bin/bash

killall -q polybar

polybar left &
polybar mid &
polybar right &

echo "Polybar started..."
