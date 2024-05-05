# Delete User Account using Shell

## Code File : Part 1
```sh
function get_answer {
unset answer
ask_count=0
while [ -z "$answer" ]    # While no answer is given, keep asking.
do
     ask_count=$[ $ask_count + 1 ]
     case $ask_count in   #If user gives no answer in time allotted
     2)
          echo "Please answer the question."
     ;;
     3)
          echo "One last try...please answer the question."
     ;;
     4)
          echo "Since you refuse to answer the question..."
          echo "exiting program."
          exit
     ;;
     esac
     if [ -n "$line2" ]
     then                    #Print 2 lines
          echo $line1
          echo -e $line2" \c"
     else                    #Print 1 line
          echo -e $line1" \c"
     fi
                              #Allow 60 seconds to answer before time-out
     read -t 60 answer
done

unset line1
unset line2
} 
```
### Code Explaination : 
- It begins by clearing any existing value of the variable answer and setting ask_count to zero.
- Then it enters a while loop that continues until a non-empty answer is provided by the user.
- Inside the loop, it increments the ask_count variable.
- Depending on the value of ask_count, different messages are displayed prompting the user to answer the question. If the user fails to provide an answer after a certain number of attempts, the script exits.
- It checks if line2 is not empty. If it's not empty, it prints line1 followed by line2. If line2 is empty, it prints only line1.
- It uses the read command with a timeout of 60 seconds to wait for user input. If the user doesn't provide input within the specified time, the loop continues.
- Finally, it clears the values of line1 and line2 before exiting the function.
<hr>

## Code File : Part 2
```sh
function process_answer {
answer=$(echo $answer | cut -c1)
case $answer in
y|Y)
# If user answers "yes", do nothing.
;;
*)
# If user answers anything but "yes", exit script
        echo $exit_line1
        echo $exit_line2
        exit
;;
esac

unset exit_line1
unset exit_line2

} 
```
### Code Explaination : 
- **`function process_answer { ... }`** : This line indicates the beginning and end of the function definition. Anything between the curly braces {} is the body of the function.
- **`answer=$(echo $answer | cut -c1)`** : This line takes the value of the variable answer, probably provided by the user, and extracts only its first character using the cut command. It then stores this modified value back into the answer variable.
- **`case $answer in ... esac`** : This structure is a case statement that checks the value of the variable answer against different patterns.
- **`y|Y) ... ;;`** : If the value of answer is either 'y' or 'Y', the script will execute whatever commands are placed between y|Y) and ;;. However, in this script, it seems there are no commands specified for this case, so effectively, if the user inputs 'y' or 'Y', the script will do nothing.
- **`*) ... ;;`** : If the value of answer does not match 'y' or 'Y', the script will execute the commands specified between *) and ;;.
- **`echo $exit_line1 and echo $exit_line2`** : These commands presumably print out some predefined messages stored in variables exit_line1 and exit_line2.
- **`exit`** : This command terminates the script.
- **`unset exit_line1 and unset exit_line2`** : These commands unset the variables exit_line1 and exit_line2, removing their values from memory.
<hr>

## Code File : Part 3
```sh
# Get name of User Account to check
#
echo "Step #1 - Determine User Account name to Delete "

line1="Please enter the username of the user "
line2="account you wish to delete from system:"
get_answer
user_account=$answer

# Double check with script user that this is the correct User Account

line1="Is $user_account the user account "
line2="you wish to delete from the system? [y/n]"
get_answer

# Call process_answer funtion: if user answers anything but "yes", exit script


exit_line1="Because the account, $user_account, is not "
exit_line1="the one you wish to delete, we are leaving the script..."
process_answer
```
<hr>

## Code File : Part 4
```sh
# Check that user_account is really an account on the system

user_account_record=$(cat /etc/passwd | grep -w $user_account)

if [ $? -eq 1 ]          # If the account is not found, exit script
then
     echo "Account, $user_account, not found. "
     echo "Leaving the script..."
     exit
fi

echo "I found this record:"
echo $user_account_record

line1="Is this the correct User Account? [y/n]"
get_answer

# Call process_answer function : if user answers anything but "yes", exit script

exit_line1="Because the account, $user_account, is not "
exit_line2="the one you wish to delete, we are leaving the script..."
process_answer
```
### Code Explaination : 
- **`user_account_record=$(cat /etc/passwd | grep -w $user_account)`** : This line reads the contents of the /etc/passwd file, which stores information about user accounts on Unix-like systems. It then searches for a line that matches the $user_account variable (presumably the username provided by the user) using the grep command with the -w option to match whole words only. The result is stored in the user_account_record variable.
- **`if [ $? -eq 1 ]`** : This line checks the exit status of the previous command (grep). $? holds the exit status of the last command executed. If the exit status is 1, it means no match was found, indicating that the user account does not exist. In that case, the script proceeds to print an error message and exits.
- **`echo $user_account_record`** : This line prints the contents of the user_account_record variable, which should contain the details of the user account found in /etc/passwd.
- **`line1="Is this the correct User Account? [y/n]"`** : This line sets the variable line1 to the question asking whether the displayed user account is the correct one.
- **`get_answer`** : This line presumably calls a function get_answer to prompt the user for input. However, this function is not defined in the provided script snippet.
- **`exit_line1="Because the account, $user_account, is not ..." and exit_line2="the one you wish to delete, we are leaving the script..."`** : These lines set up error messages that will be displayed if the user does not confirm that the displayed user account is correct.
- **`process_answer`** : This line calls a function process_answer, which is not defined in the provided script snippet. This function is expected to handle the user's response to the question asked earlier.
<hr>

## Code File : Part 5
```sh
# Search for any running processes that belong to the User Account

echo "Step #2 - Find process on system belonging to user account"

ps -u $user_account> /dev/null  #List user processes running.
 
case $? in
1)     # No processes running for this User Account        
     echo "There are no processes for this account currently running."
;;
0)   # Processes running for this User Account.
     # Ask Script User if wants us to kill the processes.
     
     echo "$user_account has the following process(es) running:"
     ps -u $user_account
     
     line1="Would you like me to kill the process(es)? [y/n]"
     get_answer
     
     answer=$(echo $answer | cut -c1)
     
     case $answer in
     y|Y)   # If user answers "yes",
            # kill User Account processes.

            echo "Killing off process(es)..."
            
            # List user process running code in command_1
            command_1="ps -u $user_account --no-heading"
            
            # Create command_3 to kill processes in variable
            command_3="xargs -d \\n /usr/bin/sudo /bin/kill -9"
            
            # Kill processes via piping commands together
            $command_1 | gawk '{print $1}' | $command_3

            echo "Process(es) killed."
     ;;
     *)     #If user answers anything but "yes", do not kill.
            echo "Will not kill process(es)."
     ;;
     esac
;;
esac
```
### Code Explaination : 
This shell script checks for processes associated with a given user account and offers the option to terminate them. 

- **`ps -u $user_account > /dev/null`** : This command lists the processes associated with the user account specified in the variable $user_account. The output of this command is redirected to /dev/null, effectively discarding it. This is done because the script is only interested in the exit status of the ps command, not its output.
- **`case $? in ... esac`** : This structure checks the exit status of the previous command. $? holds the exit status of the last command executed.
     - **1) ... ;;** : If the exit status is 1, it means no processes were found for the specified user account. In this case, the script prints a message indicating that there are no processes running for this account.
     - **0) ... ;;** : If the exit status is 0, it means there are processes running for the specified user account. In this case, the script displays the list of processes and asks the user if they want to kill them.
- **`ps -u $user_account`** : This command lists the processes associated with the user account again, but this time the output is displayed on the console.
- **`line1="Would you like me to kill the process(es)? [y/n]"`** : This line sets the variable line1 to the question asking whether the user wants to kill the displayed processes.
- **`get_answer`** : This line presumably calls a function get_answer to prompt the user for input. However, the definition of this function is not provided in the script snippet.
- **`answer=$(echo $answer | cut -c1)`** : This line extracts the first character of the user's response to simplify the subsequent case statement.
- **`Killing Processes`** :
     - **`command_1="ps -u $user_account --no-heading"`** : This variable holds a command to list the processes associated with the user account without the header.
     - **`command_3="xargs -d \\n /usr/bin/sudo /bin/kill -9"`** : This variable holds a command to kill processes using sudo with the -9 signal, which is a forceful termination.
     - **`$command_1 | gawk '{print $1}' | $command_3`** : This line pipes the output of command_1 (list of process IDs) to gawk to extract the first field (the process IDs) and then pipes it to command_3 (the command to kill processes).
<hr>

## Code File : Part 6
```sh
# Create a report of all files owned by User Account
#
echo "Step #3 - Find files on system belonging to user account"
echo "Creating a report of all files owned by $user_account."
echo "It is recommended that you backup/archive these files,"
echo "and then do one of two things:"
echo "  1) Delete the files"
echo "  2) Change the files' ownership to a current user account."
echo "Please wait. This may take a while..."
#
report_date=$(date +%y%m%d)
report_file="$user_account"_Files_"$report_date".rpt
#
find / -user $user_account> $report_file 2>/dev/null
#
echo "Report is complete."
echo "Name of report:      $report_file"
echo -n "Location of report: "; pwd
```

<hr>

## Code File : Part 7
```sh
#  Remove User Account
echo "Step #4 - Remove user account"
#
line1="Do you wish to remove $user_account's account from system? [y/n]"
get_answer

# Call process_answer function:
#       if user answers anything but "yes", exit script

exit_line1="Since you do not wish to remove the user account,"
exit_line2="$user_account at this time, exiting the script..."
process_answer

userdel $user_account          #delete user account
echo "User account, $user_account, has been removed"

```

<hr>


<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/Delete%20User%20Account/image1.png">

<img src="https://github.com/Harsh971/Shell-Scripts/blob/main/General%20Projects/Delete%20User%20Account/image2.png">
