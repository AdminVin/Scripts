New-NetFirewallRule -DisplayName "QuickBooks Database Manager - Port - TCP (54861)" -Direction Inbound -LocalPort 54861 -Protocol TCP -Action Allow
New-NetFirewallRule -DisplayName "QuickBooks Database Manager - Port - UDP (54861)" -Direction Inbound -LocalPort 54861 -Protocol UDP -Action Allow
