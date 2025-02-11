# Log Management:

## Parsing, filtering, and rotating log files. Real-time monitoring of system logs

## Code File :
```sh
#!/bin/bash

# Log Management Script
# This script provides functionalities to parse, filter, rotate, and monitor log files in real-time.

LOG_FILE="/var/log/syslog"  # Default log file to manage
ARCHIVE_DIR="/var/log/archive"  # Directory to store archived logs
KEYWORD=""  # Keyword to filter logs

# Function to display usage information
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -f <logfile>   Specify the log file to manage (default: /var/log/syslog)"
    echo "  -k <keyword>   Keyword to filter log entries"
    echo "  -r             Rotate the log file"
    echo "  -m             Monitor the log file in real-time"
    echo "  -h             Display this help message"
    exit 1
}

# Function to parse and filter log entries
parse_and_filter_logs() {
    if [ -z "$KEYWORD" ]; then
        echo "No keyword specified for filtering. Displaying entire log file."
        cat "$LOG_FILE"
    else
        echo "Filtering log entries containing keyword: $KEYWORD"
        grep "$KEYWORD" "$LOG_FILE"
    fi
}

# Function to rotate the log file
rotate_log() {
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    ARCHIVE_FILE="$ARCHIVE_DIR/$(basename $LOG_FILE)_$TIMESTAMP"

    echo "Rotating log file: $LOG_FILE"
    echo "Archiving as: $ARCHIVE_FILE"

    # Create archive directory if it doesn't exist
    mkdir -p "$ARCHIVE_DIR"

    # Move the current log file to the archive directory
    mv "$LOG_FILE" "$ARCHIVE_FILE"

    # Create a new empty log file
    touch "$LOG_FILE"

    # Set appropriate permissions
    chmod 644 "$LOG_FILE"

    echo "Log rotation completed."
}

# Function to monitor the log file in real-time
monitor_logs() {
    echo "Monitoring log file: $LOG_FILE"
    tail -f "$LOG_FILE"
}

# Parse command-line options
while getopts "f:k:rmh" opt; do
    case $opt in
        f)
            LOG_FILE="$OPTARG"
            ;;
        k)
            KEYWORD="$OPTARG"
            ;;
        r)
            rotate_log
            exit 0
            ;;
        m)
            monitor_logs
            exit 0
            ;;
        h | *)
            usage
            ;;
    esac
done

# If no options were provided, display usage
if [ $OPTIND -eq 1 ]; then
    usage
fi

# Perform log parsing and filtering if a keyword is specified
if [ -n "$KEYWORD" ]; then
    parse_and_filter_logs
fi


```

## How It Works

### 1. Parsing and Filtering Log Files

- **Operation:**
  - The script allows users to specify a keyword to filter log entries. By providing a keyword, the script searches through the specified log file and displays entries that match the keyword.
  - This is achieved using tools like `grep`, which searches for patterns within files. For example, `grep "ERROR" /var/log/syslog` would display all lines containing the word "ERROR" in the syslog file.

### 2. Rotating Log Files

- **Operation:**
  - Log rotation is essential to prevent log files from consuming excessive disk space and to maintain manageability.
  - The script facilitates log rotation by archiving the current log file and creating a new empty log file for continued logging.
  - This process can be automated using utilities like `logrotate`, which is configured to handle log rotation tasks such as compressing old logs and removing logs older than a specified period.

### 3. Real-Time Monitoring of System Logs

- **Operation:**
  - Real-time monitoring enables administrators to view log entries as they are written, which is crucial for timely detection of issues.
  - The script utilizes the `tail` command with the `-f` (follow) option to display new log entries in real-time. For example, `tail -f /var/log/syslog` will output new lines added to the syslog file as they occur.
  - Additionally, combining `tail -f` with `grep` allows for real-time filtering. For instance, `tail -f /var/log/syslog | grep "ERROR"` will display new log entries containing the word "ERROR" as they are written.
