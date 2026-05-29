@echo off

echo Checking for connected FTC robot...

"C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe" devices

echo Pulling files...

"C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe" pull /sdcard/FIRST/blocks C:\FTCCodeBackup\blocks

"C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe" pull /sdcard/FIRST/java C:\FTCCodeBackup\java

pause
