# Creating Project Folder using Shell

## Code File :
```sh
#!/bin/bash

echo "Please Enter Project Name : "
read prjName

mkdir $prjName

mkdir $prjName/dir1 $prjName/dir2

# Create the necessary files
touch $prjName/dir1/List1.txt
touch $prjName/dir2/List2.txt

echo "Creating Project Folder..."

sleep 1

echo "Your Project Folder named $prjName has been created..."
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/Creating%20Project%20Folder/image1.png">

