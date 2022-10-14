#!/bin/bash
#---Initialize Variable---
userInputError="1"
studentFile="$HOME/Desktop/SEM7_OS/database/student.txt"
isFound="0"

#---Search Student Details Form---
clear
echo "Seach Student Details Form"
echo "=========================="
echo "  "

#---Prompt user for student ID---
echo -n "Enter Student ID : "
read userInput_studentId;

#---Traverse through each record in student.txt and only display 
#---if student ID provided by user is same with the one in the student.txt
while IFS=':' read -r db_programme db_studentId db_studentName db_studentNRIC db_studentBirthdate db_gender db_studentContactNumber db_studentEmail; do
    if [ "$userInput_studentId" == "$db_studentId" ]; then
        isFound="1"
        echo " "
        echo "Programme      :  $db_programme"
        echo "Student Name   :  $db_studentName" 
        echo "NRIC           :  $db_studentNRIC" 
        echo "Birth Date     :  $db_studentBirthdate" 
        echo "Gender         :  $db_gender" 
        echo "Contact No.    :  $db_studentContactNumber"
        echo "Email          :  $db_studentEmail"
    fi
done < $studentFile

#---Show this output if student record is not found
if [ $isFound = "0" ]; then
    echo " "
    echo "Student Record not Found"
fi

#---Ask user if wanna repeat or go main menu
while [ $userInputError = "1" ]
do
    echo " "
    echo -n "Search Another Student? (y)es or (q)uit :"
    read input

    case $input in
        y)
            ./searchStudent.sh; 
            userInputError="0";;
        q)
            ./mainMenu.sh; 
            userInputError="0";;
        *)
            echo "Please enter the correct input";read;;
    esac
done



