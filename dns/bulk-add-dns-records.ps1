Add-DnsServerPrimaryZone -ComputerName DC01 -NetworkId "10.10.10.0/24" -ReplicationScope Domain


Import-CSV "C:\PS\example-bulk-dns-records.csv" | %{
Add-DnsServerResourceRecordA -ZoneName example.com -Name $_."HostName" -CreatePtr -IPv4Address $_."IPAddress"
}


Get-DnsServerResourceRecord -ComputerName DC01 -ZoneName "10.10.10.in-addr.arpa"


