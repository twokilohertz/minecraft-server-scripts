:entrypoint
@echo off

:choose
cls
echo 1. Start paperclip.jar
echo 2. Start paperclip.jar (tweaked JVM)
echo 0. Exit
set choice=
set /p choice=-   
if "%choice%"=="1" goto start
if "%choice%"=="2" goto start_tweaked
if "%choice%"=="0" goto bypass_exit
goto choose

:start
java -Xmx8G -Xms8G -jar paperclip.jar --nogui
goto bypass_exit

:start_tweaked
java -Xmx8G -Xms8G -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true -jar paperclip.jar --nogui
goto bypass_exit

:exit
@echo off
exit

:bypass_exit
@echo off
