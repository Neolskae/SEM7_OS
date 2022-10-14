#!/bin/bash
#---Initialize and declare variable
saved_studentId=$1
saved_studentName=$2
userInput_academicYear=$3
userInput_semester=$4
iteration=0
repeatEnterMarks="1"
userInputError="1" 
declare -a print_courseCodeArray
declare -a print_marksArray
declare -a print_gradeArray
declare -a print_remarksArray
declare -a print_qualityPointArray
declare -a print_gpaArray
print_totalQualityPoints=0
print_totalGPA=0
courseFile="$HOME/Desktop/SEM7_OS/database/course.txt"
fileName="$saved_studentId-Result.txt"
studentResultFile="$HOME/Desktop/SEM7_OS/studentResults/$fileName"
isFound="0"

while [ $repeatEnterMarks = "1" ]
do
    userInputError="1"
    clear

    echo "Student Examination Marks Form"
    echo "=============================="
    echo " "
    echo -n "Please enter the course code : "
    read userInput_courseCode

    while IFS=':' read -r db_courseCode db_courseName db_creditHours db_remarks; do
        if [ "$userInput_courseCode" == "$db_courseCode" ]; then
            isFound="1"
            saved_courseCode=$db_courseCode
            saved_courseName=$db_courseName;
            saved_creditHours=$db_creditHours;
        fi
    done < $courseFile

    #---Error Message
    if [ "$isFound" == "0" ]; then
        clear
        echo "**************************************************************"
        echo "*                                                            *";
        echo "*       Error, invalid Course Code, please try again :(      *";
        echo "*                                                            *";
        echo "**************************************************************"
        echo " "
        echo -n "Enter any key to continue..."
        read;
        ./mainMenu.sh;
        exit 00;
    fi

    echo " "
    echo "Course Name : $saved_courseName"
    echo " "
    
    echo -n "Please enter the marks obtained : "
    read userInput_studentMarks;

    #---Add record into respective arrays
    print_courseCodeArray[iteration]=$saved_courseCode
    print_marksArray[iteration]=$userInput_studentMarks

    if (( "$userInput_studentMarks" > 100 )); then
        userInputError="1"
    elif (( "$userInput_studentMarks" >= 80 )); then
        userInputError="0"
        print_gradeArray[iteration]="A"
        print_remarksArray[iteration]="Excellent"
        print_gpaArray[iteration]=4                                            #Print one by one
        tmp_gpa=4                                                              #For average GPA
        print_qualityPointArray[iteration]=`echo $saved_creditHours*4 | bc -l` #Print one by one
        tmp_qualityPoint=`echo $saved_creditHours*4 | bc -l`                   #For total quality point
    elif (( "$userInput_studentMarks" >= 75 )); then 
        userInputError="0"
        print_gradeArray[iteration]="A-"
        print_remarksArray[iteration]="Excellent"
        print_gpaArray[iteration]=3.75
        tmp_gpa=3.75 
        print_qualityPointArray[iteration]=`echo $saved_creditHours*3.75| bc -l`
        tmp_qualityPoint=`echo $saved_creditHours*3.75 | bc -l`
    elif (( "$userInput_studentMarks" >= 70 )); then
        userInputError="0"
        print_gradeArray[iteration]="B+"
        print_remarksArray[iteration]="Good"
        print_gpaArray[iteration]=3.5
        tmp_gpa=3.5 
        print_qualityPointArray[iteration]=`echo $saved_creditHours*3.5 | bc -l`
        tmp_qualityPoint=`echo $saved_creditHours*3.5 | bc -l`
    elif (( "$userInput_studentMarks" >= 65 )); then
        userInputError="0"
        print_gradeArray[iteration]="B"
        print_remarksArray[iteration]="Good"
        print_gpaArray[iteration]=3
        tmp_gpa=3
        print_qualityPointArray[iteration]=`echo $saved_creditHours*3 | bc -l`
        tmp_qualityPoint=`echo $saved_creditHours*3 | bc -l`
    elif (( "$userInput_studentMarks" >= 60 )); then
        userInputError="0"
        print_gradeArray[iteration]="B-"
        print_remarksArray[iteration]="Pass"
        print_gpaArray[iteration]=2.75
        tmp_gpa=2.75
        print_qualityPointArray[iteration]=`echo $saved_creditHours*2.75 | bc -l`
        tmp_qualityPoint=`echo $saved_creditHours*2.75 | bc -l`
    elif (( "$userInput_studentMarks" >= 55 )); then
        userInputError="0"
        print_gradeArray[iteration]="C+"
        print_remarksArray[iteration]="Pass"
        print_gpaArray[iteration]=2.5
        tmp_gpa=2.5 
        print_qualityPointArray[iteration]=`echo $saved_creditHours*2.5 | bc -l`
        tmp_qualityPoint=`echo $saved_creditHours*2.5 | bc -l`
    elif (( "$userInput_studentMarks" >= 50 )); then
        userInputError="0"
        print_gradeArray[iteration]="C"
        print_remarksArray[iteration]="Pass"
        print_gpaArray[iteration]=2
        tmp_gpa=2
        print_qualityPointArray[iteration]=`echo $saved_creditHours*2| bc -l`
        tmp_qualityPoint=`echo $saved_creditHours*2 | bc -l`
    elif (( "$userInput_studentMarks" >= 0 )); then
        userInputError="0"
        print_gradeArray[iteration]="F"
        print_remarksArray[iteration]="Failed"
        print_gpaArray[iteration]=0
        tmp_gpa=0 
        print_qualityPointArray[iteration]=`echo $saved_creditHours*0  | bc -l`
        tmp_qualityPoint=`echo $saved_creditHours*0 | bc -l`
    else
        userInputError="1"
    fi

    print_totalQualityPoints=`echo $print_totalQualityPoints+$tmp_qualityPoint | bc -l`
    print_totalGPA=`echo $print_totalGPA+$tmp_gpa| bc -l`
    
    #---Error Message
    if [ "$userInputError" == "1" ]; then
        clear
        echo "********************************************************"
        echo "*                                                      *";
        echo "*       Invalid Marks Range, please try again :(       *";
        echo "*                                                      *";
        echo "********************************************************"
        echo " "
        echo -n "Enter any key to continue..."
        read;
        ./mainMenu.sh;
        exit 00;
    fi

    #---Ask user if wanna repeat or go main menu
    userInputError="1"
    while [ $userInputError = "1" ]; do
        echo " "
        echo -n "Press (y) to continue to enter the student's marks or (b) to generate exam result : "
        read input

        case $input in
            y)
                iteration=$(( $iteration + 1 ));
                userInputError="0";;
            b)
                repeatEnterMarks="0";
                userInputError="0";;
            *)
                echo "Please enter the correct input";read;;
        esac
    done
done

#--clear StudentResult file
printf "" > $studentResultFile;

#---Saved Record into Student Results Folder
declare -a TmpWrite;
TmpWrite+=("Student ID    : $saved_studentId \n");
TmpWrite+=("Student Name  : $saved_studentName \n");
TmpWrite+=("Academic Year : $userInput_academicYear \n");
TmpWrite+=("Semester      : $userInput_semester \n");
TmpWrite+=("\n");
TmpWrite+=("=====================================================================================================\n");
TmpWrite+=("CourseCode:         Marks:          Grade:          Remarks:        Grade Points:      Quality Point: \n");
TmpWrite+=("=====================================================================================================\n");
printf "%b" "${TmpWrite[@]}" >> $studentResultFile;

#---For Loop for 5 different arrays
for (( i=0; i<=$iteration; i++ ))
do
    printf "%-20s" "${print_courseCodeArray[$(($i))]}" >> $studentResultFile;
    printf "%-16s" "${print_marksArray[$(($i))]}" >> $studentResultFile;
    printf "%-16s" "${print_gradeArray[$(($i))]}" >> $studentResultFile;
    printf "%-16s" "${print_remarksArray[$(($i))]}" >> $studentResultFile;
    
    printf "%-19s" "${print_gpaArray[$(($i))]}" >> $studentResultFile;
    
    printf "%-14s" "${print_qualityPointArray[$(($i))]}" >> $studentResultFile;
    printf "%b" "\n" >> $studentResultFile;
done

printf "%b" "\n" >> $studentResultFile;
printf "%b" "" >> $studentResultFile;

noSubject=$(( $iteration + 1 ))
avgGPA=`echo $print_totalGPA / $noSubject | bc -l`

printf "%b" "                                                                 Total Quality Point:  " >> $studentResultFile;
printf "%b" "$print_totalQualityPoints" >> $studentResultFile;
printf "%b" "\n" >> $studentResultFile;   #Newline
printf "%b" "                                                                                 GPA:  " >> $studentResultFile;
printf "%.2f" " $avgGPA" >> $studentResultFile;

#---Success Message
clear;
echo "********************************************************"
echo "*                                                      *";
echo "*       Exam Result Successfully Generated! :)         *";
echo "*                                                      *";
echo "********************************************************"
echo " "
echo -n "Enter any key to continue..."
read;
./mainMenu.sh;




