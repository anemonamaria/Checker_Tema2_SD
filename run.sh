#! /usr/bin/bash

clear
gcc -w -g main.c -std=c99

functia=2
output_mode=0
#read output_mode

for((j=1;j<=4;j++)); do

echo -e "\e[1;33m///////////////////////////// TASK-ul $j //////////////////////////////////\e[0m"

FILE_NAME=$(date +%s)
#echo $FILE_NAME

for((i=1;i<=5;i++)); do

#echo -e "\e[1;31m///////////////////////////// TESTUL $i //////////////////////////////////\e[0m"

if [[ j -ne 4 ]]
then
	if [[ output_mode -eq 0 ]]
	then
		THEN=$(date +%s%N | cut -b1-13)
		valgrind --track-origins=yes --leak-check=full ./a.out -c$j public_tests/task0$j/in/test$i.in iesire$i  2> /dev/null
		NOW=$(date +%s%N | cut -b1-13)
	else
		THEN=$(date +%s%N | cut -b1-13)
		valgrind --track-origins=yes --leak-check=full ./a.out -c$j public_tests/task0$j/in/test$i.in iesire$i
		NOW=$(date +%s%N | cut -b1-13)
	fi
else
	if [[ output_mode -eq 0 ]]
	then
		THEN=$(date +%s%N | cut -b1-13)
		valgrind --track-origins=yes --leak-check=full ./a.out -b public_tests/task0$j/in/test$i.in iesire$i  2> /dev/null
		NOW=$(date +%s%N | cut -b1-13)
	else
		THEN=$(date +%s%N | cut -b1-13)
		valgrind --track-origins=yes --leak-check=full ./a.out -b public_tests/task0$j/in/test$i.in iesire$i
		NOW=$(date +%s%N | cut -b1-13)
	fi
fi



#--show-leak-kinds=all --leak-check=full
RESULT=$(diff -qs public_tests/task0$j/ref/test$i.out iesire$i)

TOTAL=$(($NOW-$THEN))

if [[ $(echo $RESULT | grep differ | wc -l ) -eq 0 ]]
then
echo -e "\e[1;40;92m $RESULT and it took ${TOTAL}ms\e[0m"
elif [[ $(echo $RESULT | grep identical | wc -l ) -eq 0 ]]
then
echo -e "\e[1;40;91m$RESULT and it took ${TOTAL}ms\e[0m"
fi


done;
#cat $FILE_NAME.out
rm iesire*

done;
rm a.out

