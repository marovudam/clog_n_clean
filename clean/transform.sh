function transform_folder_mask() {
    error=0
    reg=
    divide=($(echo $1 | tr "_" "\n"))
    letters=${divide[0]}
    date=${divide[1]}
    alpha_re='[a-zA-Z]{1}'; date_re='^[0-9]{6}$'
    for (( i=1; i<=$(echo -n $letters | wc -m); i++ )); do
    letter=$( echo $letters | cut -c$i-$i )
    if [[ $letter =~ $alpha_re ]]; then
        reg="$reg$letter+"
    else error=1
    fi
    done
    if ! [[ $date =~ $date_re ]]; then echo "error";
    elif [[ $error -ne 0 ]]; then echo "error";
    else echo $reg"_"$date; fi
}

function transform_file_mask() {
    error=0
    reg=
    divide=($(echo $1 | tr "_" "\n"))
    letters=${divide[0]}
    divide2=($(echo $letters | tr "." "\n"))
    letters=${divide2[0]}
    ext=${divide2[1]}
    date=${divide[1]}
    if [[ $ext == "" ]]; then error=1; fi
    reg=$(transform_folder_mask $letters"_"$date)
    reg=$reg"\."
    alpha_re='[a-zA-Z]{1}'; date_re='^[0-9]{6}$'
    for (( i=1; i<=$(echo -n $ext | wc -m); i++ )); do
        letter=$( echo $ext | cut -c$i-$i )
        if [[ $letter =~ $alpha_re ]]; then
            reg="$reg$letter+"
        else error=1
        fi
    done
    if [[ $error -ne 0 ]]; then echo "error";
    else echo $reg; fi
}