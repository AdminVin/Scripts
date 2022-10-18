:: Notes: Enables Administrator account in windows / Password Change

echo off
net user Administrator /active:yes
echo Administrator Account Enabled.
echo ______________________________

echo Administrator Password Change:
net user Administrator *
exit
