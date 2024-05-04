# Reserved Keywords in Shell

In Bash scripting, there are several reserved keywords that have special meanings and are used for control flow, variable assignment, and other functionalities. Here's a list of some of the most commonly used reserved keywords in Bash :

| Number | Keyword/Construct | Description |
| ------ | ----------------- | ----------- |
| 1      | `if`              | Used for conditional execution. |
| 2      | `then`            | Used in conjunction with `if` for conditional execution. |
| 3      | `else`            | Used in conjunction with `if` for conditional execution when the condition is not met. |
| 4      | `elif`            | Stands for "else if," used in conjunction with `if` for multiple conditional branches. |
| 5      | `fi`              | Marks the end of an `if` statement. |
| 6      | `for`             | Used for loop iteration. |
| 7      | `while`           | Used for loop iteration based on a condition. |
| 8      | `until`           | Used for loop iteration until a condition becomes true. |
| 9      | `do`              | Marks the beginning of a loop body. |
| 10     | `done`            | Marks the end of a loop body. |
| 11     | `case`            | Used for multi-way branching based on pattern matching. |
| 12     | `esac`            | Marks the end of a `case` statement. |
| 13     | `function`        | Used to define a function. |
| 14     | `return`          | Used to return a value from a function. |
| 15     | `break`           | Used to exit from a loop. |
| 16     | `continue`        | Used to skip the rest of the loop body and continue with the next iteration. |
| 17     | `exit`            | Used to exit the script with a specified exit status. |
| 18     | `unset`           | Used to unset or delete the value of a variable or function. |
| 19     | `export`          | Used to export variables to the environment of subsequently executed commands. |
| 20     | `readonly`        | Used to mark variables or functions as read-only. |
| 21     | `declare`         | Used to declare variables with specific properties, such as scope or attributes. |
| 22     | `source`/`.`      | Used to execute commands from a script in the current shell environment. |
| 23     | `eval`            | Used to evaluate a command or expression. |
| 24     | `exec`            | Used to replace the current shell process with another command. |
| 25     | `trap`            | Used to set up signal handling for the shell script. |
| 26     | `shift`           | Used to shift positional parameters in a script. |
| 27     | `getopts`         | Used to parse command-line options in a script. |
| 28     | `[[`              | Used for conditional expressions (more powerful than `[`). |
| 29     | `]]`              | Marks the end of a conditional expression. |
| 30     | `{`               | Used to start a group of commands that will be executed in the current shell context. |
| 31     | `}`               | Marks the end of a group of commands started with `{`. |
| 32     | `((`              | Used for arithmetic evaluation. |
| 33     | `))`              | Marks the end of an arithmetic evaluation. |
| 34     | `$`               | Used for parameter expansion, command substitution, and arithmetic expansion. |
| 35     | `!`               | Used for history expansion and logical negation. |
| 36     | `\`              | Used for piping the output of one command into another. |
| 37     | `&`               | Used for background execution of commands. |
| 38     | `;`               | Used to separate multiple commands on a single line. |
| 39     | `#`               | Used for comments. |
| 40     | `` ` ``           | Used for command substitution (backticks). |
| 41     | `:`               | Null command, does nothing (can be used as a placeholder). |
| 42     | `*`               | Wildcard character for pattern matching. |
| 43     | `?`               | Wildcard character for matching any single character in a filename. |
| 44     | `[]`              | Used for character class matching in filename expansion. |
| 45     | `$()`             | An alternative syntax for command substitution (preferred over backticks). |
| 46     | `[[...]]`         | An alternative conditional construct similar to `[...]`, but with additional features such as pattern matching and extended operators. |
| 47     | `$?`              | Special variable that holds the exit status of the last executed command. |
| 48     | `$$`              | Special variable that holds the process ID (PID) of the current shell. |
| 49     | `$!`              | Special variable that holds the PID of the last background command executed. |
| 50     | `$@`              | Special variable that expands to the positional parameters starting from the first one. |
| 51     | `$*`              | Special variable that expands to all positional parameters as a single word. |
| 52     | `$#`              | Special variable that holds the number of positional parameters passed to the script. |
| 53     | `$0`              | Special variable that holds the name of the script itself. |
| 54     | `$1, $2, ..., $n`| Special variables that hold the positional parameters passed to the script or function. |
| 55     | `$IFS`            | Special variable that holds the Internal Field Separator, which determines how Bash splits words into tokens. |
| 56     | `$RANDOM`         | Special variable that generates a random integer between 0 and 32767 each time it's referenced. |
| 57     | `$LINENO`         | Special variable that holds the current line number in the script. |
| 58     | `$BASH_VERSION`   | Special variable that holds the version number of Bash. |
| 59     | `$HOME`           | Special variable that holds the path to the user's home directory. |
| 60     | `$0`              | Special variable that holds the name of the script itself. |
