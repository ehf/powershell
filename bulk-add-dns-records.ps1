Import-CSV "C:\PS\example-bulk-dns-records.csv" | %{
Add-DNSServerResourceRecordA -ZoneName example.com -Name $_."HostName" -CreatePtr -IPv4Address $_."IPAddress"
}

