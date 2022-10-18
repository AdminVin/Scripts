@echo off
echo *******************************************
echo * Installing Windows SERIAL Key to the PC *
echo *******************************************
echo *
slmgr.vbs -ipk XXXXX-XXXXX-XXXXX-XXXXX-XXXXX 
echo *
echo **********************
echo * Activating Windows *
echo **********************
echo *
slmgr.vbs -ato
echo *
echo ************************
echo * Activation Complete. *
echo ************************
pause
exit