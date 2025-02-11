# Process and Resource Management:

## Monitoring running processes and system resource usage. Killing processes, scheduling jobs (using cron, at, etc.)

## Code File :
```sh
#!/bin/bash
# Process and Resource Management Tool
# This script monitors system resource usage, kills processes by PID,
# and schedules jobs (either recurring via cron or one-time via at).
#
# Usage:
#   ./proc_resource_manager.sh monitor
#   ./proc_resource_manager.sh kill <PID>
#   ./proc_resource_manager.sh schedule
#
# Inspired by common DevOps automation tasks :contentReference[oaicite:0]{index=0}

# Function to display usage information
usage() {
    echo "Usage: $0 [option] [arguments]"
    echo "Options:"
    echo "  monitor               Display system resource usage and running processes"
    echo "  kill <PID>            Kill a process with the given PID"
    echo "  schedule              Schedule a job (choose between recurring via cron or one-time via at)"
    exit 1
}

# Ensure at least one argument is provided
if [ $# -lt 1 ]; then
    usage
fi

case "$1" in
    monitor)
        echo "================== System Resource Usage =================="
        # Display a brief summary from the top command (first 10 lines)
        top -b -n 1 | head -n 10
        echo ""
        echo "================== Top 10 Processes by Memory =================="
        ps aux --sort=-%mem | head -n 10
        echo ""
        echo "================== Top 10 Processes by CPU =================="
        ps aux --sort=-%cpu | head -n 10
        ;;
    kill)
        if [ -z "$2" ]; then
            echo "Error: Please provide a PID to kill."
            exit 1
        fi
        PID="$2"
        echo "Attempting to kill process with PID: $PID"
        kill "$PID"
        if [ $? -eq 0 ]; then
            echo "Process $PID killed successfully."
        else
            echo "Failed to kill process $PID."
        fi
        ;;
    schedule)
        echo "Choose scheduling type:"
        echo "1) Recurring job (cron)"
        echo "2) One-time job (at)"
        read -p "Enter your choice (1 or 2): " schedule_choice
        if [ "$schedule_choice" = "1" ]; then
            read -p "Enter the cron schedule (e.g., '*/5 * * * *' for every 5 minutes): " cron_schedule
            read -p "Enter the command to schedule: " scheduled_command
            # Append the new cron entry to the current user's crontab
            (crontab -l 2>/dev/null; echo "$cron_schedule $scheduled_command") | crontab -
            if [ $? -eq 0 ]; then
                echo "Cron job scheduled successfully."
            else
                echo "Failed to schedule cron job."
            fi
        elif [ "$schedule_choice" = "2" ]; then
            read -p "Enter the time for the job (e.g., 'now + 1 minute', '10:30'): " at_time
            read -p "Enter the command to schedule: " scheduled_command
            echo "$scheduled_command" | at "$at_time"
            if [ $? -eq 0 ]; then
                echo "One-time job scheduled successfully with at."
            else
                echo "Failed to schedule one-time job."
            fi
        else
            echo "Invalid choice. Exiting."
            exit 1
        fi
        ;;
    *)
        usage
        ;;
esac



```

## How It Works

### 1. Monitoring Resource Usage

- **Overview:**  
  The `monitor` option provides an overall snapshot of your system's resource usage and lists the top processes.

- **Details:**  
  - Runs the `top` command in batch mode to display the first 10 lines of system resource usage.
  - Uses `ps aux` to list and sort processes by memory and CPU usage.
  - Displays the top 10 processes consuming the most memory and CPU.

### 2. Killing Processes

- **Overview:**  
  The `kill` option allows you to terminate a process by specifying its Process ID (PID).

- **Details:**  
  - Accepts a PID as an argument.
  - Sends a SIGTERM to the specified process.
  - Checks the exit status of the `kill` command to confirm whether the process was successfully terminated.

### 3. Scheduling Jobs

- **Overview:**  
  The `schedule` option enables you to schedule tasks, either as recurring jobs using cron or as one-time jobs using at.

- **Details:**  
  - Prompts the user to choose between a recurring job (cron) or a one-time job (at).
  - **For Recurring Jobs:**
    - Reads the desired cron schedule (e.g., `*/5 * * * *` for every 5 minutes).
    - Reads the command to be scheduled.
    - Appends the new cron entry to the current user's crontab.
  - **For One-Time Jobs:**
    - Reads the desired time for the job (e.g., `now + 1 minute` or a specific time like `10:30`).
    - Reads the command to be scheduled.
    - Uses the `at` command to schedule the one-time execution.
