#!/bin/bash
SLEEP_TIME=1 # In seconds
if [ $# -lt 1 ]; then
    echo "[-] Usage: $0 <file_pattern_to_monitor> [show_existing_content=0] [sleep=$SLEEP_TIME]"  
    echo
    echo "Description:"
    echo "Script is used to monitor the contents of a directory. If new text is "
    echo "found or a file with content is added, script will show this content."
    echo 
    echo "Arguments:"
    echo "file-pattern-to-monitor: File, or directory pattern e.g. '/tmp/test*' to monitor."
    echo "    Ideally, the file pattern must contain '*' e.g. '/tmp/test*'"
    echo "show_existing_content: Determine whether to show existing content in or not"
    echo "sleep_time: Time to sleep between checks" 
    echo 
    echo "Examples:"
    echo "To show new content added to files of form /tmp/test*, run the command:"
    echo "    $0 '/tmp/test*'"
    echo
    echo "To show existing lines AND new lines added to folder /tmp with files starting with"
    echo "name, /tmp/test*, but faster, run the command:"
    echo "    $0 '/tmp/test*' 1 0.25"
    echo
    echo "To monitor the directory '/tmp', run the command:"
    echo "    $0 /tmp/*"
    exit 1
fi
file_pattern=${1}
show_existing_content=${2:-"0"}
sleep_time=${3:-"$SLEEP_TIME"}

if [ "$show_existing_content" == "1" ]; then
    prev_content=""
else
    prev_content=$(find $file_pattern -type f -exec cat {} + 2>/dev/null)
fi
sleep "$sleep_time"

while [ 1 ]; do
    new_content=$(find $file_pattern -type f -exec cat {} + 2>/dev/null)
    IFS=$'\n'
    for nl in $new_content; do
        does_str_already_exist=$(echo "$prev_content" | grep -Fx "$nl")
        if [ -z "$does_str_already_exist" ]; then
            echo "$nl"
        fi
    done
    prev_content="$new_content"
    sleep "$sleep_time"
done

