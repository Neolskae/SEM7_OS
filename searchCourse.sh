#!/bin/bash
#---Initialize Variable---
userInputError="1"
courseFile="$HOME/Desktop/SEM7_OS/database/course.txt"
isFound="0"

#---Search Course Details Form---
clear
echo "Seach Course Details Form"
echo "=========================="
echo "  "

#---Prompt user for course Code---
echo -n "Enter Course Code: "
read userInput_courseCode;

#---Traverse through each record in course.txt and only display 
#---if course code provided by user is same with the one in the course.txt   
while IFS=':' read -r db_courseCode db_courseName db_creditHours db_remarks; do
    if [ "$userInput_courseCode" == "$db_courseCode" ]; then
        isFound="1"
        echo " "
        echo "Course Name   :  $db_courseName"
        echo "Credit Hours  :  $db_creditHours"
        echo "Remarks       :  $db_remarks"
        
    fi
done < $courseFile

#---Show this output if student record is not found
if [ $isFound = "0" ]; then
    echo " "
    echo "Course Record not Found"
fi

#---Ask user if wanna repeat or go main menu
while [ $userInputError = "1" ]
do
    echo " "
    echo -n "Search Another Course? (y)es or (q)uit :"
    read input

    case $input in
        y)
            ./searchCourse.sh; 
            userInputError="0";;
        q)
            ./mainMenu.sh; 
            userInputError="0";;
        *)
            echo "Please enter the correct input";read;;
    esac
done