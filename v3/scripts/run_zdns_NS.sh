#! bin/bash

# Command -> nohup bash /home/tools/step_3_run_zdns.sh > /home/step_3.log &


# User
USER="ssh_user"
# Change Permission on /home Directory
sudo chmod 777 /home/ssh_user

# Start Time 
start=`date +%s`
SECONDS=0

# Setting up
date_today=`date +%Y%m%d`
seed_file="/home/$USER/seed/seed.txt"
result_file="/home/$USER/zdns_results/result_$date_today.out"
zdns="/home/$USER/tools/zdns"
record_type="NS"

# Getting IP Info
PUBLIC_IP_ADDRESS=`curl ipinfo.io/ip`

echo "#############################################################################################"
echo "#                                        ZDNS Scan                                          #"
echo "#############################################################################################"

echo ""
echo "Configurations"
echo "  > Date Today           : $date_today"
echo "  > Public IP Address    : $PUBLIC_IP_ADDRESS"
echo "  > Seed File Path       : $seed_file"
echo "  > Result File Path     : $result_file"
echo "  > ZDNS Executable Path : $zdns"
echo "  > Record Type          : $record_type"
echo ""

echo ""
echo "VM Information"
echo "  > CPU : "
# CPU_INFO=`lscpu | egrep 'Architecture|Model name|Socket|Thread|CPU\(s\)|CPU MHz|Virtualization type'`
CPU_INFO_ARCH=`lscpu | egrep 'Architecture' | awk '{split($0,a," "); print a[2]}'`
echo "    * Architecture: $CPU_INFO_ARCH"
CPU_INFO_MODEL_NAME=`lscpu | egrep 'Model name' | awk '{split($0,a," "); printf "%s %s %s %s %s", a[3], a[4], a[5], a[6], a[7]}'`
echo "    * Model Name  : $CPU_INFO_MODEL_NAME"
CPU_INFO_CPU_COUNT=`lscpu | egrep 'CPU\(s\)' | head -n 1 | awk '{split($0,a," "); print a[2]}'`
echo "    * Count       : $CPU_INFO_CPU_COUNT"
CPU_INFO_CLOCK_SPEED=`lscpu | egrep 'CPU MHz' | awk '{split($0,a," "); printf "%s MHz", a[3]}'`
echo "    * Clock Speed : $CPU_INFO_CLOCK_SPEED"
echo ""
echo "  > Meomry :"
TOTAL_RAM=`free -m | grep Mem | awk '{printf "%.0f MB\n", $2}'`
echo "    * Total Memory (RAM): $TOTAL_RAM"
echo ""

dateLocal=`date`
dateUTC=`date -u`
echo "(Start) Date Local: $dateLocal"
echo "(Start) Date UTC  : $dateUTC"
echo ""

noOfDomains=`wc -l $seed_file`
# Print No of Domains in the File to be Scanned
echo "No of Domain Names to be Scanned: $noOfDomains"

# Quick Fix 
ulimit -n 4096
    
# Run ZDNS Scan
echo "ZDNS Scan Begins..."
cat $seed_file | $zdns $record_type > $result_file
echo "Done Scanning"
echo ""

# End Time
end=`date +%s`

runtime=$((end-start))
hours=$((runtime / 3600))
minutes=$(( (runtime % 3600) / 60 ))
seconds=$(( (runtime % 3600) % 60 ));
echo "Execution Time : $hours:$minutes:$seconds (hh:mm:ss)"
echo "Time Elapsed   : $SECONDS seconds";

echo ""
dateLocal=`date`
dateUTC=`date -u`
echo "(End) Date Local: $dateLocal"
echo "(End) Date UTC: $dateUTC"

echo ""
echo "#############################################################################################"
echo "#                                        All Done                                           #"
echo "#############################################################################################"
