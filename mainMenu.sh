#!/bin/bash
#---Initialize Variable
userInputError="1"
studentFile="$HOME/Desktop/SEM7_OS/student.txt"

while [ $userInputError = "1" ]
do
    clear

    echo "University Management Menu"
    echo "=========================="
    echo "1 – Add New Student"
    echo "2 – Search Student Details"
    echo "3 – Add New Course"
    echo "4 – Search Course Details"
    echo "5 – Grade Student"
    echo "     "
    echo "Q – Quit (exit from program)"
    echo "     "
    echo -n "Please select a choice: "
    read input;

    case $input in
        1)
            ./addNewStudent.sh;
            userInputError="0";;
        2)
            ./searchStudent.sh;
            userInputError="0";;
        3)
            ./addNewCourse.sh;
            userInputError="0";;
        4)
            ./searchCourse.sh;
            userInputError="0";;
        5)
            ./gradeStudent1.sh;
            userInputError="0";;
        Q)
            clear;
            userInputError="0";
            exit 00;;
        *)
            echo "Please enter the correct input";read;;
    esac
done
clear





