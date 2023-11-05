#! /bin/bash

echo "--------------------------
User Name: 최경일
Student Number: 12202538
[ MENU ]
1. Get the data of the movie identified by a specific 
'movie id' from 'u.item'
2. Get the data of action genre movies from 'u.item’
3. Get the average 'rating’ of the movie identified by 
specific 'movie id' from 'u.data’
4. Delete the ‘IMDb URL’ from ‘u.item
5. Get the data about users from 'u.user’
6. Modify the format of 'release date' in 'u.item’
7. Get the data of movies rated by a specific 'user id' 
from 'u.data'
8. Get the average 'rating' of movies rated by users with 
'age' between 20 and 29 and 'occupation' as 'programmer'
9. Exit
--------------------------"

stop="N"
until [ $stop = "Y" ]
do
	read -p "Enter your choice [ 1-9 ] " choice

	if [ $choice = "1" ];then
		echo
		read -p "Please enter 'movie id'(1~1682) : " movieId
		awk -v movieId=$movieId 'NR==movieId {print "\n" $0}' u.item
		echo 
	elif [ $choice = "2" ];then
		echo
		read -p "Do you want to get the data of 'action' genre movies from 'u.item'?(y/n) : " yesNo
		echo
		if [ $yesNo = "y" ];then
			awk -F "|" '$7 == 1 {print $1 " " $2}' u.item | head -10
		fi
		echo
	elif [ $choice = "3" ];then
		echo
		read -p "Please enter the 'movie id' (1~1682) : " movieId
		sum=0
		count=0
		cat u.data | awk -v movieId=$movieId '$2==movieId {sum += $3; count++} 
			END {printf("average rating of %d : %.6f\n", movieId, sum/count)}'
		echo
	elif [ $choice = "4" ];then
		echo
		read -p "Do you want to delete the ‘IMDb URL’ from ‘u.item’?(y/n) : " yesNo
		if [ $yesNo = "y" ];then
			echo
			sed '1,1682 s/http.*)|/|/g' u.item | head -10
		fi
		echo
	elif [ $choice = "5" ];then
		echo
		read -p "Do you want to get the data about users from 'u.user'?(y/n) : " yesNo
		echo
		if [ $yesNo = "y" ];then
			awk -F "|" '{
				gender = ($3 == "M") ? "male" : "female";
				printf "user %s is %s years old %s  %s\n", $1, $2, gender, $4 
			}' u.user | head -10
		fi
		echo 
	elif [ $choice = "6" ];then
		echo
		read -p "Do you want to Modify the format of ‘release data’ in ‘u.item’?(y/n) : " yesNo
		echo
		if [ $yesNo = "y" ]; then
			cat u.item | sed -e 's|Jan|01|g' -e 's|Feb|02|g' -e 's|Mar|03|g' -e 's|Apr|04|g' -e 's|May|05|g' -e 's|Jun|06|g' -e 's|Jul|07|g' -e 's|Aug|08|g' -e 's|Sep|09|g' -e 's|Oct|10|g' -e 's|Nov|11|g' -e 's|Dec|12|g' | sed -e 's|^\([0-9]\{2\}\)-\([0-9]\{2\}\)-\([0-9]\{4\}\)|\3\2\1|g' | sed 's|-||g' | tail -10
		fi
		echo
	elif [ $choice = "7" ];then
		echo
		read -p "Please enter the 'user id' (1~943): " userId

		echo
	elif [ $choice = "8" ];then
		echo
		read -p "Do you want to get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'?(y/n) : " yesNo
		if [ $yesNo = "y" ];then
			echo 	
		fi
		echo

	elif [ $choice = "9" ];then
		stop="Y"
		echo "Bye!"
	else
		echo "다시 입력하세요"
	fi	
done
