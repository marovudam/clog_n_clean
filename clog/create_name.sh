function create_str () {
    folder_name=
    for (( i=1; i<=$1; i++ )); do
    letter=$( echo $3 | cut -c$i-$i )
    letter_count=$(( $RANDOM % $2 + 4))
    for (( j=0; j<letter_count; j++ )); do folder_name="$folder_name$letter"; done
    done
    echo $folder_name
}

function create_folder_name () {
    folder_name=$(create_str $1 $2 $3)"_"$(date +"%d%m%y")
    echo $folder_name
}

function create_file_name () {
    file_name=$(create_str $1 $2 $3)"_"$(date +"%d%m%y")"."$(create_str $4 $5 $6)
    echo $file_name
}