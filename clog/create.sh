#!/bin/bash

. ./vars.sh
. ./create_name.sh
log_filename=log_$(date +"%d_%m_%y_%H_%M_%S").log
sudo touch $log_filename
log_filename=$(pwd)/$log_filename
sudo chmod 777 $log_filename
mem_re="[0-9\.]{1,5}[TP]{1}|[1-9]{1,5}G|[1-9]{1,3}\.[0-9]{1,3}G"
folders=$(sudo find / -type d | grep -v -e '/bin/' -e '/sbin/' -e 'sys/fs/cgroup' -e '/run/' -e '/dev/' | shuf -n 198)
for folder in $folders; do
    mem=$(df -h --output=avail / | tail -1) 
    if ! [[ "$mem" =~ $mem_re ]]; then break; else
        folder_name=$(create_folder_name $dl_count $dl_max $dl)
        folder_name="$folder/$folder_name"
        if ! [ -d $folder_name ]; then
            sudo mkdir $folder_name 2> /dev/null
            if [[ -d $folder_name ]]; then
                file_count=$(( $RANDOM % 200))
                echo $folder_name/ $(date +"%d_%m_%y %H:%M:%S") >> $log_filename
                for (( l=0; l<file_count; l++ )); do
                    mem=$(df -h --output=avail / | tail -1) 
                    if ! [[ $mem =~ $mem_re ]]; then break; else
                        file_name=$(create_file_name $fl_count $fl_max $fl $el_count $el_max $el)
                        if ! [ -f $folder_name/$file_name ]; then
                            sudo xfs_mkfile $size $folder_name/$file_name
                            if [ -f $folder_name/$file_name ]; then
                                echo $folder_name/$file_name $(date +"%Y-%m-%d") $size >> $log_filename
                                (( file_count-- ))
                            fi
                        fi
                    fi
                done
            fi
        fi
    fi
done