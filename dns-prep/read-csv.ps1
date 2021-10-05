Import-Csv .\Documents\nwn-network-inventory-dns-prep-1.csv | ForEach-Object {
    if  ( $($_.IPAddress) -match "^\d+" ) {
        $str_pos = $($_.HostName).IndexOf('.')
        if ( $str_pos -eq -1 ) {
            $left_name = $($_.HostName).Trim().ToLower()
        } else  {
            $left_name = $($_.HostName.Substring(0, $str_pos)).Trim().ToLower()
        }
        Write-Host "$($_.IPAddress),$left_name.$($_.Domain_new)"
    }
}
