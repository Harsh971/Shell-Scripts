# System Health Check using Shell

## Code File : Part 1
```sh
Hostname         : `hostname`
Kernel Version   : `uname -r`
Uptime           : `uptime | sed 's/.*up \([^,]*\), .*/\1/'`
Last Reboot Time : `who -b | awk '{print $3,$4}'`
```
### Code Explaination : 
- **`Hostname : \hostname`` `**: 
  - This line prints "Hostname" followed by the output of the hostname command.
  -The backticks (`) around hostname indicate command substitution, meaning the output of the hostname command will be inserted in place of the command itself.
- **`Kernel Version : \uname -r`` `** :
  - This line prints "Kernel Version" followed by the output of the uname -r command.
  - Similar to the first line, the backticks (`) perform command substitution.
- **` uptime | sed 's/.*up \([^,]*\), .*/\1/' `**
  - This line prints "Uptime" followed by the uptime of the system.
  - It achieves this by running the uptime command and piping its output to sed for text processing.
  - The sed command captures the uptime duration using a regular expression and prints it.
  - **` up \([^,]*\), .*/\1/ `** captures the uptime duration between "up" and the first comma encountered in the output of uptime
- **`Last Reboot Time : \who -b | awk '{print $3,$4}'`` `** :
  - This line prints "Last Reboot Time" followed by the last system reboot time.
  - It does so by running the who -b command to retrieve system boot time information.
  - The output of who -b is then piped to awk to extract and print the third and fourth fields, which represent the date and time of the last system boot, respectively.
  - Similar to the previous lines, command substitution is used to include the output of the who -b and awk commands in the final output.
<hr>

## Code File : Part 2
```sh
 => Top memory using processs/application
 
PID %MEM RSS COMMAND
`ps aux | awk '{print $2, $4, $6, $11}' | sort -k3rn | head -n 10`
 
=> Top CPU using process/application
`top b -n1 | head -17 | tail -11`
```
### Code Explaination : 
- **`ps aux | awk '{print $2, $4, $6, $11}' | sort -k3rn | head -n 10`** :
  - **ps aux** : This command lists all processes running on the system along with detailed information about each process.
  - **awk '{print $2, $4, $6, $11}'** : This awk command extracts specific columns from the output of ps aux. The columns selected are:
    - $2 : PID (Process ID)
    - $4 : %MEM (Memory usage as a percentage of total system memory)
    - $6 : RSS (Resident Set Size, the non-swapped physical memory that a task has used)
    - $11 : COMMAND (Command being executed)
  - **sort -k3rn** : This sort command sorts the output based on the third column (RSS) in reverse numerical order (-n flag for numerical sorting, -r flag for reverse order).
  - **head -n 10** : This head command displays only the first 10 lines of the sorted output, which effectively lists the top 10 processes consuming the most physical memory (RSS) on the system.
- **`top b -n1 | head -17 | tail -11`** :
  - **top b -n1** : This command runs the top command in batch mode (-b) for one iteration (-n1). top command provides dynamic real-time information about running processes. In batch mode, it outputs its data and exits without requiring user interaction.
  - **head -17** : This head command selects the first 17 lines of the output. These lines typically include column headers and summary information.
  - **tail -11** : This tail command selects the last 11 lines from the 17 lines selected by head. These 11 lines usually contain information about the top CPU-consuming processes according to top command's output.
<hr>

## Code File : Part 3
```sh
 df -Pkh | grep -v 'Filesystem' > /tmp/df.status
while read DISK
do
    LINE=`echo $DISK | awk '{print $1,"\t",$6,"\t",$5," used","\t",$4," free space"}'`
    echo -e $LINE 
    echo
done < /tmp/df.status
echo -e "
 
Heath Status"
echo
while read DISK
do
    USAGE=`echo $DISK | awk '{print $5}' | cut -f1 -d%`
    if [ $USAGE -ge 95 ] 
    then
        STATUS='Unhealty'
    elif [ $USAGE -ge 90 ]
    then
        STATUS='Caution'
    else
        STATUS='Normal'
    fi
         
        LINE=`echo $DISK | awk '{print $1,"\t",$6}'`
        echo -ne $LINE "\t\t" $STATUS
        echo
done < /tmp/df.status
rm /tmp/df.status
TOTALMEM=`free -m | head -2 | tail -1| awk '{print $2}'`
TOTALBC=`echo "scale=2;if($TOTALMEM<1024 && $TOTALMEM > 0) print 0;$TOTALMEM/1024"| bc -l`
USEDMEM=`free -m | head -2 | tail -1| awk '{print $3}'`
USEDBC=`echo "scale=2;if($USEDMEM<1024 && $USEDMEM > 0) print 0;$USEDMEM/1024"|bc -l`
FREEMEM=`free -m | head -2 | tail -1| awk '{print $4}'`
FREEBC=`echo "scale=2;if($FREEMEM<1024 && $FREEMEM > 0) print 0;$FREEMEM/1024"|bc -l`
TOTALSWAP=`free -m | tail -1| awk '{print $2}'`
TOTALSBC=`echo "scale=2;if($TOTALSWAP<1024 && $TOTALSWAP > 0) print 0;$TOTALSWAP/1024"| bc -l`
USEDSWAP=`free -m | tail -1| awk '{print $3}'`
USEDSBC=`echo "scale=2;if($USEDSWAP<1024 && $USEDSWAP > 0) print 0;$USEDSWAP/1024"|bc -l`
FREESWAP=`free -m |  tail -1| awk '{print $4}'`
FREESBC=`echo "scale=2;if($FREESWAP<1024 && $FREESWAP > 0) print 0;$FREESWAP/1024"|bc -l`
 
echo -e
```
### Code Explaination : 
- **`df -Pkh | grep -v 'Filesystem' > /tmp/df.status`** :
  - **df -Pkh** displays filesystem disk space usage in a human-readable format, with sizes in kilobytes, and excludes pseudo filesystems like /proc.
  - **grep -v 'Filesystem'** filters out the header line containing the word "Filesystem".
  - **> /tmp/df.status** redirects the output to a temporary file named /tmp/df.status.
- **`while read DISK; do ... done < /tmp/df.status`** :
  - This loop reads each line of the temporary file /tmp/df.status.
- **`LINE=\echo $DISK | awk '{print $1,"\t",$6,"\t",$5," used","\t",$4," free space"}'`` `**:
  - This line extracts disk-related information from each line of the df output and formats it. It includes the filesystem name ($1), mount point ($6), usage percentage ($5), and free space ($4).
- **`while read DISK; do ... done < /tmp/df.status`** :
  - This is another loop that reads each line of the temporary file /tmp/df.status.
- **`USAGE=\echo $DISK | awk '{print $5}' | cut -f1 -d%`` `** :
  - This line extracts the disk usage percentage from each line of the df output.
- **`if [ $USAGE -ge 95 ]; then ... elif [ $USAGE -ge 90 ]; then ... else ... fi`**:
  - This conditional statement evaluates the disk usage percentage and assigns a health status accordingly: 'Unhealthy' if usage is 95% or higher, 'Caution' if usage is 90% or higher, and 'Normal' otherwise.
- **`TOTALMEM=\free -m | head -2 | tail -1| awk '{print $2}'`` `**:
  - This line retrieves the total system memory (RAM) in megabytes.
  - **free -m** displays the total and used memory in megabytes.
  - **head -2 | tail -1** selects the second line of the output.
  - **awk '{print $2}'** extracts the total memory value.
- **`TOTALBC=\echo "scale=2;if($TOTALMEM<1024 && $TOTALMEM > 0) print 0;$TOTALMEM/1024"| bc -l`` `**:
  - This line calculates the total memory in gigabytes if it's greater than or equal to 1 GB.
  - If the total memory is less than 1 GB, it prints 0.
  - **bc -l** performs floating-point arithmetic.
- **`USEDMEM=\free -m | head -2 | tail -1| awk '{print $3}'`` `**:
  - This command retrieves the used memory (in megabytes) from the output of the free -m command.
  - **free -m** displays memory usage statistics in megabytes.
  - **head -2 | tail -1** selects the second line of the output (excluding the header).
  - **awk '{print $3}'** extracts the used memory value.
- **`USEDBC=\echo "scale=2;if($USEDMEM<1024 && $USEDMEM > 0) print 0;$USEDMEM/1024"|bc -l`` `**:
  - This command calculates the used memory in gigabytes (USEDBC).
  - If the used memory is less than 1 GB, it prints 0.
  - **bc -l** performs floating-point arithmetic.
- **`FREEMEM=\free -m | head -2 | tail -1| awk '{print $4}'`` `**:
  - This command retrieves the free memory (in megabytes) from the output of the free -m command.
- **`FREEBC=\echo "scale=2;if($FREEMEM<1024 && $FREEMEM > 0) print 0;$FREEMEM/1024"|bc -l`` `**:
  - This command calculates the free memory in gigabytes (FREEBC).
  - If the free memory is less than 1 GB, it prints 0.
  - **bc -l** performs floating-point arithmetic.
- **`TOTALSWAP=\free -m | tail -1| awk '{print $2}'`` `**:
  - This command retrieves the total swap space (in megabytes) from the output of the free -m command.
- **`TOTALSBC=\echo "scale=2;if($TOTALSWAP<1024 && $TOTALSWAP > 0) print 0;$TOTALSWAP/1024"| bc -l`` `**:
  - This command calculates the total swap space in gigabytes (TOTALSBC).
  - If the total swap space is less than 1 GB, it prints 0.
  - **bc -l** performs floating-point arithmetic.
- **`USEDSWAP=\free -m | tail -1| awk '{print $3}'`` `**:
  - This command retrieves the used swap space (in megabytes) from the output of the free -m command.
- **`USEDSBC=\echo "scale=2;if($USEDSWAP<1024 && $USEDSWAP > 0) print 0;$USEDSWAP/1024"|bc -l`` `**:
  - This command calculates the used swap space in gigabytes (USEDSBC).
  - If the used swap space is less than 1 GB, it prints 0.
  - **bc -l** performs floating-point arithmetic.
- **`FREESWAP=\free -m | tail -1| awk '{print $4}'`` `**:
  - This command retrieves the free swap space (in megabytes) from the output of the free -m command.
- **`FREESBC=\echo "scale=2;if($FREESWAP<1024 && $FREESWAP > 0) print 0;$FREESWAP/1024"|bc -l`` `**:
  - This command calculates the free swap space in gigabytes (FREESBC).
  - If the free swap space is less than 1 GB, it prints 0.
  - bc -l performs floating-point arithmetic.
<hr>

## Code File : Part 4
```sh
=> Physical Memory
 
Total\tUsed\tFree\t%Free
 
${TOTALBC}GB\t${USEDBC}GB \t${FREEBC}GB\t$(($FREEMEM * 100 / $TOTALMEM  ))%
 
=> Swap Memory
 
Total\tUsed\tFree\t%Free
 
${TOTALSBC}GB\t${USEDSBC}GB\t${FREESBC}GB\t$(($FREESWAP * 100 / $TOTALSWAP  ))%
"
}
FILENAME="health-`hostname`-`date +%y%m%d`-`date +%H%M`.txt"
sysstat > $FILENAME
echo -e "Reported file $FILENAME generated in current directory." $RESULT
if [ "$EMAIL" != '' ] 
then
    STATUS=`which mail`
    if [ "$?" != 0 ] 
    then
        echo "The program 'mail' is currently not installed."
    else
        cat $FILENAME | mail -s "$FILENAME" $EMAIL
    fi
fi
```

<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/System%20Health%20Check%20Report/image1.png">
