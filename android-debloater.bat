@echo off
color 03
title Android Debloater

:MENU
echo  1. Show All Packages
echo  2. Show Disabled Packages
echo  3. Enable Package
echo  4. Disable Package
echo  5. Auto: Galaxy Grand Prime Pro (J2 Pro)
echo  6. Auto: Asus Zenpad 3.0 8 (Z581KL)
echo  7. Auto: Galaxy S22 Ultra 5G
echo  8. Auto: Galaxy Watch 4
set /p opt="> "
if "%opt%"=="1" goto SHOW_ALL
if "%opt%"=="2" goto SHOW_DISABLED
if "%opt%"=="3" goto PKG_ENABLE
if "%opt%"=="4" goto PKG_DISABLE
if "%opt%"=="5" goto AUTO_J2PRO
if "%opt%"=="6" goto AUTO_Z581KL
if "%opt%"=="7" goto AUTO_S22ULTRA
if "%opt%"=="8" goto AUTO_WATCH4
if "%opt%"=="" goto MENU
goto MENU

:SHOW_ALL
cls
echo :: Package List ::
adb shell pm list packages -f
goto MENU

:SHOW_DISABLED
cls
echo :: Disabled Packages ::
adb shell pm list packages -d
goto MENU

:PKG_ENABLE
set /p pkg="Package> "
if "%pkg%"=="" goto MENU
adb shell pm enable %pkg%
goto MENU

:PKG_DISABLE
set /p pkg="Package> "
if "%pkg%"=="" goto MENU
adb shell pm disable-user --user 0 %pkg%
goto MENU

:AUTO_J2PRO
adb shell pm disable-user --user 0 com.monotype.android.font.rosemary
adb shell pm disable-user --user 0 com.sec.android.widgetapp.samsungapps
adb shell pm disable-user --user 0 com.google.android.youtube
adb shell pm disable-user --user 0 com.sec.location.nsflp2
adb shell pm disable-user --user 0 com.google.android.googlequicksearchbox
adb shell pm disable-user --user 0 com.samsung.android.calendar
adb shell pm disable-user --user 0 com.android.providers.calendar
adb shell pm disable-user --user 0 com.osp.app.signin
adb shell pm disable-user --user 0 com.samsung.android.easysetup
adb shell pm disable-user --user 0 com.sec.android.easyMover.Agent
adb shell pm disable-user --user 0 com.samsung.knox.rcp.components
adb shell pm disable-user --user 0 com.monotype.android.font.foundation
adb shell pm disable-user --user 0 com.sec.android.widgetapp.easymodecontactswidget
adb shell pm disable-user --user 0 com.samsung.android.email.provider
adb shell pm disable-user --user 0 com.sec.android.app.samsungapps
adb shell pm disable-user --user 0 com.microsoft.office.excel
adb shell pm disable-user --user 0 com.sec.enterprise.knox.attestation
adb shell pm disable-user --user 0 com.microsoft.skydrive
adb shell pm disable-user --user 0 com.google.android.marvin.talkback
adb shell pm disable-user --user 0 com.samsung.android.app.assistantmenu
adb shell pm disable-user --user 0 com.samsung.SMT
adb shell pm disable-user --user 0 com.samsung.knox.securefolder.setuppage
adb shell pm disable-user --user 0 com.sec.knox.foldercontainer
adb shell pm disable-user --user 0 com.samsung.klmsagent
adb shell pm disable-user --user 0 com.google.android.apps.tachyon
adb shell pm disable-user --user 0 com.google.android.music
adb shell pm disable-user --user 0 com.android.printspooler
adb shell pm disable-user --user 0 com.sec.app.samsungprintservice
adb shell pm disable-user --user 0 com.samsung.android.unifiedprofile
adb shell pm disable-user --user 0 com.samsung.knox.securefolder
adb shell pm disable-user --user 0 com.samsung.android.app.simplesharing
adb shell pm disable-user --user 0 com.google.android.apps.docs
adb shell pm disable-user --user 0 com.microsoft.office.word
adb shell pm disable-user --user 0 com.google.android.webview
adb shell pm disable-user --user 0 com.microsoft.office.powerpoint
adb shell pm disable-user --user 0 com.google.android.syncadapters.contacts
adb shell pm disable-user --user 0 com.samsung.crane
adb shell pm disable-user --user 0 com.google.android.tts
adb shell pm disable-user --user 0 com.sec.spp.push
adb shell pm disable-user --user 0 flipboard.boxer.app
adb shell pm disable-user --user 0 com.google.android.feedback
adb shell pm disable-user --user 0 com.google.android.printservice.recommendation
adb shell pm disable-user --user 0 com.google.android.apps.photos
adb shell pm disable-user --user 0 com.google.android.syncadapters.calendar
adb shell pm disable-user --user 0 com.sec.android.app.sbrowser
adb shell pm disable-user --user 0 com.monotype.android.font.chococooky
adb shell pm disable-user --user 0 com.sec.android.service.health
adb shell pm disable-user --user 0 com.samsung.android.beaconmanager
adb shell pm disable-user --user 0 com.samsung.android.voc
adb shell pm disable-user --user 0 com.sec.android.app.shealth
adb shell pm disable-user --user 0 com.samsung.knox.appsupdateagent
adb shell pm disable-user --user 0 com.google.android.backuptransport
adb shell pm disable-user --user 0 com.sec.knox.knoxsetupwizardclient
adb shell pm disable-user --user 0 com.samsung.android.scloud
adb shell pm disable-user --user 0 com.linkedin.android
adb shell pm disable-user --user 0 com.sec.android.emergencylauncher
adb shell pm disable-user --user 0 com.samsung.android.dlp.service
adb shell pm disable-user --user 0 com.samsung.android.bbc.bbcagent
adb shell pm disable-user --user 0 com.enhance.gameservice
adb shell pm disable-user --user 0 com.sec.enterprise.knox.cloudmdm.smdms
adb shell pm disable-user --user 0 com.monotype.android.font.cooljazz
adb shell pm disable-user --user 0 com.sec.knox.switcher
adb shell pm disable-user --user 0 com.sec.android.widgetapp.webmanual
goto MENU

:AUTO_Z581KL
adb shell pm disable-user --user 0 com.asus.quickmemo
adb shell pm disable-user --user 0 com.google.android.googlequicksearchbox
adb shell pm disable-user --user 0 com.android.providers.calendar
adb shell pm disable-user --user 0 com.asus.weathertime
adb shell pm disable-user --user 0 com.asus.task
adb shell pm disable-user --user 0 com.google.android.apps.messaging
adb shell pm disable-user --user 0 com.asus.gamewidget
adb shell pm disable-user --user 0 com.google.android.marvin.talkback
adb shell pm disable-user --user 0 com.instagram.android
adb shell pm disable-user --user 0 com.google.android.gm
adb shell pm disable-user --user 0 com.asus.quickmemoservice
adb shell pm disable-user --user 0 com.google.android.music
adb shell pm disable-user --user 0 com.asus.contacts
adb shell pm disable-user --user 0 com.google.android.apps.docs
adb shell pm disable-user --user 0 com.google.android.webview
adb shell pm disable-user --user 0 com.google.android.syncadapters.contacts
adb shell pm disable-user --user 0 com.asus.soundrecorder
adb shell pm disable-user --user 0 com.google.android.tts
adb shell pm disable-user --user 0 com.android.calllogbackup
adb shell pm disable-user --user 0 com.asus.supernote
adb shell pm disable-user --user 0 com.google.android.feedback
adb shell pm disable-user --user 0 com.google.android.printservice.recommendation
adb shell pm disable-user --user 0 com.google.android.apps.photos
adb shell pm disable-user --user 0 com.asus.as
adb shell pm disable-user --user 0 com.google.android.calendar
adb shell pm disable-user --user 0 com.asus.ephotoburst
adb shell pm disable-user --user 0 com.facebook.katana
adb shell pm disable-user --user 0 com.asus.microfilm
adb shell pm disable-user --user 0 com.facebook.orca
adb shell pm disable-user --user 0 com.facebook.system
adb shell pm disable-user --user 0 com.asus.userfeedback
adb shell pm disable-user --user 0 com.asus.ia.asusapp
adb shell pm disable-user --user 0 com.google.android.backuptransport
adb shell pm disable-user --user 0 com.asus.zencircle
adb shell pm disable-user --user 0 com.asus.loguploader
adb shell pm disable-user --user 0 com.asus.loguploaderproxy
adb shell pm disable-user --user 0 com.google.android.talk
adb shell pm disable-user --user 0 com.facebook.appmanager
adb shell pm disable-user --user 0 com.asus.easylauncher
adb shell pm disable-user --user 0 com.asus.kidslauncher
goto MENU

:AUTO_S22ULTRA
adb shell pm disable-user --user 0 com.samsung.android.aremoji
adb shell pm disable-user --user 0 com.samsung.android.service.livedrawing
adb shell pm disable-user --user 0 com.samsung.android.kidsinstaller
adb shell pm disable-user --user 0 com.sec.android.easyonehand
adb shell pm disable-user --user 0 com.sec.android.cover.ledcover
adb shell pm disable-user --user 0 com.sec.android.easyMover.Agent
adb shell pm disable-user --user 0 com.wsomacp
adb shell pm disable-user --user 0 com.samsung.android.game.gamehome
adb shell pm disable-user --user 0 com.microsoft.skydrive
adb shell pm disable-user --user 0 com.samsung.android.bixby.service
adb shell pm disable-user --user 0 com.samsung.android.messaging
adb shell pm disable-user --user 0 com.samsung.android.bixby.agent
adb shell pm disable-user --user 0 com.google.android.apps.tachyon
adb shell pm disable-user --user 0 com.facebook.services
adb shell pm disable-user --user 0 com.android.printspooler
adb shell pm disable-user --user 0 com.android.bips
adb shell pm disable-user --user 0 com.samsung.android.game.gametools
adb shell pm disable-user --user 0 com.samsung.android.service.peoplestripe
adb shell pm disable-user --user 0 com.samsung.android.da.daagent
adb shell pm disable-user --user 0 com.samsung.android.app.routines
adb shell pm disable-user --user 0 com.google.android.printservice.recommendation
adb shell pm disable-user --user 0 com.samsung.android.arzone
adb shell pm disable-user --user 0 com.samsung.android.authfw
adb shell pm disable-user --user 0 com.sec.android.app.sbrowser
adb shell pm disable-user --user 0 com.samsung.android.bixbyvision.framework
adb shell pm disable-user --user 0 com.samsung.android.game.gos
adb shell pm disable-user --user 0 com.samsung.android.app.camera.sticker.facearavatar.preload
adb shell pm disable-user --user 0 com.facebook.system
adb shell pm disable-user --user 0 com.samsung.android.oneconnect
adb shell pm disable-user --user 0 com.samsung.android.voc
adb shell pm disable-user --user 0 com.sec.penup
adb shell pm disable-user --user 0 com.samsung.android.bixby.wakeup
adb shell pm disable-user --user 0 com.samsung.android.samsungpass
adb shell pm disable-user --user 0 com.samsung.android.spayfw
adb shell pm disable-user --user 0 com.samsung.android.app.spage
adb shell pm disable-user --user 0 com.sec.android.mimage.avatarstickers
adb shell pm disable-user --user 0 com.sec.android.emergencylauncher
adb shell pm disable-user --user 0 com.sec.android.easyMover
adb shell pm disable-user --user 0 com.samsung.android.visionintelligence
adb shell pm disable-user --user 0 com.samsung.android.mateagent
adb shell pm disable-user --user 0 com.samsung.android.samsungpassautofill
adb shell pm disable-user --user 0 com.facebook.appmanager
goto MENU

:AUTO_WATCH4
adb shell pm disable-user --user 0 com.samsung.android.watch.cameracontroller
adb shell pm disable-user --user 0 com.samsung.sree
adb shell pm disable-user --user 0 com.samsung.android.watch.watchface.myphoto
adb shell pm disable-user --user 0 com.samsung.android.watch.watchface.mystyle
adb shell pm disable-user --user 0 com.google.android.apps.messaging
adb shell pm disable-user --user 0 com.google.android.marvin.talkback
adb shell pm disable-user --user 0 com.samsung.android.messaging
adb shell pm disable-user --user 0 com.samsung.android.bixby.agent
adb shell pm disable-user --user 0 com.samsung.android.samsungpay.gear
adb shell pm disable-user --user 0 com.samsung.android.app.contacts
adb shell pm disable-user --user 0 com.samsung.android.app.reminder
adb shell pm disable-user --user 0 com.google.android.apps.maps
adb shell pm disable-user --user 0 com.samsung.android.dialer
adb shell pm disable-user --user 0 com.samsung.android.wear.calculator
adb shell pm disable-user --user 0 com.samsung.wear.contacts.sync
adb shell pm disable-user --user 0 com.google.android.apps.wearable.retailattractloop
adb shell pm disable-user --user 0 com.google.android.wearable.assistant
adb shell pm disable-user --user 0 com.samsung.android.wearable.music
adb shell pm disable-user --user 0 com.samsung.android.bixby.wakeup
adb shell pm disable-user --user 0 com.samsung.android.providers.contacts
adb shell pm disable-user --user 0 com.android.providers.userdictionary
adb shell pm disable-user --user 0 com.samsung.android.watch.worldclock
goto MENU
