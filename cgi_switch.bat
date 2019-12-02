@ECHO OFF

CD "C:\WebServer\nginx1.12"

tasklist /FI "IMAGENAME eq nginx.exe" | find /I "nginx.exe" > NUL && (
    GOTO STOP
) || (
    GOTO START
)

:START
ECHO Starting nginx...
start nginx
ECHO Starting PHP...
::start C:/dev/php/php-cgi.exe -b 127.0.0.1:9080 -c c:\dev\php\php.ini
::C:\WebServer\RunHiddenConsole.exe C:\WebServer\php7.1\php-cgi.exe -b 127.0.0.1:9001
cd C:\WebServer\php7.1
RunHiddenConsole C:/WebServer/xxfpm-master/bin/xxfpm.exe "C:/WebServer/php7.1/php-cgi.exe -c C:/WebServer/php7.1/php.ini" -n 3 -i 127.0.0.1 -p 9001
GOTO DONE

:STOP
ECHO Stopping nginx...
start nginx -s quit
ECHO Stopping PHP...
taskkill /f /IM xxfpm.exe

:DONE
TIMEOUT 3