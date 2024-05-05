
# Functions in Shell

## Example 1 : Functions
```
#!/bin/bash

# ========================= method 1 ======================

function fun1(){
    echo "This is fun1"
}

# ========================= method 2 ======================

fun2(){
    echo "This is fun2"
}

# ========================= method 3 ======================

function fun3 {
    echo "This is fun3"
}

fun1
fun2
fun3 
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/8%20-%20Functions%20in%20Shell/image1.png">

## Example 2 : Passing Parameters to Function
```
#!/bin/bash

function fun1(){
    echo "This is ${1}"
}

function fun2(){
    echo "This is ${1} ${2}"
}

fun1 Hello World
fun2 This is

```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/8%20-%20Functions%20in%20Shell/image2.png">
