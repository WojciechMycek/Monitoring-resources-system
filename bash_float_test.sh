#!/bin/bash

num1=3.33
num2=3.33
list1=()
list2=()

list1+=2.2
list2+=2.2


if (( $(echo "$num1 >= $num2" |bc -l)))
then
	echo LOL
else
	echo ROFTL
fi

compare_float(){
	if (( $(echo "$num1 >= $num2" |bc -l)))
	then
		echo JESTESMY ROWNE
	fi
}

compare_float "${list1[0]}" "${list2[0]}"
