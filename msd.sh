#!/bin/bash

mkdir -p /tmp/msd/



calculate(){
  pwd=$(pwd)
  hostname=$(hostname)
  whoami=$(whoami)
  $cmd > /tmp/msd/tmp_out.txt
}

formatAndSaveFile(){
  echo "==============[$title]====================" >> $1
  echo "$whoami@$hostname at $pwd" >> $1
  echo "" >> $1
  echo "Command : $cmd" >> $1
  echo "" >> $1
  echo "$(cat /tmp/msd/tmp_out.txt)"
  echo "Output : $(cat /tmp/msd/tmp_out.txt)" >> $1
  echo "========================================" >> $1

  echo "" >> $1
}


while [[ "$#" -gt 0 ]]; do
  case $1 in
    -c|--copy) mode="copy"; shift ;;
    -cd|--copyDoc) mode="copyDoc"; shift ;;
    -l|--last) last=1; shift ;;
    -f|--filename) filename="$2"; shift ;;
    -t|--title) title="$2"; shift ;;
    *) echo "Unknown parameter passed: $1" ;;
  esac
  shift
done

if [[ "$mode" == "copy" ]]; then
  rm -r "/tmp/msd/tmp_copy.txt"
  touch "/tmp/msd/tmp_copy.txt"
  filename="/tmp/msd/tmp_copy.txt"
  read -p "cmd:" cmd
  calculate 
  formatAndSaveFile $filename
  cat $filename | xsel -b
elif [[ "$mode" == "copyDoc" ]]; then
  if [ -z "$filename" ]; then
    echo "Please enter a file name using -f from which you want to copy"
    exit
  fi
  cat $filename | xsel -b

else
  if [ -z "$filename" ]; then
    echo "Please enter a file name using -f or use copy mode using -c to directly copy to your clipboard"
    exit
  fi
  read -p "cmd:" cmd
  calculate 
  formatAndSaveFile $filename
  
fi




