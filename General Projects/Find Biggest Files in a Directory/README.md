# Find Biggest Files in a Directory using Shell

## Code File :
```sh
#!/bin/bash

echo "First 5 biggest file in the file system passed via positional argument"

path="$1"
echo $path

du -ah $path | sort -hr | head -n 5 > /home/harsh/Desktop/filesize.txt

echo "This is the list of big files in the file system $path "

cat /home/harsh/Desktop/filesize.txt
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/Find%20Biggest%20Files%20in%20a%20Directory/image1.png">

## Code Explaination :

This shell script takes a directory path as an argument, calculates the disk usage of each file and directory within that path **`($path)`**, sorts the results by size in **human-readable format (-h)**, and then outputs the top 5 largest entries into a text file named filesize.txt located on the desktop.

## Here's a breakdown:

- **`path="$1"`** : This line assigns the first argument provided to the script to the variable path. This argument should be a directory path for which you want to calculate the disk usage.
- **`du -ah $path`** : The du command is used to estimate file and directory space usage. The -a option tells du to include files and directories in its output, and the -h option displays sizes in human-readable format (e.g., KB, MB, GB). $path is the directory whose disk usage is being calculated.
- **`sort -hr`** : The sort command sorts the output of du based on file sizes. The -h option makes sort understand human-readable numbers (e.g., 1K, 2M, 3G) and -r sorts the output in reverse order, so the largest files/directories appear first.
- **`head -n 5`** : The head command displays the first 5 lines of the sorted output. Since the output is sorted in descending order of size, this effectively shows the top 5 largest files or directories in $path.