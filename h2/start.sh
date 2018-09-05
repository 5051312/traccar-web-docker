if [ ! -e data/database.mv.db ]; then
	echo "-- Creating database"
    java -cp lib/h2*.jar org.h2.tools.RunScript -url jdbc:h2:./data/database -user sa -password "" -script schema.sql
fi

java -Djava.net.preferIPv4Stack=true -Xmx512m -jar tracker-server.jar conf/traccar.xml