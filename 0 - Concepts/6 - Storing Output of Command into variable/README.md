
# Storing Output of Command into variable in Shell

## Example 1 : 
```
#!/bin/bash

# Method 1
present_working_DIR_1=$(pwd)
echo "${present_working_DIR_1}"

# Method 2
present_working_DIR_2=`pwd`
echo "${present_working_DIR_2}"

```

<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/6%20-%20Storing%20Output%20of%20Command%20into%20variable/image1.png">