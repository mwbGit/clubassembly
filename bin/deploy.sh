#!/bin/sh
echo "build project begin!"
#locate tomcat home
cd $CATALINA_HOME
#shundown tomcat
cd bin
./shutdown.sh
#delete all logs
rm -rf ../logs/
#make dir logs
mkdir logs
#delete onemeet deployment
rm -rf onemeet*
#build project
mvn -f ../../../../IdeaProjects/onemeet/pom.xml clean compile package
cd $CATALINA_HOME/webapps
#mv onemeet.war to tomcat webapps
mv ../../../../IdeaProjects/target/onemeet.war ./
#start tomcat
cd ../bin/
./startup.sh
#tomcat start successful
echo "tomcat start successful"
