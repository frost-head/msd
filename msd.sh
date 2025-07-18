#!/bin/bash

mkdir -p /tmp/msd/


while [[ "$#" -gt 0 ]]; do
  case $1 in
    -f|--filename) filename="$2"; shift ;;
    -t|--title) title="$2"; shift ;;
    *) echo "Unknown parameter passed: $1" ;;
  esac
  shift
done

echo "File name: $filename"
read -p "cmd:" cmd
echo "cmd : : $cmd" 



pwd=$(pwd)
hostname=$(hostname)
whoami=$(whoami)
$cmd > /tmp/msd/tmp_out.txt


echo "==============$title====================" >> $filename
echo "$whoami@$hostname at $pwd" >> $filename
echo "" >> $filename
echo "Command : $cmd" >> $filename
echo "" >> $filename
echo "$(cat /tmp/msd/tmp_out.txt)"
echo "Output : $(cat /tmp/msd/tmp_out.txt)" >> $filename
echo "========================================" >> $filename

echo "" >> $filename

