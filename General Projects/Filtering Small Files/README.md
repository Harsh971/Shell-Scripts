# Filter Small Files using Shell

## Code File :
```sh
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

```
## Code Explaination :
This shell script is designed to extract information about filesystems and their sizes and write this information to an output file.

- **`filesystems=$(df -h | awk '{print $1,$2}' | sed '1d')`** : This line generates a list of filesystems and their sizes using the df command to display filesystem usage statistics.
    - df -h prints filesystem usage in human-readable format.
    - awk '{print $1,$2}' selects the first two fields (filesystem and size) from the df output.
    - sed '1d' removes the header line from the df output.
- **`while read -r line; do ... done <<< "$filesystems"`** : This construct reads each line of the $filesystems variable (which contains the output of df) and processes it within the loop.
- **`filesystem=$(echo "$line" | awk '{print $1}') and size=$(echo "$line" | awk '{print $2}')`** : These lines extract the filesystem and size information from each line of the df output.
- **`if [[ "$size" =~ [0-9]+[KM] ]]; then ... fi`** : This line checks if the size contains numeric digits followed by either 'K' (kilobytes) or 'M' (megabytes).
    - =~ is a regex match operator in Bash.
    - [0-9]+[KM] matches one or more digits followed by either 'K' or 'M'.
- **`echo "$filesystem" >> "$output_file"`** : If the size matches the specified pattern, the filesystem name is appended to the output file defined earlier.

<hr>
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/Filtering%20Small%20Files/image1.png">
