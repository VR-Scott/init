#!/bin/bash

userinput=$1
# online="$(who | awk '{print $1}' | grep -o ^"$userinput"$)"
# # Use this line if you want to delete any non system user
# regardless of whether they are online or not.
# You may want to remove the killall aswell if you use this.
online="$(grep -o ^"$userinput" /etc/passwd)"

if [ "$EUID" -ne 0 ]
then
	echo "Script error: this script needs to be run with root priviledges."
	exit 1
fi

if [ "$userinput" == "$online" ]
then
	echo "The user \"$userinput\" is logged in, logging them out then deleting their account."
	killall -u "$userinput"
	deluser --remove-home "$userinput"
	echo "\"$userinput\" has been logged out and their account deleted."
else
	echo "The user \"$userinput\" is not logged in."
fi