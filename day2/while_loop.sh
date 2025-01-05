#!/bin/bash

# This is while loop

num=0

while [[ $num -le 10 ]]
do
	echo $num
	num=$((num+2))
done
