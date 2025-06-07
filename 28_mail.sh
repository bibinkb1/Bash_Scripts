#!/bin/bash

# Generate output
output=$(df -h)

# Send it via email
echo "$output" | mail -s "Disk Usage Report" bibin.kb@ndimensionz.com


