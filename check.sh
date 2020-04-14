#! /usr/bin/bash



#pentru a afisa output-ul pentru Valgrind modifica output_mode in 1
output_mode=0

mkdir tmp
clear
make


for((j=1;j<=4;j++)); do
echo -e "\e[48;5;27m ///////////////////////////////// TASK-ul $j ////////////////////////////////////\e[0m"

if [[ j -eq 3 ]] || [[ j -eq 2 ]]
then
	for((i=1;i<=9;i++)); do
	#echo -e "\e[1;31m///////////////////////////////// TESTUL $i //////////////////////////////////\e[0m"
		if [[ output_mode -eq 0 ]]
			then
				THEN=$(date +%s%N | cut -b1-13)
				valgrind --track-origins=yes --leak-check=full ./minimax -c$j tests/task0$j/in/test$i.in tmp/iesire$i  2> /dev/null
				NOW=$(date +%s%N | cut -b1-13)
			else
				THEN=$(date +%s%N | cut -b1-13)
				valgrind --track-origins=yes --leak-check=full ./minimax -c$j tests/task0$j/in/test$i.in tmp/iesire$i
				NOW=$(date +%s%N | cut -b1-13)
		fi
		TOTAL=$(($NOW-$THEN))
		RESULT=$(diff -qs tests/task0$j/ref/test$i.out tmp/iesire$i)
		if [[ $(echo $RESULT | grep differ | wc -l ) -eq 0 ]]
		then
		echo -e "\e[1;40;92m $RESULT and it took ${TOTAL}ms\e[0m"
		elif [[ $(echo $RESULT | grep identical | wc -l ) -eq 0 ]]
		then
		echo -e "\e[1;40;91m$RESULT and it took ${TOTAL}ms\e[0m"
		fi
	done
	rm tmp/iesire*
else
for((i=1;i<=5;i++));
do
	#echo -e "\e[1;31m///////////////////////////// TESTUL $i //////////////////////////////////\e[0m"
	if [[ j -ne 4 ]]
	then
		if [[ output_mode -eq 0 ]]
		then
			THEN=$(date +%s%N | cut -b1-13)
			valgrind --track-origins=yes --leak-check=full ./minimax -c$j tests/task0$j/in/test$i.in tmp/iesire$i  2> /dev/null
			NOW=$(date +%s%N | cut -b1-13)
		else
			THEN=$(date +%s%N | cut -b1-13)
			valgrind --track-origins=yes --leak-check=full ./minimax -c$j tests/task0$j/in/test$i.in tmp/iesire$i
			NOW=$(date +%s%N | cut -b1-13)
		fi
	else
	if [[ output_mode -eq 0 ]]
		then
			THEN=$(date +%s%N | cut -b1-13)
			valgrind --track-origins=yes --leak-check=full ./minimax -b tests/task0$j/in/test$i.in tmp/iesire$i  2> /dev/null
			NOW=$(date +%s%N | cut -b1-13)
		else
			THEN=$(date +%s%N | cut -b1-13)
			valgrind --track-origins=yes --leak-check=full ./minimax -b tests/task0$j/in/test$i.in tmp/iesire$i
			NOW=$(date +%s%N | cut -b1-13)
		fi

	fi
	TOTAL=$(($NOW-$THEN))
	RESULT=$(diff -qs tests/task0$j/ref/test$i.out tmp/iesire$i)
	if [[ $(echo $RESULT | grep differ | wc -l ) -eq 0 ]]
	then
	echo -e "\e[1;40;92m $RESULT and it took ${TOTAL}ms\e[0m"
	elif [[ $(echo $RESULT | grep identical | wc -l ) -eq 0 ]]
	then
	echo -e "\e[1;40;91m$RESULT and it took ${TOTAL}ms\e[0m"
	fi
done
rm tmp/iesire*
fi

#rm tmp/iesire*

done;
rm -r tmp
rm minimax

