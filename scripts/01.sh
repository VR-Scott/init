#!/usr/bin/bash

awk -F: '{print $1 ":" $3 ":" $7}' /etc/passwd