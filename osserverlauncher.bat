@echo off
title Onwexry's Server Console @2.0!



if exist ossettings.ini (
	for /f "delims=§" %%S in (ossettings.ini) do set %%S
	goto menu
)
color 9f
title Onwexry's Server Console Kurulum 1/2
echo O's Konsoluna Hosgeldin
echo Kurulum Ekranindasin
echo Ramini Mb Cinsinden Gir
set /p ram=
set title= [7] Yazarak Baslaticiya Title Ekleyin
set ram > ossettings.ini
set flags= -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dnashorn.args=--no-deprecation-warning -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true
set title >> ossettings.ini
set flags >> ossettings.ini
cls
title Onwexry's Server Console Kurulum 2/2
echo Onerilen baslatici kodu otomatik olarak girildi
echo Degistirmek icin ossettings.ini dosyasina girin
echo.
echo           Devam etmek icin [Enter]
echo.
echo           Sunucunuzu Acmadan Once 
echo Onerilere Bakmaniz Siddetle Tavsiye Edilir
set /p wait=



:menu
SET a=0
title Tag: %title%
cls
if exist server.jar (
    set a=1
) else (
    set a=0
)

color 0C
if %a%==0 goto a0
:a1
	
	echo                                                 +-------+.    
	echo                                                 ^|`.     ^| `.  
	echo                                                 ^|  `+---+---+
	echo            OsBaslatici 2.0                      ^|   ^|   ^|   ^|
	echo   Seciminizi klavyeden girip [Enter] basiniz    ^|   ^|   ^|   ^|
	echo                                                 +---+---+.  ^|
	echo                                                  `. ^|     `.^|
	echo                                                    `+-------+
	echo [1] Yazarak Sunucuyu Baslatin
	echo [2] Yazarak Haritayi Yedekleyin
	echo [3] Yazarak Pluginleri Yedekleyin
	echo [4] Yazarak Hafiza Atayin [Suanki %ram% M]
	echo [5] Yazarak Minecraft_Server, Skript ve Authme Loglarini Temizleyin
	echo [6] Yazarak Paneli Temizleyin ve Yenileyin
	echo [7] Yazarak Baslaticiya Title Ekleyin	
	echo [8] Yazarak Onerilere Bakin
	echo [9] Yazarak Baslaticiyi Kapatin

	set /p udefine=
	if %udefine%==1 goto start
	if %udefine%==2 goto mb
	if %udefine%==3 goto pb
	if %udefine%==4 goto setram
	if %udefine%==5 goto clearlogs
	if %udefine%==6 cls
	if %udefine%==7 goto newtitle
	if %udefine%==8 goto oneriler
	if %udefine%==9 exit()
	echo Islem Tamamlandi 
	goto menu


:a0
echo server.jar Bulunamadi.
	echo Sunucunuzun Calistirilacak ".jar" Uzantili Dosyasini
	echo server.jar Olarak Degistirin.
	echo Islemi Yaptiktan Sonra "Enter" a Basin
	set /p secim= 
	cls
	goto menu
:ae


echo Hata! Yeniden Deneyin.
goto menu

:mb
color A0
set funcdate=%date:~-4%_%date:~3,2%_%date:~0,2%_%time:~0,2%_%time:~3,2%_%time:~6,2%
XCOPY /E /H "world" "yedek\maps\map_%funcdate%\world\"
echo Nether Kopyalansin Mi ?
echo [E] Evet, [H] Hayir.
set /p udefine=
if %udefine%==H goto yedekend
XCOPY /E /H "world_nether" "yedek\maps\map_%funcdate%\world_nether\"
:yedekend
echo End World Kopyalansin Mi ?
echo [E] Evet, [H] Hayir.
set /p udefine=
if %udefine%==H goto menu
XCOPY /E /H "world_the_end" "yedek\maps\map_%funcdate%\world_the_end\"
goto menu
:pb
color A0
set funcdate=%date:~-4%_%date:~3,2%_%date:~0,2%_%time:~0,2%_%time:~3,2%_%time:~6,2%
XCOPY /E /H "plugins" "yedek\plugins\pl_%funcdate%\"
cls
goto menu

:setram
echo Hafizanizi M(mb) Cinsinden Girin
set /p ram=
set ram > ossettings.ini
set title >> ossettings.ini
cls
goto menu

:newtitle
echo Baslik Etiketinizi Girin
set /p title=Giriniz:
title Tag: %title%
set ram > ossettings.ini
set title >> ossettings.ini
cls
goto menu

:clearlogs
cls
color A0
:minecraftserverlog
echo Minecraft_server loglari silinsin mi?
echo [E] Evet, [H] Hayir.
set /p udefine=
if %udefine%==H goto skriptlogs
if exist logs\*.gz del logs\*.gz /q

:skriptlogs
echo Skript loglari silinsin mi?
echo [E] Evet, [H] Hayir.
set /p udefine=
if %udefine%==H goto skriptsaves
if exist plugins\Skript\logs\*.log del plugins\Skript\logs\*.log /q

:skriptsaves
echo Skript veri yedekleri silinsin mi?
echo [E] Evet, [H] Hayir.
set /p udefine=
if %udefine%==H goto authmelogs
if exist plugins\Skript\backups\*.csv del plugins\Skript\backups\*.csv /q

:authmelogs
echo AuthMe loglari silinsin mi?
echo [E] Evet, [H] Hayir.
set /p udefine=
if %udefine%==H goto fclearlogs
if exist plugins\AuthMe\authme.log del plugins\AuthMe\authme.log /q

:fclearlogs
echo Dosya silme bitti
cls
goto menu


:oneriler
color 9f
cls
title Onwexry's Server Console Oneriler
echo Oneriler:
echo Otomatik girilen baslatici kodu Java11 ve 12gb uzeri ram icin idealdir
echo Java11 kullanimi sunucu performansini %%30'a kadar arttirir
echo Sunucunuzu topluluga acmadan once butun haritayi olusturunuz
echo Yakinda daha detayli oneriler yazilacaktir
echo.
echo Menuye geri donmek icin [Enter]
set /p wait=
goto menu


:start
color 0b
echo Yurutulen baslatma kodu: -Xms%ram%M -Xmx%ram%M %flags% -jar server.jar nogui
java -Xms%ram%M -Xmx%ram%M %flags% -jar server.jar nogui
echo.
echo Saat (%time%)'de Sunucu Durduruldu
echo Loglar Icin 'Logs' klasorune bakiniz
goto menu

:exit
PAUSE>nul
exit()







