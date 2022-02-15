#!/bin/bash
clear
clear
clear
clear

echo "Automatischer Deployer wurde gestartet."

sleep 1;
clear
clear

apt-get update -y && apt-get upgrade -y;
clear


REQUIRED_PKG="unzip"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG
fi

REQUIRED_PKG="sudo"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG
fi

REQUIRED_PKG="gem"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
    apt-get install gem -y;
    clear
    sudo gem install lolcat

fi

REQUIRED_PKG="figlet"
PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG|grep "install ok installed")
echo Checking for $REQUIRED_PKG: $PKG_OK
if [ "" = "$PKG_OK" ]; then
  echo "No $REQUIRED_PKG. Setting up $REQUIRED_PKG."
  sudo apt-get --yes install $REQUIRED_PKG
fi


for ((i=1 ; i<=9999999 ; i++ )); do

source <(curl -s https://raw.githubusercontent.com/GermanJag/BashSelect.sh/main/BashSelect.sh)

figlet Black.dx | lolcat
echo 
echo
echo
echo
figlet Server-Helper
echo "
 _______________________________________
|       Debian 10 Server-Helper        |
|              Version 1.0             | 
|______________________________________|
|        WICHTIGE INFORMATION          |
| Dieses Projekt ist aktuell in WIP    |
| (Work in Progress), es könnten Fehler|
| auftreten, jedoch testen wir alles.  |
|                                      |
|______________________________________|
|        Webserver                     |    
| Das WebServer Packet installiert so  |
| gut wie alles vor, was du für deine  |
| Website benötigst                    |
|______________________________________|
| 1. Apache2 inkl. Php 7.4 (empfohlen) |
| 2. Nginx inkl. Php 7.4               |
|______________________________________|
|        Data Storage                  |
| Einfache Installation von einem oder |
| mehreren Data Storages.              |
|______________________________________|
| 3. MySQL (bei 1&2 vorinstalliert)    |
| 4. MongoDB                           |
| 5. Redis (Server)                    |
|______________________________________|
|        Sonstiges                     |
| Sonstige hilfreiche Sachen für z.b   |
| Containervirtualisierung.            |
|______________________________________|
| 6. Docker                            |
| 7. Java (Mehrere Versionen verfügbar)|
|______________________________________| " | lolcat
echo " "
echo "Alles ist auf Debian 10 angepasst. Keine Garantie für andere OS"
echo " "

 read -p "Wähle ein Menüpunkt aus> " options

        if [ $options == "1" ]; then
            echo "Installiere Apache2 inkl. Php7.4 & MariaDB" | lolcat
            apt install ca-certificates apt-transport-https lsb-release gnupg curl nano unzip -y
            wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
            echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
            apt install software-properties-common -y
            add-apt-repository ppa:ondrej/php
            apt update -y
            apt install apache2 -y
            apt install php7.4 php7.4-cli php7.4-common php7.4-curl php7.4-gd php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-readline php7.4-xml php7.4-xsl php7.4-zip php7.4-bz2 libapache2-mod-php7.4 -y
            apt install mariadb-server mariadb-client -y
            sleep 1;
            mysql_secure_installation

            cd /usr/share
            wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O phpmyadmin.zip

            unzip phpmyadmin.zip
            rm phpmyadmin.zip

            mv phpMyAdmin-*-all-languages phpmyadmin
            chmod -R 0755 phpmyadmin

            printf "
# phpMyAdmin Apache configuration

Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options SymLinksIfOwnerMatch
    DirectoryIndex index.php
</Directory>

# Disallow web access to directories that don't need it
<Directory /usr/share/phpmyadmin/templates>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/libraries>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/setup/lib>
    Require all denied
</Directory>
" > /etc/apache2/conf-available/phpmyadmin.conf

            sleep 1;
            a2enconf phpmyadmin
            systemctl reload apache2

            mkdir /usr/share/phpmyadmin/tmp/
            chown -R www-data:www-data /usr/share/phpmyadmin/tmp/

            service apache2 restart -y
            clear
            echo "Installation von Apache2 inkl. Php7.4 & MariaDB erfolgreich" | lolcat

        fi

            if [ $options == "2" ]; then
            echo "Installiere Nginx inkl. Php7.4 & MariaDB" | lolcat
            #Nginx & Php7.4 mit extensions
            apt install nginx
            apt install php7.4 php7.4-cli php7.4-common php7.4-curl php7.4-gd php7.4-intl php7.4-json php7.4-mbstring php7.4-mysql php7.4-opcache php7.4-readline php7.4-xml php7.4-xsl php7.4-zip php7.4-bz2 libapache2-mod-php7.4 -y

            #mariaDB installation
            apt install mariadb-server mariadb-client -y
            sleep 1;
            mysql_secure_installation
            #Need to configurate phpmyadmin soon
            echo "Nginx inkl Php7.4 wurde installiert, beachte: es wurde KEIN Phpmyadmin installiert" | lolcat
            fi

            if [ $options == "3" ]; then
            echo "Installiere MariaDB" | lolcat
            #mariaDB installation
            apt install mariadb-server mariadb-client -y
            sleep 1;
            mysql_secure_installation
            echo "MariaDB erfolgreich installiert" | lolcat
            fi

            if [ $options == "4" ]; then
            echo "Installiere MongoDB" | lolcat
            #Installation
            wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
            sudo apt-get install gnupg
            wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
            echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
            clear
            sudo apt-get update
            sudo apt-get install -y mongodb-org
            clear
            echo "Starte MongoDB" | lolcat
            sudo systemctl daemon-reload
            sudo systemctl start mongod
            sudo systemctl status mongod
            clear
            echo "MongoDB erfolgreich installiert" | lolcat
            fi

            if [ $options == "5" ]; then
            echo "Installiere Redis (Server)" | lolcat
            sudo apt update
            sudo apt install redis-server

           printf "
. . .

# If you run Redis from upstart or systemd, Redis can interact with your
# supervision tree. Options:
#   supervised no      - no supervision interaction
#   supervised upstart - signal upstart by putting Redis into SIGSTOP mode
#   supervised systemd - signal systemd by writing READY=1 to $NOTIFY_SOCKET
#   supervised auto    - detect upstart or systemd method based on
#                        UPSTART_JOB or NOTIFY_SOCKET environment variables
# Note: these supervision methods only signal "process is ready."
#       They do not enable continuous liveness pings back to your supervisor.
supervised systemd

. . .
" > etc/redis/redis.conf
            sudo systemctl restart redis
            echo "Redis (Server) erfolgreich installiert" | lolcat
            fi
done

if [ $options == "6" ]; then
            echo "Installiere Docker" | lolcat
            #Installation / #Credits Docker.com
            sudo apt-get remove docker docker-engine docker.io containerd runc

            sudo apt-get update
            sudo apt-get install \
                ca-certificates \
                curl \
                gnupg \
                lsb-release
            
            curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
             echo \
            "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian \
            $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

            sudo apt-get update
            sudo apt-get install docker-ce docker-ce-cli containerd.io



            echo "Docker erfolgreich installiert & alte versionen entfernt" | lolcat
            fi
done
if [ $options == "7" ]; then
            echo "Installiere Java" | lolcat
            sleep 3
            echo "Uppps! Das ist noch nicht fertig :P" | lolcat
            fi
done
