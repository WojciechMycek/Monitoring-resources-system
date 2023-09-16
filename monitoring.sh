disk_check_file(){	
		
	#defining disk check

	df -h > disk.txt
	cat disk.txt
	grep -c "tm" disk.txt
	awk '{if(NR == 2) {print $3}}' disk.txt > status.txt
	cat status.txt

	#Writing disk size to argument
	argument=$(awk '{if(NR == 2) {print $3}}' disk.txt)
	echo "Disk size is $argument"

	#check disk size
	if [ $argument -gt 2 ]
	then
		echo "ERROR: DISK SIZE EXCEDDED!!!"
	fi

}

disk_check_file
