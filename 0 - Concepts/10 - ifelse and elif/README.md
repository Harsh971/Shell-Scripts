
# ifelse and elif in Shell

## Example 1 :
```
#!/bin/bash

name="Harsh"
othername="Thakkar"


if [[ ${name} == ${othername} ]]
then
    echo "both string are equals - 1"
else
    echo "both string are not equals - 1"
fi

if [[ ${name} != ${othername} ]]
then
    echo "both string are not equals -2"
else
    echo "both strings are equals -2"
fi
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/10%20-%20ifelse%20and%20elif/image1.png">

## Example 2 : 
```
#!/bin/bash

number=3

if [[ ${number} -eq 10 ]]
then
	echo "number is 10"
elif [[ ${number} -lt 10  && ${number} -gt 5 ]]
then
  	echo "number is less then 10"
elif [[ ${number} -lt 5 ]]
then
  	echo "number is less then 5"
else
  	echo "number is grater then 10"
fi
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/10%20-%20ifelse%20and%20elif/image2.png">