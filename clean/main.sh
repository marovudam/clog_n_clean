#!/bin/bash
if [[ $# -eq 1 ]]
then
    num_re='^[1-3]{1}$'
    if ! [[ "$1" =~ $num_re ]]; then echo "Parameter should be an integer from 1 to 3";
    elif [[ "$1" -eq 1 ]]
    then
        ./simple_clean.sh
    elif [[ "$1" -eq 2 ]]
    then
        ./date_clean.sh
    elif [[ "$1" -eq 3 ]]
    then
        ./mask_clean.sh
    fi
else
    echo "Wrong number of parameters. You need to enter 1 parameter, you entered $# parameters"
fi