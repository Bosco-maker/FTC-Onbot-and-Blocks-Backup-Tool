**# FTC Robot Backup Tool Documentation

## What Is This Tool?

This tool is a simple Windows batch script (`.bat`) that automatically copies FTC robot code files from the Robot Controller phone onto your computer.

The files are copied using Android Debug Bridge (ADB), which is the same communication system used by Android Studio.

The tool backs up:

* FTC Blocks files
* OnBot Java files

The copied files are saved into a folder on your computer that can be managed by Git or GitHub Desktop.

This allows teams to:

* Create backups of robot code
* Track changes over time
* Restore older versions if code breaks
* Upload FTC code into GitHub
* Preserve code before competitions

---

# What Does The Tool Do?

When the batch file is run:

1. It starts ADB
2. It checks if a Robot Controller phone is connected
3. It accesses the FTC folders stored on the phone
4. It copies those folders onto your computer
5. The copied files become visible inside your Git repository
6. GitHub Desktop can then commit and upload the files

The tool uses these FTC folders on the Robot Controller Phone:

Blocks projects:

```text
/sdcard/FIRST/blocks
```

OnBot Java projects:

```text
/sdcard/FIRST/java
```

---

# Prerequisites

Before the tool works, the following requirements must be completed.

## 1. Windows Computer

The tool only works on Windows because it uses a Windows batch script (`.bat`).

---

## 2. Android Studio Installed

Install Android Studio.

Official website:

[https://developer.android.com/studio](https://developer.android.com/studio)

Android Studio installs the Android SDK, which contains ADB.
(This tools currently works with Android Studio Narwhal | 2025.1.1, newer versions will work but please check the location of the ADB)
---

## 3. Android SDK Platform Tools Installed

ADB is included inside the Android SDK Platform Tools package.

To verify:

1. Open Android Studio
2. Open:

```text
More Actions → SDK Manager
```

3. Open the:

```text
SDK Tools
```

tab

4. Make sure this is installed:

```text
Android SDK Platform-Tools
```

---

## 4. USB Debugging Enabled On The Robot Controller Phone

ADB requires USB debugging.

To enable it:

On the Robot Controller phone:

1. Make sure you have installed Robot Controller app on your phone: https://ftc-docs.firstinspires.org/en/latest/ftc_sdk/updating/rc_app/Updating-the-RC-App.html
2. Enable developer debugging options: https://ftc-docs.firstinspires.org/en/latest/programming_resources/tutorial_specific/android_studio/enabling_developer_options/Enabling-Developer-Options.html
   
---

## 5. USB Cable or Wifi

Use a USB cable capable of data transfer. Some cheap charging cables cannot transfer data.
OR
Connect to the Wifi created by your RC phone:
https://ftc-docs.firstinspires.org/en/latest/programming_resources/shared/program_and_manage_network/Connecting-a-Laptop-to-the-Program-&-Manage-Network.html

---

# Finding ADB

ADB is usually located at:

```text
C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe
```

Example:

```text
C:\Users\Bosco\AppData\Local\Android\Sdk\platform-tools\adb.exe
```

You can verify the location by:

1. Opening Android Studio
2. Opening SDK Manager
3. Reading the SDK Location field
4. Opening the `platform-tools` folder inside that SDK location

The folder should contain:

```text
adb.exe
```

---

# Setting Up The Tool

## Step 1 — Create A Backup Folder

Create a folder anywhere on your computer.

Example:

```text
C:\FTCCodeBackup
```

Inside it, create two folders:

```text
blocks
java
```

Example structure:

```text
C:\FTCCodeBackup
    blocks
    java
```

This folder can also be a Git repository.

---

## Step 2 — Create The Batch File

1. Right click desktop or folder
2. Select:

```text
New → Text Document
```

3. Rename it:

```text
backup_ftc.bat
```

Make sure the extension becomes `.bat` and not `.txt`.

---

## Step 3 — Paste The Script

Open the `.bat` file in Notepad and paste this:

```bat
@echo off

echo Checking for connected FTC robot...

"C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe" devices

echo Pulling files...

"C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe" pull /sdcard/FIRST/blocks C:\FTCCodeBackup\blocks

"C:\Users\YOUR_USERNAME\AppData\Local\Android\Sdk\platform-tools\adb.exe" pull /sdcard/FIRST/java C:\FTCCodeBackup\java

pause
```

---

## Step 4 — Edit The Paths

Replace:

```text
YOUR_USERNAME
```

with your Windows username.

Example:

```text
C:\Users\Bosco\AppData\Local\Android\Sdk\platform-tools\adb.exe
```

Also replace:

```text
C:\FTCCodeBackup
```

with your real backup folder path.

---

# How To Use The Tool

## Step 1 — Connect Robot Controller Phone

Plug the FTC Robot Controller phone into the computer using USB.

---

## Step 2 — Allow USB Debugging

The first time the phone connects, Android may display:

```text
Allow USB Debugging?
```

Press:

```text
Allow
```

Otherwise ADB cannot access the device.

---

## Step 3 — Run The Batch File

Double click:

```text
backup_ftc.bat
```

A command window opens.

If successful, it will:

* Detect the Robot Controller
* Copy Blocks projects
* Copy OnBot Java files
* Save them into the backup folder

---

## Step 4 — Open GitHub Desktop

GitHub Desktop will detect changed files.

You can now:

1. Review changes
2. Commit
3. Push to GitHub

---

# Example Output

Example copied files:

```text
C:\FTCCodeBackup
    blocks
        MyAuto.blk
        MyTeleOp.blk

    java
        org
            firstinspires
                ftc
```

---

# Understanding The Commands

## adb devices

Checks if Android devices are connected.

Example:

```text
List of devices attached
1234567890ABCDEF    device
```

If no device appears, the Robot Controller is not connected correctly.

---

## adb pull

Copies files FROM the Android phone TO the computer.

Example:

```text
adb pull /sdcard/FIRST/java C:\FTCCodeBackup\java
```

Meaning:

* Source = FTC Java folder on Robot Controller phone
* Destination = Java backup folder on PC

---

# Common Problems

## Problem: "adb is not recognized"

Cause:

Windows cannot find `adb.exe`.

Fix:

Use the full adb path inside the batch file.

---

## Problem: Device Does Not Appear

Possible causes:

* USB debugging disabled
* Bad USB cable
* Robot Controller phone not authorized
* Driver issue

Try:

* Replugging cable
* Using another USB port
* Accepting USB debugging popup
* Restarting ADB

Command:

```text
adb kill-server
adb start-server
```

---

## Problem: Permission Denied

Usually caused by USB debugging authorization not accepted.

Disconnect and reconnect the phone.

---

# Optional Improvements

Possible upgrades later:

* Automatically create timestamped backups
* Automatically commit to Git
* Create a graphical interface
* Backup FTC logs
* Backup TensorFlow models

---

# WiFi ADB Support (Optional)

FTC Robot Controllers can sometimes be accessed over WiFi.

Typical command:

```text
adb connect 192.168.43.1:5555
```

This depends on:

* Robot Controller hotspot configuration
* Whether TCP debugging is enabled

USB is usually more reliable.

---

# Recommended Workflow

Recommended team workflow:

1. Program robot
2. Test robot
3. Run backup script
4. Open GitHub Desktop
5. Commit changes
6. Push to GitHub

This creates version history and prevents accidental code loss.

---

# Final Notes

This tool does not modify the Robot Controller.

It only copies files from the phone onto the computer.

Because it uses ADB, it works similarly to how Android Studio communicates with FTC phones.

The script is intentionally simple so teams can:

* Understand it easily
* Modify it themselves
* Debug it quickly
* Share it between programmers
