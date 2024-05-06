#!/bin/bash
source funcs.sh

if [ $# != 0 ]; then
	echo "No parameters allowed"
	exit
fi

month="$(getMONTH)"
day="$(getDAY $month)"
year="$(getYEAR)"
hour=0
minute=0
second=15

echo -e "\033[1;33m                   \033[31m - - - - - - - - - - -\033[32m - - - - - - - - - - -\033[34m - - - - - - - - - - -"
echo -e "                   \033[31m/                                                               \033[34m/"
echo -e "                  \033[31m/                                                               \033[34m/"
echo -e "                 \033[31m/                    \033[37mN\033[31mG\033[32mI\033[34mN\033[35mX \033[37mL\033[31mO\033[32mG\033[34mF\033[35mI\033[37mL\033[31mE \033[32mG\033[34mE\033[35mN\033[37mE\033[31mR\033[32mA\033[34mT\033[35mO\033[37mR                    \033[34m/"
echo -e "                \033[31m/                                                               \033[34m/"
echo -e "               \033[31m/                                                               \033[34m/"
echo -e "               \033[31m- - - - - - - - - - -\033[32m - - - - - - - - - - -\033[34m - - - - - - - - - -\033[37m"

for (( i = 0; i < 5; i++ ))
do
        date="$day/$month/$year"
        filename="${day}-${month}-${year}.log"
        touch "$filename"
        if [[ $i -gt 0  ]]; then
                echo "done"
        else
                echo ""
        fi
        echo -n "Logfile $filename is being filled out.."
        iter=$(shuf -i 100-1000 -n 1)
        for (( j = 0; j < iter; j++ ))
        do
                echo -n "."
                ttime="$second:$minute:$hour"
                query="$(getQUERY)"
                url="$(getURL)"
                code="$(getCODE)"
                agent="$(getAGENT)"
                ip="$(getIP)"
                echo "$ip - - [${date}:${ttime} +0300] \"${query} ${url}\" ${code} - - \"${agent}\"" >> "$filename"
                tmp="$(addMINUTE $minute $hour)"
                minute="$(echo $tmp | awk '{print $1}')"
                hour="$(echo $tmp | awk '{print $2}')"
        done
        if [ $i -eq 4 ]; then
                echo "done"
                break
        fi
        newdate="$(addDAY $day $month $year)"
        day="$(echo $newdate | awk '{print $1}')"
        month="$(echo $newdate | awk '{print $2}')"
        year="$(echo $newdate | awk '{print $3}')"
done

echo ""
echo "Logfiles are done :)"


#200 - OK
#201 - CREATED
#400 - BAD REQUEST
#401 - UNAUTHORIZED
#403 - FORBIDDEN
#404 - NOT FOUND
#500 - INTERNAL SERVER ERROR
#501 - NOT IMPLEMENTED
#502 - BAD GATEWAY
#503 - SERVICE UNAVAILABLE
#504 - GATEWAY TIMEOUT
