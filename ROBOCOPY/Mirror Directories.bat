@ECHO OFF
ROBOCOPY "D:\Documents" "Z:\Documents" /MIR
ROBOCOPY "D:\Music" "Z:\Music" /MIR
ROBOCOPY "D:\Pictures" "Z:\Pictures" /MIR
ROBOCOPY "D:\Videos" "Z:\Videos" /MIR
COLOR 2
ECHO ***************************************************************
ECHO ***************************************************************
ECHO **                                                           **
ECHO **                                                           **
ECHO **                    Backup Complete.                       **
ECHO **               You can now close this window               **
ECHO **                                                           **
Echo **                                                           **
ECHO ***************************************************************
ECHO ***************************************************************
pause
