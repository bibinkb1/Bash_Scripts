#!/bin/bash

# Database credentials
DB_HOST="localhost"
DB_USER="your_username"
DB_PASS="your_password"
DB_NAME="your_database"

# Table and column to check for old data
TABLE_NAME="orders"
DATE_COLUMN="order_date"

# Log file
LOG_FILE="/var/log/delete_old_data.log"

# Email details
EMAIL_TO="recipient@example.com"
EMAIL_FROM="sender@example.com"
EMAIL_SUBJECT="Data Deletion Report"

# SQL query to delete data older than 6 months
SQL_QUERY="DELETE FROM $TABLE_NAME WHERE $DATE_COLUMN < DATE_SUB(NOW(), INTERVAL 6 MONTH);"

# Execute the SQL query and log the output
echo "Deleting data older than 6 months from $TABLE_NAME..." | tee -a $LOG_FILE
mysql -h $DB_HOST -u $DB_USER -p$DB_PASS -D $DB_NAME -e "$SQL_QUERY" 2>> $LOG_FILE

# Check if the query was successful
if [ $? -eq 0 ]; then
    echo "Data deletion successful." | tee -a $LOG_FILE
else
    echo "Error: Data deletion failed. Check the log file for details." | tee -a $LOG_FILE
fi

# Send the log file via email
mailx -s "$EMAIL_SUBJECT" -r "$EMAIL_FROM" -a $LOG_FILE $EMAIL_TO < $LOG_FILE

# Check if the email was sent successfully
if [ $? -eq 0 ]; then
    echo "Email sent successfully." | tee -a $LOG_FILE
else
    echo "Error: Failed to send email." | tee -a $LOG_FILE
fi


