@echo off
echo Starting Blue and Green containers...

:: Run Blue container
docker run -d -p 9090:4173 --name blue_container --rm ses_1:blue

:: Run Green container
docker run -d -p 8080:4173 --name green_container --rm ses_1:green

echo Containers started successfully!
pause
