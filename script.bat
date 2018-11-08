SET REACT_APP=
SET SPRING_BOOT_APP=


rem Building React app
cd %REACT_APP%
CALL npm install
CALL npm run build

rem Copying React build files to Spring Boot project. Spring Boot serves content in \src\main\resources\public by default.

xcopy "%REACT_APP%\build\*" "%SPRING_BOOT_APP%\src\main\resources\public\*" /s /e /i /Y

rem Compile Spring Boot application using Maven
cd "%SPRING_BOOT_APP%"
CALL mvn clean package

rem As React build files change everytime we build the react app, we should not keep them in our Spring Boot project. Removing:
rmdir /s /q  "%SPRING_BOOT_APP%\src\main\resources\public"

rem Removing React build files from React Project
rmdir /s /q  "%REACT_APP%\build"

rem Compilation done.
pause
