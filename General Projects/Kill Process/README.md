# Kill Process using Shell

## Code File :
```sh
#!/bin/bash
echo "This script kill Process which is taking maximum memory"

Processid=`ps au --sort -%mem | head -10 | awk '{print $2}' | awk ' NR==1'`

echo $Processid
kill -9 $Processid

if [[ $? -eq 0 ]];
then
echo "Process is killed successfully"
else
echo "some issue in kill"
fi

```

## Code Explaination :
This shell script appears to be designed to find and kill the process with the second highest memory usage. Let's break it down step by step:

- **``Processid=\ps au --sort -%mem | head -10 | awk '{print $2}' | awk ' NR==2'``**
This command retrieves the list of processes sorted by memory usage **(ps au --sort -%mem)**, takes the first 10 lines **(head -10)**, extracts the second column which contains the process IDs **(awk '{print $2}')**, and then selects the first process ID **(awk 'NR==1')**. The process ID is stored in the variable Processid.
- **`echo $Processid`**
This command simply prints the process ID stored in the variable Processid.
- **`kill -9 $Processid`**
This command kills the process with the process ID stored in the variable Processid using the kill command with the signal SIGKILL **(signal 9)**.
- **`if [[ $? -eq 0 ]]; then ... fi`**
This is an if-else statement that checks the exit status of the previous command. $? contains the exit status of the last command executed. If the exit status is 0 (which typically means success), it prints "Process is killed successfully", otherwise it prints "some issue in kill".