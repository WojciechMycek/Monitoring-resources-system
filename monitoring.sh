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

	#Define str to int from disk size

	blank=""
	point="."

	redefined_argument=$(echo "$argument" | sed "s/M/$blank/g")
	echo "Deleted M $redefined_argument"

	ready_argument=$(echo "$redefined_argument" | sed "s/,/$point/g")
	echo "Argument after clean-up $ready_argument"

	#TRANSFER STR TO INT
	float_argument=$(echo "$ready_argument" | bc)

	#check disk size
	if [ $float_argument > 2 ]
	then
		echo "ERROR: DISK SIZE EXCEDDED!!!"
	fi

}

disk_check_file
