# Basic Calculator using Shell

## Code File :
```sh
#!/bin/bash

echo "Enter First number : "
read num1

echo "Enter Second number : "
read num2

echo "Enter Operation (+, -, *, /) : "
read op

if [ "$op" == "+" ]; 
then
    result=$((num1 + num2))
elif [ "$op" == "-" ]; 
then
    result=$((num1 - num2))
elif [ "$op" == "*" ]; 
then
    result=$((num1 * num2))
elif [ "$op" == "/" ]; 
then
    result=$((num1 / num2))
else 
    result="Please enter valid input..."
fi

echo "The result is : $result"
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/Calculator/image1.png">

