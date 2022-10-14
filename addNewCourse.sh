#!/bin/bash
#---Initialize Variable
userInputError="1"
courseFile="$HOME/Desktop/SEM7_OS/database/course.txt"

#--Add New Course Form
clear
echo "Add New Course Form"
echo "====================="
echo " "
echo -n "Course Code         : "
read userInput_courseCode
echo -n "Course Name         : "
read userInput_courseName
echo -n "Credit Hours (1-12) : "
read userInput_creditHours
echo -n "Remarks             : "
read userInput_remarks

#---Save the record into student.txt
declare -a TmpWrite;
TmpWrite+=("$userInput_courseCode:$userInput_courseName:$userInput_creditHours:$userInput_remarks");
printf "%s\n" "${TmpWrite[@]}" >> $courseFile;

#---Ask user if wanna repeat or go main menu
while [ $userInputError = "1" ]
do
    echo " "
    echo -n "Add Another Course? (y)es or (q)uit :"
    read input

    case $input in
        y)
            ./addNewCourse.sh; 
            userInputError="0";;
        q)
            ./mainMenu.sh; 
            userInputError="0";;
        *)
            echo "Please enter the correct input";read;;
    esac
done