# Application/Service Name
$Name = "Quickbooks Database Manager"
# TCP or UDP
$Protocol = "TCP"
# Ports syntax "54861" or "54861-54869" 
$Ports = "54861-54869"
# Firewall Profile (Any, Domain, Public, Private)
$FirewallProfile = "Any"
# Add Rule
New-NetFirewallRule -Direction Inbound -DisplayName "$Name - Port - $Protocol ($Ports)" -Protocol $Protocol -LocalPort $Ports -Profile $FirewallProfile -Action Allow
