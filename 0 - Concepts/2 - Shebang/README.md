# Creating First Executable File

## Description

The **`shebang`** is a character sequence consisting of the characters hash ("#") followed by an exclamation mark ("!"). **In shell scripting, it's typically used at the beginning of a script file followed by the path to the interpreter that should be used to execute the script.**

- Below we can see all the Available shells in out System

<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/2%20-%20Shebang/image1.png">

- Here we have used the following set of commands into out Text File

- By Running the following Script we halted the execution for 30 sec in Waiting state
```
echo " Hello World "
echo " This is Harsh Thakkar "
sleep 30
```
- Below we can see the **`Default bash`** running during the current Commands

<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/2%20-%20Shebang/image2.png">

```
#!/bin/bash
```
- This line tells the system that the script should be run using the Bash shell interpreter, located at**` /bin/bash`**. The shebang is then followed by the path to the interpreter.

<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/2%20-%20Shebang/image3.png">

## Regarding running other packages of code with the shebang:

The shebang isn't limited to just specifying the Bash shell. You can use it to specify any interpreter for any scripting language. For example, you can use it to specify Python:

```
#!/usr/bin/python3
```
- This line specifies that the script should be run using the Python 3 interpreter located at **/usr/bin/python3**. Similarly, you can specify other interpreters for Perl, Ruby, etc.

<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/2%20-%20Shebang/image4.png">

