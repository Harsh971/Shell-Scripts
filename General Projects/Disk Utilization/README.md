# Disk Utilization Function using Shell

## Code File :
```sh
#!/bin/bash

disk_utilization()
{
disk=`df -h`
echo "disk utiliation is : $disk "
}

if [[ $? -eq 0 ]];
then
    echo "this is disk usage report"
    disk_utilization
else
    echo "disk has some issue "
fi
```
<hr>
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/Disk%20Utilization/image1.png">
