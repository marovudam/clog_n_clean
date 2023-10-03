#!/bin/bash
file_list=$( sudo cat ../02/log_*.log | awk {'print $1'} )
for one_file in $file_list
do
sudo rm -rf $one_file
done