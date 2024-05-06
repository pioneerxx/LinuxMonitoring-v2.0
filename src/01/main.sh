
#!/bin/bash

current_date=$(date +%D | awk -F / '{print $2$1$3}')

function folder_naming {
	local abc=$1
	local dir=$2
	local tmp=
	local name="$dir$abc"
	local last_symb="${abc: -1}"
	local name_length=${#abc}
	until [ $name_length -ge 4 ]
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
        until [ $name_length -eq 4 ] || [ $name_length -gt 4 ]
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

check=$(bash check.sh $@)

if [[ $check != 0 ]]; then
	case $check in
		1) echo 'There must be 6 parameters';;
		2) echo 'The first parameter must be an existing directory';;
		3) echo 'The second parameter must be a number and greater than 0';;
		4) echo 'Third parameter must be less than 8 characters and consisting only of a-z symbols';;
		5) echo 'Fourth parameter must be a number and greater than 0';;
		6) echo 'Fifth parameter must be *.*; first part must be less than 8 characters long and second less than 4';;
		7) echo "Sixth parameter must be greater than zero and less than 101";;
	esac
	exit
fi

declare -x path="$1/"
declare -x fold_count=$2
declare -x fold_name=$3
declare -x fold_name_length=`expr "$fold_name" : '.*'`
declare -x file_count=$4
declare -x file_name_ext=$5
declare -x file_name="$(echo $file_name_ext | cut -d. -f1)"
declare -x file_name_length=`expr $file_name : '.*'`
declare -x file_extension="${5##*.}"
declare -x file_extension_length=`expr $file_extension : '.*'`
declare -x file_size=`echo $6 | egrep -o ^[0-9+$]*`
declare -x current_path=$(pwd)
declare -x date_for_logs=$(date '+%Y-%m-%d %H:%M:%S')

if ! [[ -f "$current_path/scary_virus.log" ]]; then
	touch "$current_path/scary_virus.log"
fi

echo "---------------------------------------"
echo "|   INITIALIZING OPERATION JUNKYARD   |"
echo "---------------------------------------"
echo""
echo -n "Trashing in progress..."
for (( i = 0; i < $fold_count; i++  ))
do
	echo -n "."
	current_folder="$(folder_naming $fold_name $path)"
	mkdir $current_folder
	echo "$current_folder $date_for_logs" >> "$current_path/scary_virus.log"
	for (( j = 0; j < $file_count; j++  ))
	do
		space_left=$(df / | tail +2 | awk '{printf("%d", $4)}')
        	if [[ $space_left -le 1048576  ]]; then
                	break
        	fi
		current_file="$(file_naming $file_name $current_folder)"
		fallocate -l $file_size"KB" $current_file
		echo "$current_file $date_for_logs $file_size" >> "$current_path/scary_virus.log"
	done
	if [[ $space_left -le 1048576  ]]; then
		break
        fi
done
echo ""
echo ""
echo "**************************************"
echo "**TRASHING OF THE SYSTEM IS COMPLETE**"
echo "**************************************"
