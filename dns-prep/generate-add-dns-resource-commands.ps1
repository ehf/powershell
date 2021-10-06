
param(
    [Parameter(Mandatory)]
    $file_to_read
)


# read csv output file 
# csv fields and format: 
# 
# IPAddress,HostName
# 10.10.10.10,host-1.a.example.com
# 10.10.10.11,host-2.a.example.com
# 10.20.20.20,host-3.example.com
# 10.30.30.30,host-4.b.example.com
#
#

Import-Csv $file_to_read | ForEach-Object {
        if ( ( $($_.IPAddress).Trim() -as [IPAddress] -as [Bool] ) -And 
             ( $($_.HostName).Trim() -match "^\w+" ) ) {

            $str_ip = $($_.IPAddress).Trim()
            $str_hostname = $($_.HostName).Trim().ToLower()
            
            $str_pos = $str_hostname.IndexOf('.')
            $left_name = $str_hostname.Substring(0, $str_pos)
            $domain_name = $str_hostname.Substring($str_pos+1)
            
                
            Write-Output "Add-DnsServerResourceRecordA -ZoneName $domain_name -Name $left_name -CreatePtr -IPv4Address $($_.IPAddress)"

        }

}

