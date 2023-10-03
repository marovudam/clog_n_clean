#!/bin/bash
if [[ $# -eq 3 ]]
then
folder_name_re='^[a-zA-Z]{1,7}$'
file_name_re='^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$'
file_size_re='^[0-9]{1,2}Mb$|^100Mb$'
if ! [[ "$1" =~ $folder_name_re ]]; then echo "First parameter should be string with 1-7 latin letters";
elif ! [[ "$2" =~ $file_name_re ]]; then echo "Second parameter should be string with 1-7 latin letters, dot, and another 1-3 latin letters";
elif ! [[ "$3" =~ $file_size_re ]]; then echo "Third parameter should have format NMb, where N - file size in Megabytes (< 100)";
else
start_time=$(date +"%H:%M:%S")
SECONDS=0
./create.sh $@
echo "Start time: "$start_time
echo "Script took "$SECONDS" seconds to execute"
echo "End time: "$(date +"%H:%M:%S")
fi
else
echo "Wrong number of parameters. You need to enter 3 parameters, you entered $# parameters"
fi