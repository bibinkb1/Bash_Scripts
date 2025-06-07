apt update
sudo apt install build-essential libgd-dev openssl libssl-dev unzip apache2 gcc make libapache2-mod-php 
useradd nagios
groupadd nagcmd
usermod -a -G nagcmd nagios
wget https://assets.nagios.com/downloads/nagioscore/releases/nagios-4.4.6.tar.gz
sudo tar -zxvf nagios-4.4.6.tar.gz
./configure --with-nagios-group=nagios --with-command-group=nagcmd
make -j4 all
make install
make install-commandmode
make install-init
make install-config
sudo /usr/bin/install -c -m 644 sample-config/httpd.conf /etc/apache2/sites-available/nagios.conf
usermod -a -G nagcmd www-data
cd /
wget https://nagios-plugins.org/download/nagios-plugins-2.3.3.tar.gz
sudo tar -zxvf nagios-plugins-2.3.3.tar.gz
cd nagios-plugins-2.3.3/
./configure --with-nagios-user=nagios --with-nagios-group=nagcmd --with-openssl
make -j4
sudo make install
a2enmod rewrite
a2enmod cgi
htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin
ln -s /etc/apache2/sites-available/nagios.conf  /etc/apache2/sites-enabled/
systemctl restart apache2
echo "[Unit]
Description=Nagios
BindTo=network.target
[Install]
WantedBy=multi-user.target
[Service]
Type=simple
User=nagios
Group=nagcmd
ExecStart=/usr/local/nagios/bin/nagios /usr/local/nagios/etc/nagios.cfg" > /etc/systemd/nagios.service
systemctl enable /etc/systemd/system/nagios.service
mv /etc/systemd/nagios.service /etc/systemd/system/nagios.service
systemctl enable /etc/systemd/system/nagios.service
