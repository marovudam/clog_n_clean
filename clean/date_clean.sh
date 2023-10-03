#!/bin/bash

. ./date_response.sh
echo "Enter time of first file creation (for example, 20/08/2022 12:45)"
read first_date first_time
first_day=$(echo $first_date | grep -o -e '^[0-9]*')
first_month=$(echo $first_date | grep -o -e '\/[0-9]*\/' | grep -o -e '[0-9]*')
first_year=$(echo $first_date | grep -o -e '[0-9]*$')
first_hour=$(echo $first_time | grep -o -e '^[0-9]*')
first_minute=$(echo $first_time | grep -o -e '[0-9]*$')
n=$(./validate_date.sh $first_day $first_month $first_year $first_hour $first_minute)
if [[ $n -eq 0 ]]
then
    echo "Enter time of last file creation (for example, 20/08/2022 12:45)"
    read last_date last_time
    last_day=$(echo $last_date | grep -o -e '^[0-9]*')
    last_month=$(echo $last_date | grep -o -e '\/[0-9]*\/' | grep -o -e '[0-9]*')
    last_year=$(echo $last_date | grep -o -e '[0-9]*$')
    last_hour=$(echo $last_time | grep -o -e '^[0-9]*')
    last_minute=$(echo $last_time | grep -o -e '[0-9]*$')
    n=$(./validate_date.sh $last_day $last_month $last_year $last_hour $last_minute)
    if [[ $n -eq 0 ]]
    then
        first_date="$first_month/$first_day/$first_year"
        first_date=$(date -d$first_date +"%F")
        first_time=$(date -d$first_time +"%R")
        last_date="$last_month/$last_day/$last_year"
        last_date=$(date -d$last_date +"%F")
        last_time=$(date -d$last_time +"%R")
        if [[ $first_date < $last_date || ( $first_date == $last_date && $first_time < $last_time ) ]]
        then
            file_list=$( sudo find / -type d -regextype sed -regex ".*/[a-z]\+_[0-9]\{6\}$" | grep -v -e '/bin/' -e '/sbin/' -e 'sys/fs/cgroup' -e '/run/' -e '/dev/' -e '/proc/')
            for file_name in $file_list
            do
                    file_date=$( sudo ls -la --time-style=long-iso $file_name | awk {'print $6'})
                    file_time=$( sudo ls -la --time-style=long-iso $file_name | awk {'print $7'} )
                    if [[ ($file_date > $first_date || $file_date == $first_date && ($file_time > $first_time || $file_time == $first_time) ) && ($file_date < $last_date ||  $file_date == $last_date && ($file_time < $last_time || $file_time == $last_time) ) ]]
                    then
                        sudo rm -rf $file_name 2> /dev/null
                    fi
            done
        else
            echo "The first date should be less than the second"
        fi
    else
        echo $(respond $n)
    fi
else
echo $(respond $n)
fi