
# If Statements in Shell

## Example 1 : Basic If Statements
```
#!/bin/bash

if echo "If this execute" 
then
  echo "than this will execute"
fi

number=5
if test $number -eq 5 
then
  echo "number is equal to five"
fi
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/9%20-%20if%20Statements/image1.png">

## Example 2 : If Statements with Strings
```
#!/bin/bash

if [ "harsh" == "harsh" ]
then
  echo "Code Block 1"
fi

if [ harsh == harsh ]
then
  echo "Code Block 2"
fi

name=Harsh
if [ name == Harsh ]
then
  echo "Code Block 3"
fi

name="harsh"
if [ "$name" == "haRsh" ]
then
  echo "Code Block 4"
fi

name="harsh"
othername="harsh"
if [[ ${name} == ${othername} ]]
then
  echo "Code Block 5"
fi
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/9%20-%20if%20Statements/image2.png">

## Example 3 : If Statements with Files
```
#!/bin/bash
file_full_path="/home/harsh/Desktop/test.sh"

# =================== check file is a directory. ==============
if [[ -d $file_full_path ]]
then
   echo  "${file_full_path} is a dir"
fi
# =============== -b means file is block device. =============
if [[ -b $file_full_path ]]
then
   echo  "${file_full_path} is a block device"
fi
# ===================== check, file exists. =============
if [[ -e $file_full_path ]]
then
   echo  "${file_full_path} is a exist device"
fi
# =================== check, file have write permission =========
if [[ -w $file_full_path ]]
then
   echo  "${file_full_path} have write permission"
fi
# =================== check file have execute permission. =======
if [[ -x $file_full_path ]]
then
   echo  "${file_full_path} have execute permission"
fi
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/9%20-%20if%20Statements/image3.png">


