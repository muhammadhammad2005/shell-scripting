#!/bin/bash

read -p "Enter the username : " username

echo "You entered the $username"

sudo useradd -m $username

echo "New USER ADDED"

sudo passwd $username

echo "$username Password successfully added"
