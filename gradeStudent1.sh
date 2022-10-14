#!/bin/bash
#---Initialize Variable---
userInputError="1"
studentFile="$HOME/Desktop/SEM7_OS/database/student.txt"
isFound="0"

clear
echo "Student Validation Form"
echo "======================="
echo " "
echo -n "Please enter the student's ID Number  : "
read userInput_studentId

while IFS=':' read -r db_programme db_studentId db_studentName db_studentNRIC db_studentBirthdate db_gender db_studentContactNumber db_studentEmail; do
    if [ "$userInput_studentId" == "$db_studentId" ]; then
        isFound="1"
        saved_studentId=$db_studentId
        saved_studentName=$db_studentName
        saved_studentName=$db_studentName;
        saved_programme=$db_programme;
    fi
done < $studentFile

#---Error Message
if [ "$isFound" == "0" ]; then
    clear
    echo "**************************************************************"
    echo "*                                                            *";
    echo "*       Error, invalid student ID, please try again :(       *";
    echo "*                                                            *";
    echo "**************************************************************"
    echo " "
    echo -n "Enter any key to continue..."
    read;
    ./mainMenu.sh;
    exit 00;
fi

echo " ";
    echo "Student Name  : $saved_studentName";
    echo " ";
    echo "Programme    : $saved_programme";
    echo " "
    echo -n "Academic Year (YYYY)   : "
    read userInput_academicYear
    echo " "
    echo -n "Semester (1/2/3)   : "
    read userInput_semester

    #---Ask user if procedd to enter marks or go main menu
    while [ $userInputError = "1" ]
    do
        echo " "
        echo -n "Press (n) to continue to enter the student's marks or (q) to quit from the prompt : "
        read input

        case $input in
            n)
                ./gradeStudent2.sh $saved_studentId "$saved_studentName" $userInput_academicYear $userInput_semester; 
                userInputError="0";;
            q)
                ./mainMenu.sh; 
                userInputError="0";;
            *)
                echo "Please enter the correct input";read;;
        esac
    done


