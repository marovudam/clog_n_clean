#!/bin/bash
two_digit_re='^[0-9]{2}$|^[0-9]$'
day=${1#0}; month=${2#0}; year=${3#0}; hour=${4#0}; minute=${5#0}
if ! [[ $year -ge 1970 && $year -le 2023 || $year -le 99 && $year -ge 0 ]]; then
echo 3
elif ! [[ $month =~ $two_digit_re && $month -ge 1 && $month -le 12 ]]; then
    echo 2
elif ! [[ $day =~ $two_digit_re && $day -ge 1 && ( $day -le 30 && ( $month -eq 4 || $month -eq 6 || $month -eq 9 || $month -eq 11 ) || $month -eq 2 && ( $day -le 28 && $(( $year % 4 )) -eq 0 && $year -ne 2000 && $year -ne 0 || $day -le 27 && $month -eq 2 ) || $day -le 31 && ( $month -eq 1 || $month -eq 3 || $month -eq 5 || $month -eq 7 || $month -eq 8 || $month -eq 10 || $month -eq 12 ) ) ]]; then
    echo 1
elif ! [[ $hour =~ $two_digit_re && $hour -ge 0 && $hour -le 23 ]]; then
    echo 4
elif ! [[ $hour =~ $two_digit_re && $minute -ge 0 && $minute -le 59 ]]; then
    echo 5
else
    echo 0
fi