#!/bin/bash

. ./transform.sh
echo "Enter cleaning mask type (1 - filename mask, 2 - folder mask)"
read type
if [[ $type =~ [1-2] && "$type" -eq 1 ]]; then
    echo "Enter filename mask (example: abcd.ef_051222)"
    read mask
    mask=$(transform_file_mask $mask)
    if [[ $mask == "error" ]]
        then echo "Something is wrong with the mask"
    else
        file_list=$( sudo find / -type f -regextype sed -regex ".*/[a-z]\+_[0-9]\{6\}\.[a-z]\+$" | grep -v -e '/bin/' -e '/sbin/' -e 'sys/fs/cgroup' -e '/run/' -e '/dev/' -e '/proc/')
        for one_file in $file_list; do
            if [[ $(echo $one_file | grep -E -e $mask | wc -m) -gt 0 ]]; then
                sudo rm -rf $one_file
            fi
        done
    fi
elif [[ $type =~ [1-2] && "$type" -eq 2 ]]; then
    echo "Enter folder mask (example: abcd_051222)"
    read mask
    mask=$(transform_folder_mask $mask)
    if [[ $mask == "error" ]]
        then echo "Something is wrong with the mask"
    else
        file_list=$( sudo find / -type d -regextype sed -regex ".*/[a-z]\+_[0-9]\{6\}$" | grep -v -e '/bin/' -e '/sbin/' -e 'sys/fs/cgroup' -e '/run/' -e '/dev/' -e '/proc/')
        for one_file in $file_list; do
            if [[ $(echo $one_file | grep -E -e "$mask" | wc -m) -gt 0 ]]; then
                sudo rm -rf $one_file
            fi
        done
    fi
else 
    echo "Wrong mask type"
fi
