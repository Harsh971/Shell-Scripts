
# While and For Loop in Shell

## Example 1 : While Loop
```
#!/bin/bash

read -p "please enter a number " number
initNumber=1
while [[ ${initNumber} -le 10 ]]
do
    echo $((initNumber*number))
    ((initNumber++))
done
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/11%20-%20while%20and%20for%20loop/image1.png">

## Example 2 : For Loop - 1
```
#!/bin/bash

read -p "please enter a number " number
for variableName in {1..10}
do
  echo $((variableName*number))
done
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/11%20-%20while%20and%20for%20loop/image2.png">

## Example 3 : For Loop - 2
```
#!/bin/bash

for variableName in "name 1" "name 2" "name 3"
do
 echo "${variableName}"
done
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/11%20-%20while%20and%20for%20loop/image3.png">

## Example 4 : For Loop - 3
```
#!/bin/bash

echo "Loop 1 : Gives list of all Files in current dir"
for i in *
do
  echo $i
done

echo "Loop 2 : Gives list of all Files in current dir with sh extension"
for i in $(ls *.sh)
do
  echo "$i"
done
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/11%20-%20while%20and%20for%20loop/image4.png">
