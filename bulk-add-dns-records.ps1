Import-CSV "C:\PS\NewDnsRecords.csv" | %{
Add-DNSServerResourceRecordA -ZoneName example.com -Name $_."HostName" -CreatePtr -IPv4Address $_."IPAddress"
}

