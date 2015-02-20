#! /bin/sh

TIMESTAMP=$(date +"%F")
BACKUP_DIR="/home/vagrant/drupical/build/backup/"
MYSQL_USER="root"
MYSQL_PASSWORD="10moioui"
MYSQL=/usr/bin/mysql
MYSQLDUMP=/usr/bin/mysqldump

mkdir -p "$BACKUP_DIR/mysql/$TIMESTAMP"

databases=`$MYSQL --user=$MYSQL_USER -p$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

for db in $databases; do
  $MYSQLDUMP --force --opt --user=$MYSQL_USER -p$MYSQL_PASSWORD --databases $db | gzip > "$BACKUP_DIR/mysql/$TIMESTAMP/$db.gz"
done