
# EHF 10/6/2021
# generate-dns-reverse-zone-commands.ps1 .\Documents\csv-in\inventory-all-ipaddr-1.csv > inventory-all-ipaddr.dns-prep.out.txt
# Get-Content inventory-all-ipaddr.dns-prep.out.txt


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

