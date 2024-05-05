
# Case Statements in Shell

## Example 1 :
```
#!/bin/bash

action=${1,,}

# start,stop,restart,reload

case ${action} in
    start)
        echo "going to start"
        ;;
    stop)
        echo "going to stop"
        ;;
    reload)
        echo "going to reload"
        ;;
    restart)
        echo "going to restart"
        ;;
    *)
        echo "please enter correct command line args."
esac
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/12%20-%20Case%20Statements/image1.png">

## Example 2 : Case Statements with Regex
```
#!/bin/bash

action=${1}

case ${action} in
    [Yy] | [Yy][Ee][Ss])
        echo "you answer yes"
        ;;
    [Nn] | [Nn][Oo])
        echo "you answer no"
        ;;
    *)
        echo "Invalid Answer"
        ;;
esac
```
<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/0%20-%20Concepts/12%20-%20Case%20Statements/image2.png">