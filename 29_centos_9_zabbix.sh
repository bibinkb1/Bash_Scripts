#!/bin/bash

echo "Starting clean Zabbix installation..."

# 1. Clean up any previous failed attempts
dnf clean all

# 2. Install MariaDB first (Separately to ensure it's there)
dnf install -y mariadb-server
systemctl enable --now mariadb

# 3. Install Zabbix components
# We EXPLICITLY disable EPEL during this command to prevent the version 6.0 vs 7.0 conflict
dnf install -y --disablerepo=epel zabbix-server-mysql zabbix-web-mysql zabbix-apache-conf zabbix-sql-scripts zabbix-selinux-policy zabbix-agent

# 4. Create Database and User
mysql -uroot -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
mysql -uroot -e "create user zabbix@localhost identified by 'password';"
mysql -uroot -e "grant all privileges on zabbix.* to zabbix@localhost;"
mysql -uroot -e "set global log_bin_trust_function_creators = 1;"

# 5. Import Initial Schema
# If this file is missing, the install step above failed
if [ -f /usr/share/zabbix-sql-scripts/mysql/server.sql.gz ]; then
    zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -ppassword zabbix
else
    echo "ERROR: Zabbix SQL scripts not found. Installation failed."
    exit 1
fi

# 6. Configure Zabbix Server password
sed -i 's/# DBPassword=/DBPassword=password/g' /etc/zabbix/zabbix_server.conf

# 7. Disable global log_bin after import
mysql -uroot -e "set global log_bin_trust_function_creators = 0;"

# 8. Start and Enable all services
systemctl restart zabbix-server zabbix-agent httpd php-fpm
systemctl enable zabbix-server zabbix-agent httpd php-fpm

echo "Zabbix Installation Finished!"
