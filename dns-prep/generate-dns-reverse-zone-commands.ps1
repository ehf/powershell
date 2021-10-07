
# EHF 10/6/2021
# generate-dns-reverse-zone-commands.ps1 .\Documents\csv-in\inventory-all-ipaddr-1.csv > inventory-all-ipaddr.dns-prep.out.txt
# Get-Content inventory-all-ipaddr.dns-prep.out.txt


# read csv file in following format
# (script only goes through IPAddress column) 
#
# IPAddress,HostName
# 10.10.10.10,host-1.example.com
# 10.10.10.11,host-2.example.com
# 10.10.10.12,host-3.example.com
# 10.20.20.20,host-4.a.example.com
# 10.20.20.21,host-5.a.example.com
# 10.20.20.22,host-6.a.example.com
# 10.30.30.30,host-7.b.example.com
# 10.30.31.31,host-8.c.example.com
# 10.30.31.32,host-9.c.example.com
# 

param(
    [Parameter(Mandatory)] $file_to_read
)

$octet_result = Import-Csv $file_to_read | ForEach-Object {
    if ( $($_.IPAddress).Trim() -as [IPAddress] -as [Bool] ) {
        $octets = $($_.IPAddress).Trim().Split('.')
        
        $net_id="$($octets[0]).$($octets[1]).$($octets[2]).0/24" 

        # if commands will be run from DNS server host
        Write-Output "Add-DnsServerPrimaryZone -NetworkId ""$net_id"" -ReplicationScope Domain"

        # if commands will be run from remote hosts (not local on DNS server host)
        ##Write-Output "Add-DnsServerPrimaryZone -ComputerName dc01 -NetworkId ""$net_id"" -ReplicationScope Domain"
    }
}

Write-Output $octet_result | Sort-Object -Unique 

