disk_check_file(){

#Function defined to provide information about disk and check how much is exceeded
#defining disk check
#	write output to disk.txt
#	grep after defining disk
#	awk used to get column and line
#writing disk size
#	take size of disk to argument
#define str to int from disk size
#	use sed to redefined output to redfine str to int
#	then transfere str to int and checkig if file size is meeting requirments
		
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

process_check_top(){

#Function defined to provide information about process in real time
#top to file
#	address top command output to file
#for i & awk
#	address column and lines and then print its out
#	then send output of awk to defined_top_lines
#	order to human readeable format in ordered_defined_top_lines.txt
	
	lists_cpu_value=()
	lists_cpu_value_transformed=()
	point="."

	#top to file
	top -b -n 1 > top.txt
	sed '1,6d' top.txt
	clear

	#grep -n "CPU" top.txt
	#cat cpu.txt

	for i in {1..5}
	do	
		for j in {1..4}
		do	
			column=$((8+$i))
			line=$((6+$j))
			argument=$(awk 'NR == '$line' {print $'$column'}' top.txt)
			awk 'NR == '$line' {print $'$column'}' top.txt >> defined_top_lines.txt
		done
	done

	#Order defined top values in human readeble form
	paste - - - - < defined_top_lines.txt > ordered_defined_top_lines.txt
	cat ordered_defined_top_lines.txt
	
	grep -n "CPU" ordered_defined_top_lines.txt
	
	#create new list and fill it with ordered lines from text file
	for i in {0..3}
	do
		line=1
		column=$((1+$i))
		lists_cpu_value[i]+=$(awk 'NR == '$line' {print $'$column'}' ordered_defined_top_lines.txt)
	done
	
	#For future equations make change from , to . to transform it easy from str type to float type
	for element in ${lists_cpu_value[@]}
	do
		echo "$element" | sed "s/,/$point/g" >> transformed.txt
	done

	#create new list of transformed values from previous list and create new one with output of modified text file
	for i in {1..4}
	do	
		column=1
		lists_cpu_value_transformed[i]+=$(awk 'NR == '$i' {print $'$column'}' transformed.txt)
	done
	
	#print values
	for element in ${lists_cpu_value_transformed[@]}
	do	
		echo "Przeformatowane wartosci w liscie $element"
	done
	
	#check which value is the biggest
	if [ $lists_cpu_value_transformed[1] == $lists_cpu_value_transformed[2] ] && [ $lists_cpu_value_transformed[2] == $lists_cpu_value_transformed[3] ]
	then
		echo "All process takes the same exxact amount of memory"
		echo "Memory of value eq: $lists_cpu_values[1]"
	elif [ $lists_cpu_value_transformed[1] > $lists_cpu_value_transformed[2] ] && [ $lists_cpu_value_transformed[2] > $lists_cpu_value_transformed[3] ]
	then
		echo "The biggest is: $lists_cpu_value_transformed[1]"
	elif [ $lists_cpu_value_transformed[2] > $lists_cpu_value_transformed[1] ] && [ $lists_cpu_value_transformed[2] > $lists_cpu_value_transformed[3] ]
	then
		echo "The biggest is: $lists_cpu_value_transformed[2]"
	else
		echo "The biggest is $lists_cpu_value_transformed[3]"
	fi
}

process_check_top
