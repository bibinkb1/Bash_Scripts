#!/bin/bash

# SMTP server settings for Gmail
SMTP_SERVER="smtp.gmail.com"
SMTP_PORT="587"
SMTP_USERNAME="bibinkb444@gmail.com"
SMTP_PASSWORD="kiht fsnr ffhi utth"

# Recipient email address
TO="bibinkb165@gmail.com"

# Email subject and body
SUBJECT="Hello from Curl"
BODY="This is the email body sent using Curl and SMTP."

# Construct the email message
MESSAGE="Subject: $SUBJECT\n\n$BODY"

# Send the email using Curl
curl --url "smtp://$SMTP_SERVER:$SMTP_PORT" \
     --ssl-reqd \
     --mail-from "$SMTP_USERNAME" \
     --mail-rcpt "$TO" \
     --user "$SMTP_USERNAME:$SMTP_PASSWORD" \
     --tlsv1.2 \
     -T <(echo -e "$MESSAGE")

echo "Email sent to $TO"
