Import-CSV "C:\PS\example-bulk-dns-records.csv" | %{
Add-DnsServerResourceRecordA -ZoneName example.com -Name $_."HostName" -CreatePtr -IPv4Address $_."IPAddress"
}

