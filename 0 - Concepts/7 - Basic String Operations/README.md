
# Basic String Operations in Shell

## Example 1 : String Concatenation
```
#!/bin/bash

str1="Hello"
str2="World"
result="$str1 $str2"
echo $result   
```

## Example 2 : String Length
```
#!/bin/bash

str1="Hello"
result="$str1 $str2"
echo $result  
```

## Example 3 : String Extract
```
#!/bin/bash

str="Hello World"
substring=${str:0:5}   # Extract 5 characters from index 0
echo $substring 
```

## Example 4 : String Replace
```
#!/bin/bash

str="Hello World"
new_str=${str/World/Universe}   # Replace "World" with "Universe"
echo $new_str  
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/7%20-%20Basic%20String%20Operations/image1.png">

## Example 5 : String Comparision
```
#!/bin/bash

str1="Hello"
str2="hello"
if [ "$str1" = "$str2" ]; then
    echo "Strings are equal"
else
    echo "Strings are not equal"
fi
 
```

## Example 6 : Check Sub-String 
```
#!/bin/bash

str="Hello World"
if [[ $str == *"Hello"* ]]; then
    echo "Substring found"
else
    echo "Substring not found"
fi
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/7%20-%20Basic%20String%20Operations/image2.png">

## Example 7 : String Cases
```
#!/bin/bash
#========== Convert 1st Character to UpperCase ===================

string="my name is Harsh"
echo "${string^}"
 
#========== Convert All Character to UpperCase ===================

string="my name is Harsh"
echo "${string^^}"

#========== Convert 1st Character to LowerCase ===================

string="my name is Harsh"
echo "${string,}"
 
#========== Convert All Character to LowerCase ===================

string="my name is Harsh"
echo "${string,,}"

```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/7%20-%20Basic%20String%20Operations/image3.png">