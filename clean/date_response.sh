function respond () {
    if [[ $1 -eq 1 ]]
    then
        echo "Something is wrong with the day"
    elif [[ $1 -eq 2 ]]
    then
        echo "Something is wrong with the month"
    elif [[ $1 -eq 3 ]]
    then
        echo "Something is wrong with the year"
    elif [[ $1 -eq 4 ]]
    then
        echo "Something is wrong with hours"
    elif [[ $1 -eq 5 ]]
    then
        echo "Something is wrong with minutes"
    else
        echo "Unknown error"
    fi
}