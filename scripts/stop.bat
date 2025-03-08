@echo off
echo Stopping Blue and Green containers...

:: Stop the containers
docker stop blue_container green_container

echo Containers stopped successfully!
pause
