#!/bin/bash

output_file="/home/harsh/Desktop/output.txt"

filesystems=$(df -h | awk '{print $1,$2}' | sed '1d')

while read -r line; do

    filesystem=$(echo "$line" | awk '{print $1}')
    size=$(echo "$line" | awk '{print $2}')

    if [[ "$size" =~ [0-9]+[KM] ]]; then
        echo "$filesystem" >> "$output_file"
    fi
done <<< "$filesystems"

echo "File systems with size less than 10 MB have been written to $output_file"
