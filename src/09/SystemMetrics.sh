cpu=`top -b | head -3 | tail +3 | awk '{print $2}'`
mem_free=`top -b | head -4 | tail +4 | awk '{print $6}'`
mem_used=`top -b | head -4 | tail +4 | awk '{print $8}'`
mem_cache=`top -b | head -4 | tail +4 | awk '{print $10}'`
diskIO=`iostat | head -7 | tail -1 | awk '{print $2}'`
freeram=`free | head -2 | tail -1 | awk '{print $4}'`
echo \# HELP s21_cpu_usage CPU usage.
echo \# TYPE s21_cpu_usage gauge
echo "s21_cpu_usage ${cpu}"
echo \# HELP s21_mem_free Free memory.
echo \# TYPE s21_mem_free gauge
echo "s21_mem_free ${mem_free}"
echo \# HELP s21_mem_used Used memory.
echo \# TYPE s21_mem_used gauge
echo "s21_mem_used ${mem_used}"
echo \# HELP s21_mem_cache Cashed memory.
echo \# TYPE s21_mem_cache gauge
echo "s21_mem_cache ${mem_cache}"
echo \# HELP s21_diskIO Input-output transactions.
echo \# TYPE s21_diskIO gauge
echo "s21_diskIO ${diskIO}"
echo \# HELP s21_free_ram Free RAM.
echo \# TYPE s21_free_ram gauge
echo "s21_free_ram ${freeram}"
