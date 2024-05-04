# System Defined Variables in Shell

In Bash scripting, there are several system-defined variables that provide information about the environment, configuration, and behavior of the shell. Here's a list of some of the most commonly used system-defined variables in Bash :

| Number | Variable     | Description                                                                                   |
|--------|------------------|-----------------------------------------------------------------------------------------------|
| 1      | `HOME`           | Holds the path to the user's home directory.                                                  |
| 2      | `PATH`           | Specifies the directories that the shell searches for executable programs.                    |
| 3      | `PWD`            | Holds the current working directory.                                                          |
| 4      | `OLDPWD`         | Holds the previous working directory.                                                         |
| 5      | `SHELL`          | Specifies the default shell for the user.                                                     |
| 6      | `USER`           | Holds the username of the current user.                                                        |
| 7      | `UID`            | Holds the user ID (UID) of the current user.                                                  |
| 8      | `GROUPS`         | Holds a list of groups the current user belongs to.                                            |
| 9      | `HOSTNAME`       | Specifies the hostname of the system.                                                          |
| 10     | `HOSTTYPE`       | Specifies the type of the current host system.                                                 |
| 11     | `OSTYPE`         | Specifies the type of operating system (e.g., Linux, macOS).                                   |
| 12     | `MACHTYPE`       | Specifies the system architecture and processor type.                                          |
| 13     | `BASH_VERSION`   | Specifies the version of Bash that is running.                                                 |
| 14     | `RANDOM`         | Generates a random integer between 0 and 32767 each time it's referenced.                      |
| 15     | `LINENO`         | Holds the current line number within a script or function.                                      |
| 16     | `PS1`            | Specifies the primary prompt string.                                                           |
| 17     | `PS2`            | Specifies the secondary prompt string (used in multi-line commands).                           |
| 18     | `IFS`            | Specifies the Internal Field Separator, which determines how Bash splits words into tokens.   |
| 19     | `OPTARG`         | Holds the value of the option argument when using the `getopts` built-in command.              |
| 20     | `OPTIND`         | Holds the index of the next argument to be processed by `getopts`.                              |
| 21     | `PPID`           | Holds the process ID (PID) of the parent process.                                              |
| 22     | `PIPESTATUS`     | An array variable that holds the exit status of the last foreground pipeline.                  |
| 23     | `BASH`           | The path to the Bash binary executable.                                                        |
| 24     | `BASH_ENV`       | Specifies the filename of a startup file to read when Bash is invoked as an interactive shell. |
| 25     | `BASH_VERSINFO`  | An array variable containing version information about the Bash shell.                          |
| 26     | `CDPATH`         | Specifies a list of directories that the `cd` command searches when changing directories.      |
| 27     | `DIRSTACK`       | An array variable containing the current directory stack (pushd/popd history).                  |
| 28     | `ENV`            | Specifies the filename of a startup file to read when Bash is invoked in a non-interactive mode.|
| 29     | `FUNCNAME`       | An array variable containing the names of all shell functions currently in the execution call stack.|
| 30     | `HISTCONTROL`    | Specifies how Bash should handle command history.                                              |
| 31     | `HISTFILE`       | Specifies the filename where the command history is saved.                                      |
| 32     | `HISTSIZE`       | Specifies the maximum number of commands to store in the command history.                        |
| 33     | `HISTTIMEFORMAT`| Specifies the format for displaying timestamps in the command history.                          |
| 34     | `HOSTFILE`       | Specifies the filename of a file containing a list of hostnames to be used for auto-completion.|
| 35     | `MAIL`           | Specifies the filename of the user's mailbox.                                                  |
| 36     | `MAILCHECK`      | Specifies how often (in seconds) Bash checks for new mail.                                      |
| 37     | `PS3`            | Specifies the prompt string for the `select` command.                                          |
| 38     | `PS4`            | Specifies the prompt string for the `xtrace` option (`set -x`).                                 |
