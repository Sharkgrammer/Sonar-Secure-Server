#! /bin/sh

NAME="Sonar-Secure-Server"
FILE_PATH="/usr/local/$NAME/linux"

sudo mv $FILE_PATH/sonarInit.sh /etc/init.d/Sonar-Secure-Server/sonarInit.sh

chmod 755 /etc/init.d/$NAME

update-rc.d $NAME defaults