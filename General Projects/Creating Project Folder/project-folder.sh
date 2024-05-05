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