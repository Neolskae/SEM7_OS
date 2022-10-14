#!/bin/bash
#---Initialize Variable
userInputError="1"
studentFile="$HOME/Desktop/SEM7_OS/database/student.txt"

#---Programme Selection Menu
while [ $userInputError = "1" ]
do
    clear
    echo "Programme Selections Menu"
    echo "========================="
    echo "A – RIT (Bachelor in Information Technology)";
    echo "B – RSD (Bachelor in Software Development)";
    echo "C – RST (Bachelor in Interactive Software Technology)";
    echo "D – REI (Bachelor in Enterprise Information System)";
    echo "E – RSF (Bachelor in Software Engineering)"
    echo "F – RDS (Bachelor in Data Science)"
    echo "G – RIS (Bachelor in Information Security)"
    echo "H – RBU (Bachelor in Business Administration)"
    echo "I – RAF (Bachelor in Accounting & Finance)"
    echo "      "
    echo "Q –Quit (Return to University Management Menu)"
    echo "     "
    echo -n "Please select a choice: "
    read input;

    case $input in
        A)
            userInput_programme="RIT";
            userInputError="0";;
        B)
            userInput_programme="RSD"
            userInputError="0";;
        C)
            userInput_programme="RST"
            userInputError="0";;
        D)
            userInput_programme="REI"
            userInputError="0";;
        E)
            userInput_programme="RSF"
            userInputError="0";;
        F)
            userInput_programme="RDS"
            userInputError="0";;
        G)
            userInput_programme="RIS"
            userInputError="0";;
        H)
            userInput_programme="RBU"
            userInputError="0";;
        I)
            userInput_programme="RAF"
            userInputError="0";;
        Q)
            ./mainMenu.sh && exit 00;;
        *)
            echo "Please enter the correct input";read;;
    esac
done

#---Add New Student Form
clear
echo "Add New Student Form"
echo "====================="
echo " "
echo -n "Student ID               : "
read userInput_studentID

echo -n "Full Name                : "
read userInput_studentName

echo -n "NRIC / Passport Number   : "
read userInput_studentNRIC

echo -n "Birth Date (DD/MM/YYYY)  : "
read userInput_studentBirthdate

echo -n "Gender                   : "
read userInput_gender

echo -n "Contact Number           : "
read userInput_studentContactNumber

echo -n "Email Address            : "
read userInput_studentEmail

userInputError="1"

#---Save the record into student.txt
declare -a TmpWrite;
TmpWrite+=("$userInput_programme:$userInput_studentID:$userInput_studentName:$userInput_studentNRIC:$userInput_studentBirthdate:$userInput_gender:$userInput_studentContactNumber:$userInput_studentEmail");
printf "%s\n" "${TmpWrite[@]}" >> $studentFile;

#---Ask user if wanna repeat or go main menu
while [ $userInputError = "1" ]
do
    echo " "
    echo -n "Add Another Student? (y)es or (q)uit : "
    read input

    case $input in
        y)
            ./addNewStudent.sh; 
            userInputError="0";;
        q)
            ./mainMenu.sh; 
            userInputError="0";;
        *)
            echo "Please enter the correct input";read;;
    esac
done

