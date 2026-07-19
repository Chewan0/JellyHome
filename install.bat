@echo off
setlocal EnableExtensions EnableDelayedExpansion
title JellyHome Installer
color 0c
cd /d "%~dp0"

set "JELLY_URL=http://localhost:8096"
set "RADARR_URL=http://localhost:7878"
set "SONARR_URL=http://localhost:8989"
set "PROWLARR_URL=http://localhost:9696"

set "COMPOSE_CMD="
set "COMPOSE_ARGS="

call :detect_compose || exit /b 1
call :detect_compose_file || exit /b 1

:menu
cls
call :logo
echo JellyHome Installer v1.0.0
echo ==============================================
echo [1] Kurulumu Baslat
echo [2] Servisleri Baslat
echo [3] Servisleri Durdur
echo [4] Yeniden Baslat
echo [5] Guncelle ^(pull + up -d^)
echo [6] Loglari Goster
echo [7] Tarayiciyi Ac
echo [8] Durum Kontrolu
echo [9] Kaldir
echo [0] Cikis
echo.
set /p "choice=Seciminiz: "

if "%choice%"=="1" goto install
if "%choice%"=="2" goto start
if "%choice%"=="3" goto stop
if "%choice%"=="4" goto restart
if "%choice%"=="5" goto update
if "%choice%"=="6" goto logs
if "%choice%"=="7" goto browser
if "%choice%"=="8" goto status
if "%choice%"=="9" goto uninstall
if "%choice%"=="0" exit /b 0

goto menu

:install
call :make_dirs
echo.
echo [*] Konteynerler baslatiliyor...
%COMPOSE_CMD% %COMPOSE_ARGS% up -d
if errorlevel 1 goto fail
echo.
echo [V] Kurulum tamamlandi!
echo.
echo [!] Jellyfin ve diger servisler 15-40 saniye icinde hazir olacaktir.
echo [!] Sayfa acilmazsa biraz bekleyip yenileyin.
echo.
call :open_browser
pause
goto menu

:start
echo.
echo [*] Servisler baslatiliyor...
%COMPOSE_CMD% %COMPOSE_ARGS% up -d
if errorlevel 1 goto fail
echo.
echo [V] Servisler baslatildi!
call :open_browser
pause
goto menu

:stop
echo.
echo [*] Servisler durduruluyor...
%COMPOSE_CMD% %COMPOSE_ARGS% stop
if errorlevel 1 goto fail
echo [V] Servisler durduruldu.
pause
goto menu

:restart
echo.
echo [*] Servisler yeniden baslatiliyor...
%COMPOSE_CMD% %COMPOSE_ARGS% restart
if errorlevel 1 goto fail
echo [V] Servisler yeniden baslatildi.
pause
goto menu

:update
echo.
echo [*] Image'lar guncelleniyor...
%COMPOSE_CMD% %COMPOSE_ARGS% pull
if errorlevel 1 goto fail
%COMPOSE_CMD% %COMPOSE_ARGS% up -d

if errorlevel 1 goto fail
echo [V] Guncelleme tamamlandi.
pause
goto menu

:logs
echo.
echo [*] Loglar aciliyor...
echo Cikmak icin Ctrl + C basin.
%COMPOSE_CMD% %COMPOSE_ARGS% logs -f
pause
goto menu

:browser
call :open_browser
pause
goto menu

:status
echo.
echo [*] Container durumu:
%COMPOSE_CMD% %COMPOSE_ARGS% ps
echo.
echo [*] Hizli erisim:
echo Jellyfin  : %JELLY_URL%
echo Radarr    : %RADARR_URL%
echo Sonarr    : %SONARR_URL%
echo Prowlarr  : %PROWLARR_URL%
echo.
call :show_port_status 8096
call :show_port_status 7878
call :show_port_status 8989
call :show_port_status 9696
call :show_port_status 6500
pause
goto menu

:uninstall
echo.
set /p "confirm=Konteynerler silinsin mi? (EVET yaz): "
if /I not "!confirm!"=="EVET" goto menu

echo.
echo [*] Konteynerler kaldiriliyor...
%COMPOSE_CMD% %COMPOSE_ARGS% down --remove-orphans
if errorlevel 1 goto fail

timeout /t 5 /nobreak >nul

echo.
set /p "deldata=Veri klasoru de silinsin mi? (E/H): "
if /I "!deldata!"=="E" (
    rmdir /s /q "veri"

    if exist "veri" (
        echo [X] Veri klasoru tamamen silinemedi.
    ) else (
        echo [V] Veri klasoru silindi.
    )
)

echo [V] Kaldirma tamamlandi.
pause
goto menu

:make_dirs
echo.
echo [*] Klasorler olusturuluyor...
for %%D in (
    "veri\jellyfin\config"
    "veri\medya\movies"
    "veri\medya\tvshows"
    "veri\radarr\config"
    "veri\sonarr\config"
    "veri\prowlarr\config"
    "veri\rdtclient\db"
    "veri\downloads"
) do (
    if not exist "%%~D" mkdir "%%~D" >nul 2>&1
)
exit /b 0

:detect_compose
docker compose version >nul 2>&1
if not errorlevel 1 (
    set "COMPOSE_CMD=docker compose"
    exit /b 0
)

docker-compose version >nul 2>&1
if not errorlevel 1 (
    set "COMPOSE_CMD=docker-compose"
    exit /b 0
)

echo.
echo [X] Docker Compose bulunamadi.
echo Docker Desktop acik mi ve kurulu mu kontrol et.
pause
exit /b 1

:detect_compose_file
if exist "docker-compose.yml" (
    set "COMPOSE_ARGS=-f docker-compose.yml"
    exit /b 0
)

if exist "compose.yml" (
    set "COMPOSE_ARGS=-f compose.yml"
    exit /b 0
)

echo.
echo [X] docker-compose.yml veya compose.yml bulunamadi.
pause
exit /b 1

:open_browser
echo.
echo [*] Servislerin hazir olmasi bekleniyor...
timeout /t 8 >nul

start "" "%JELLY_URL%"
timeout /t 1 >nul
start "" "%RADARR_URL%"
timeout /t 1 >nul
start "" "%SONARR_URL%"
timeout /t 1 >nul
start "" "%PROWLARR_URL%"
exit /b 0

:show_port_status
set "PORT=%~1"
netstat -ano | find ":%PORT% " >nul 2>&1
if errorlevel 1 (
    echo Port %PORT% : bos gibi gorunuyor
) else (
    echo Port %PORT% : kullaniliyor olabilir
)
exit /b 0

:fail
echo.
echo [X] Isleminiz basarisiz oldu.
pause
goto menu

:logo
echo.
echo  ##########################################################
echo  #                                                        #
echo  #      JJJ  EEEEE  L      L      Y   Y   H   H   OOO     #
echo  #       J   E      L      L       Y Y    H   H  O   O    #
echo  #   J   J   EEEE   L      L        Y     HHHHH  O   O    #
echo  #   J   J   E      L      L        Y     H   H  O   O    #
echo  #    JJJ    EEEEE  LLLLL  LLLLL    Y     H   H   OOO     #
echo  #                                                        #
echo  #               JellyHome Installer v1.0                 #
echo  ##########################################################
echo.
exit /b 0
