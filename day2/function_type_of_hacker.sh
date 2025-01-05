#!/bin/bash

<< disclaimer
This is just script
disclaimer

# This io the function defination

function is_hacker() {
read -p "What $1 will do : " Responsibilities
read -p "Scanning percentage % for vulnerabilities : " Scanning

if [[ $Responsibilities == "solving the issues" ]];
then
	echo "White hat $1"
elif [[ $Scanning -ge 90 ]];
then
	echo "White hat $1"
else
	echo "Black hat $1"
fi
}

# This is function call

is_hacker "Hammad"
