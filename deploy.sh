#!/usr/bin/env sh
path="$1"

if [ -z "$path" ]
then
  echo "Usage: deploy <path to computer folder>"
  exit
fi


mkdir -p "$path/aran/"

for file in build builder navigation placer astring 
do
    cp "$file.lua" "$path/aran/$file"
done
