::自动部署项目脚本


@echo off


echo [INFO] hello world.
cd ..
call mvn clean compile package
echo [INFO] war has been generated.
echo [INFO] Tomcat Home : %CATALINA_HOME%

C:
cd %CATALINA_HOME%
rd  /q /s logs
echo [INFO] logs has been deleted.

echo [INFO] logs has been creted.
mkdir logs

cd webapps

rd  /q /s clubassembly
echo [INFO] clubassembly directory has been deleted.

del clubassembly.war
echo [INFO] clubassembly.war has been deleted.

move D:\idea\clubassembly\target\clubassembly.war  clubassembly.war

cd ..
cd bin
call  startup.bat
echo [INFO] tomcat has been started.
