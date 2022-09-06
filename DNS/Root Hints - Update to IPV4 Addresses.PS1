#region Notes
# This is a work in progress and unfinished.
#endregion

#region Varibles
# Verisign, Inc.
$A_Server = "a.root-servers.net"
$A_IPv4 = "198.41.0.4"
# University of Southern California, Information Sciences Institute
$B_Server = "b.root-servers.net"
$B_IPv4 = "199.9.14.201"
# University of Southern California, Information Sciences Institute
$C_Server = "c.root-servers.net"
$C_IPv4 = "192.33.4.12"
# University of Maryland
$D_Server = "d.root-servers.net"
$D_IPv4 = "199.7.91.13"

#endregion


#region Update Root Hint Servers

# Verisign, Inc.
Remove-DnsServerRootHint -NameServer $A_Server -Force
Add-DnsServerRootHint -NameServer $A_Server -IPAddress $A_IPv4
# University of Southern California, Information Sciences Institute
Remove-DnsServerRootHint -NameServer $B_Server -Force
Add-DnsServerRootHint -NameServer $B_Server -IPAddress $B_IPv4
# Cogent Communications
Remove-DnsServerRootHint -NameServer $C_Server -Force
Add-DnsServerRootHint -NameServer $C_Server -IPAddress $C_IPv4
# University of Maryland
Remove-DnsServerRootHint -NameServer $D_Server -Force
Add-DnsServerRootHint -NameServer $D_Server -IPAddress $D_IPv4
#endregion




c.root-servers.net	192.33.4.12, 2001:500:2::c
# University of Maryland
d.root-servers.net	199.7.91.13, 2001:500:2d::d	
# NASA (Ames Research Center)
e.root-servers.net	192.203.230.10, 2001:500:a8::e	
# Internet Systems Consortium, Inc.
f.root-servers.net	192.5.5.241, 2001:500:2f::f
# US Department of Defense (NIC)
g.root-servers.net	192.112.36.4, 2001:500:12::d0d
# US Army (Research Lab)
h.root-servers.net	198.97.190.53, 2001:500:1::53
# Netnod
i.root-servers.net	192.36.148.17, 2001:7fe::53
# Verisign, Inc.
j.root-servers.net	192.58.128.30, 2001:503:c27::2:30
# RIPE NCC
k.root-servers.net	193.0.14.129, 2001:7fd::1
# ICANN
l.root-servers.net	199.7.83.42, 2001:500:9f::42
# WIDE Project
m.root-servers.net	202.12.27.33, 2001:dc3::35