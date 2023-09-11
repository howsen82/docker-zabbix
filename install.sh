wget https://repo.zabbix.com/zabbix/6.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_6.4-1+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_6.4-1+ubuntu22.04_all.deb
sudo apt update
sudo apt install -y apache2 apt-transport-https certbot python3-certbot-apache mysql-server zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
sudo a2enmod rewrite
sudo vim /etc/apache2/sites-available/zabbix.heyvaldemar.net.conf
sudo a2ensite zabbix.heyvaldemar.net.conf
sudo a2dissite 000-default.conf
sudo apache2ctl configtest
sudo systemctl restart apache2
sudo systemctl status apache2
sudo certbot --apache -d zabbix.heyvaldemar.net
sudo certbot renew --dry-run
sudo mysql_secure_installation
sudo mysql -u root -p
CREATE DATABASE zabbixdb CHARACTER SET utf8 COLLATE utf8mb4_bin;
CREATE USER 'zabbixdbuser'@'localhost' IDENTIFIED BY 'c@e3]Y88n)63}^4w^43]';
GRANT ALL ON zabbixdb.* TO 'zabbixdbuser'@'localhost';
FLUSH PRIVILEGES;
quit
zcat /usr/share/doc/zabbix-server-mysql/create.sql.gz | mysql --default-character-set=utf8mb4 -u zabbixdbuser -p zabbixdb
sudo vim /etc/zabbix/zabbix_server.conf
sudo vim /etc/zabbix/apache.conf
sudo systemctl restart zabbix-server zabbix-agent apache2
sudo systemctl status zabbix-server
sudo systemctl status zabbix-agent
sudo systemctl status apache2
sudo systemctl enable zabbix-server zabbix-agent apache2
