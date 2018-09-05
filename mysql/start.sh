echo "Waiting for mysql"
until mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" &> /dev/null
do
  printf "."
  sleep 1
done

if [ `mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" -e "SHOW TABLES" $MYSQL_DATABASE | wc -l` = 0 ]; then
	echo "-- Creating database"
	mysql -h"$MYSQL_HOST" -P"$MYSQL_PORT" -u"$MYSQL_USER" -p"$MYSQL_PASSWORD" $MYSQL_DATABASE < schema.sql
fi

sed -i "s/\$\[DBHOST\]/$MYSQL_HOST/g" conf/traccar.xml
sed -i "s/\$\[DBPORT\]/$MYSQL_PORT/g" conf/traccar.xml
sed -i "s/\$\[DBNAME\]/$MYSQL_DATABASE/g" conf/traccar.xml
sed -i "s/\$\[DBUSER\]/$MYSQL_USER/g" conf/traccar.xml
sed -i "s/\$\[DBPASSWORD\]/$MYSQL_PASSWORD/g" conf/traccar.xml

java -Djava.net.preferIPv4Stack=true -Xmx512m -jar tracker-server.jar conf/traccar.xml