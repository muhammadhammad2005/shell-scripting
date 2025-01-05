#!/bin/bash

<< disclaimer
This is just script
disclaimer

read -p "What hacker will do : " Responsibilities
read -p "Scanning percentage % for vulnerabilities : " Scanning

if [[ $Responsibilities == "solving the issues" ]];
then
	echo "White hat hacker"
elif [[ $Scanning -ge 90 ]];
then
	echo "White hat hacker"
else
	echo "Black hat hacker"
fi

