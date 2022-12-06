# Application/Service Name
 $Name = "SMTP"
# TCP or UDP
$Protocol = "TCP"
# Ports syntax "54861" or "54861-54869" 
$Ports = "25"
 # Firewall Profile (Any, Domain, Public, Private)
$FirewallProfile = "Any"
# Add Rule
New-NetFirewallRule -Direction Outbound -DisplayName "$Name - Port - $Protocol ($Ports)" -Protocol $Protocol -LocalPort $Ports -Profile $FirewallProfile -Action Block