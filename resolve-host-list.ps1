
# EHF 10/8/2021
# resolve-host-list.ps1 ..\Documents\in\hostlist.txt ..\Documents\out\hostlist.resolved.out.txt
# Get-Content ..\Documents\hostlist.resolved.out.txt

# file format
# 
# host-1.example.com
# host-2.example.com
# host-3.example.com
# host-4.example.com
# host-5.example.com



param(
    [Parameter(Mandatory)] $file_in,
    [Parameter(Mandatory)] $file_out
)


foreach ($server in (Get-Content $file_in)) { 
    Resolve-DnsName -Name $server | Select-Object IPAddress,Name | Export-Csv -Path $file_out -Append -NoTypeInformation 
}


