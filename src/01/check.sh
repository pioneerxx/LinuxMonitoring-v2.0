#!/bin/bash

err=0

if [ $# != 6 ];
then
	err=1
else
	declare -x path=$1
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
	if ! [ -d $path ]; then
		err=2
	else
		:
	fi
	if [[ $fold_count =~ ^[0-9] ]] && [[ $fold_count -gt 0 ]]; then
		:
	else
		err=3
	fi
	if [[ $fold_name_length -le 7 ]] && [[ $fold_name =~ ^[a-z]+$ ]]; then
		:
	else
		err=4
	fi
	if [[ $file_count =~ ^[0-9]+$ ]] && [[ $file_count -gt 0 ]]; then
		:
	else
		err=5
	fi
	if [[ $file_name_ext =~ ^[a-z]+[.]+[a-z]+$ ]]; then
		if [[ $file_name_length -le 7 && $file_extension_length -le 3 ]]; then
			:
		else
			err=6
		fi
	else
		err=6
	fi
	if [[ $file_size -le 0 ]] || [[ $file_size -gt 100 ]]; then
		err=7
	else
		:
	fi
fi
echo $err
