
# Reading User Values in Shell

## Example 1 : Read Basic Value
```
#!/bin/bash

read name
echo "Hello World, i am ${name}"
```

<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/5%20-%20Fetching%20User%20Input/image1.png">


## Example 2 : Read With Prompt Message 
```
#!/bin/bash

read -p "Enter your name : " name
read -p "Enter your age : " age
echo "Hello ${name}, your age is ${age}"
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/5%20-%20Fetching%20User%20Input/image2.png">

## Example 3 : Understanding Parameters in CLI
```
#!/bin/bash

echo "${0} : Parameter 1"
echo "${1} : Parameter 2"
echo "${2} : Parameter 3"

```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/5%20-%20Fetching%20User%20Input/image3.png">

## Example 4 : Reading Values From CLI
```
#!/bin/bash

name=${1}
age=${2}
echo "Hello my name is ${name} and my age is ${age}"

```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/5%20-%20Fetching%20User%20Input/image4.png">

