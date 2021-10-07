
# EHF 10/6/2021
# read-ipaddr-list.ps1 .\Documents\ip-address-list.csv > .\Documents\ip-address-list.split.sort.unique.out.txt 3
# Get-Content .\Documents\ip-address-list.split.sort.unique.out.txt 

param(
    [Parameter(Mandatory)] $file_to_read, 
    [Parameter(Mandatory)] $octets_count
)

$octet_result = Import-Csv $file_to_read | ForEach-Object {
    if ( $($_.IPAddress).Trim() -as [IPAddress] -as [Bool] ) {
        $octets = $($_.IPAddress).Trim().Split('.')
                
        $OFS="."
        Write-Output "$($octets[0..($octets_count - 1)])"
        ##Write-Output "$($octets[($octets_count - 1)..0]).in-addr.arpa"


    }
}

Write-Output $octet_result | Sort-Object -Unique 



