#!/bin/bash 
EMAIL=''
function sysstat {
echo -e "
#####################################################################
    Health Check Report (CPU,Process,Disk Usage, Memory)
#####################################################################
 
 
Hostname         : `hostname`
Kernel Version   : `uname -r`
Uptime           : `uptime | sed 's/.*up \([^,]*\), .*/\1/'`
Last Reboot Time : `who -b | awk '{print $3,$4}'`
 
*********************************************************************
                             Process
*********************************************************************
 
=> Top memory using processs/application
 
PID %MEM RSS COMMAND
`ps aux | awk '{print $2, $4, $6, $11}' | sort -k3rn | head -n 10`
 
=> Top CPU using process/application
`top b -n1 | head -17 | tail -11`
 
*********************************************************************
Disk Usage - > Threshold < 90 Normal > 90% Caution > 95 Unhealthy
*********************************************************************
"
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
 
echo -e "
*********************************************************************
             Memory 
*********************************************************************
 
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