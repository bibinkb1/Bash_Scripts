#!/usr/bin/python

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
import smtplib,os,platform

myusr = os.popen("who | cut -d' ' -f1 | sort | uniq | grep -v root").read()

hostname = os.system("hostname")

msg = MIMEMultipart()


log_file = open("/root/scripts/log-test", "r")
 
message = log_file.read()
 
log_file.close()

password = "gfj47xdzdNVj"
msg['From'] = "intranet.alert@ndimensionz.com"
msg['To'] = "intranet.alert@ndimensionz.com"
msg['Subject'] = "Patch Update - {0} - {1}".format(myusr, platform.node())

msg.attach(MIMEText(message, 'plain'))

server = smtplib.SMTP('ndimensionz.com: 587')

server.starttls()

server.login(msg['From'], password)

server.sendmail(msg['From'], msg['To'], msg.as_string())

server.quit()
