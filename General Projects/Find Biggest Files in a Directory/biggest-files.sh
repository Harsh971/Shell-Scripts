#!/bin/bash

echo "First 5 biggest file in the file system passed via positional argument"

path="$1"
echo $path

du -ah $path | sort -hr | head -n 5 > /home/harsh/Desktop/filesize.txt

echo "This is the list of big files in the file system $path "

cat /home/harsh/Desktop/filesize.txt