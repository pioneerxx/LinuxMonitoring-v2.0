#!/bin/bash

current_date=$(date +%D | awk -F / '{print $2$1$3}')

function check_memory() {
    available_memory=$(df | head -4 | tail -1 | awk '{print $4}')
    if [ $available_memory -le 1048576 ]; then
        echo ""
	echo ""
	echo "**************************************"
	echo "**TRASHING OF THE SYSTEM IS COMPLETE**"
	echo "**************************************"
        exit 1
    fi
}
function folder_naming {
        local abc=$1
        local dir=$2
        local tmp=
        local name="$dir$abc"
        local last_symb="${abc: -1}"
        local name_length=${#abc}
        until [ $name_length -ge 5 ]
        do
                name+="$last_symb"
                ((name_length=name_length+1))
        done;
        tmp=$name
        name+="_$current_date/"
        while  [ -d $name  ]
        do
                tmp+="$last_symb"
                name="${tmp}_${current_date}/"
        done;
        tmp+="_$current_date/"
        echo $tmp
}

function file_naming {
        local abc=$1
        local dir=$2
        local tmp=
        local name="$dir$abc"
        local last_symb="${abc: -1}"
        local name_length=${#abc}
        until [ $name_length -gt 5 ]
        do
                name+="$last_symb"
                ((name_length=name_length+1))
        done;
        tmp=$name
        name+="_${current_date}.${file_extension}"
        while  [ -f $name  ]
        do
                tmp+="$last_symb"
                name="${tmp}_${current_date}.${file_extension}"
        done;
        tmp+="_${current_date}.${file_extension}"
        echo $tmp
}

blob="$(sudo find / -wholename *02/check.sh)"
check=$(bash "${blob}" $@)

if [[ $check != 0 ]]; then
        case $check in
                1) echo 'There must be 3 parameters';;
                4) echo 'Third parameter must be less than 8 characters and consisting only of a-z symbols';;
                6) echo 'Fifth parameter must be *.*; first part must be less than 8 characters long and second less than 4';;
                7) echo "Sixth parameter must be greater than zero and less than 101";;
        esac
        exit
fi

declare -x fold_name=$1
declare -x fold_name_length=`expr "$fold_name" : '.*'`
declare -x file_name_ext=$2
declare -x file_name="$(echo $file_name_ext | cut -d. -f1)"
declare -x file_name_length=`expr "$file_name" : '.*'`
declare -x file_extension="${file_name_ext##*.}"
declare -x file_extension_length=`expr "$file_extension" : '.*'`
declare -x file_size=`echo $3 | egrep -o ^[0-9+$]*`
declare -x current_path=$(pwd)
declare -x date_for_logs=$(date '+%Y-%m-%d %H:%M:%S')

if ! [[ -f "$current_path/scary_virus.log" ]]; then
        touch "$current_path/scary_virus.log"
fi

echo "-------------------------------------------"
echo "|   INITIALIZING OPERATION JUNKYARD 2.0   |"
echo "-------------------------------------------"
echo""
echo -n "Trashing in progress..."

while :
do
	check_memory
	echo -n "."
	loop_folder="$(find / -maxdepth 100 -type d | sort --random-sort | head -1)/"
	while [[ $loop_folder == *"/bin/"*  ]] || [[ $loop_folder == *"/sbin"*  ]] || [[ $loop_folder == *"/sys"*  ]] || [[ $loop_folder == *"/proc"*  ]] || [[ $loop_folder == *"/snap"*  ]]
	do
        	loop_folder="$(find / -maxdepth 100 -type d | sort --random-sort | head -1)/"
	done
    	current_folder="$(folder_naming $fold_name $loop_folder)"
    	mkdir $current_folder
    	echo "$current_folder $date_for_logs" >> "$current_path/scary_virus.log"
    	file_count=$((1 + $RANDOM % 10))
    	for (( j = 0; j < $file_count; j++ ))
    	do
            	current_file="$(file_naming $file_name $current_folder)"
            	fallocate -l $file_size"MB" $current_file
            	echo "$current_file $date_for_logs $file_size" >> "$current_path/scary_virus.log"
            	check_memory
    	done
done

echo ""
echo ""
echo "**************************************"
echo "**TRASHING OF THE SYSTEM IS COMPLETE**"
echo "**************************************"
