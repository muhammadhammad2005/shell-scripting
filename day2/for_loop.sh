#!/bin/bash

# This is for and loops

<< comment
$1 is argument which is folder name
$2 is start range
$3 is end range

# This is created with arguments

for (( num=$2 ; num<=$3 ; num++ ))
do
	mkdir "$1$num"
done

# This is simple

for (( num=1 ; num<=5 ; num++ ))
do
        mkdir "demo$num"
done
comment
