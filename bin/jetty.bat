
@echo off
echo [INFO] run jetty.bat
cd ..
echo [INFO] start jetty
call mvn clean jetty:run -Djetty.port=8081