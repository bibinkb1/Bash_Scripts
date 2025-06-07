#!/bin/bash

# Prompt the user for input
read -p "Enter your email: " sender
read -p "Enter recipient email: " receiver
read -s -p "Enter your Google App password: " kiht fsnr ffhi utth
echo
read -p "Enter the subject of mail: " sub test

# Read the body of the email
echo "Enter the body of mail (Ctrl+D to end):"
body=$(</dev/stdin)

# Sending email using curl
response=$(curl -s --url 'smtps://smtp.gmail.com:465' --ssl-reqd \
    --mail-from "bibinkb444@gmail.com" \
    --mail-rcpt "bibinkb444@gmail.com" \
    --user "bibinkb444@gmail.com:wqil fnhd olec ebjf" \
    -T <(echo -e "From: $sender\nTo: $receiver\nSubject: $sub\n\n$body"))

if [ $? -eq 0 ]; then
    echo "Email sent successfully."
else
    echo "Failed to send email."
    echo "Response: $response"
fi