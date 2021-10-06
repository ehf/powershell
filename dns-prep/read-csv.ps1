
# read-csv.ps1 .\Documents\dns-prep-1.csv > .\Documents\dns-prep-1-out.csv 
# Get-Content .\Documents\dns-prep-1-out.csv

param($file_to_read)

Import-Csv $file_to_read | ForEach-Object {
    if ( ( $($_.IPAddress).Trim() -as [IPAddress] -as [Bool] ) -And ( $($_.HostName).Trim() -match "^\w+" )  ) {
    
        # trim whitespace and set to lower case
        $str_ip = $($_.IPAddress).Trim()
        $str_hostname = $($_.HostName).Trim().ToLower()
        $str_domain = $($_.Domain_new).Trim().ToLower()
        
        # take into account any '.' in hostname and pull out left portion of any fqdn
        $str_pos = $str_hostname.IndexOf('.')
        if ( $str_pos -eq -1 ) {
            $left_name = $str_hostname
        } else  {
            $left_name = $str_hostname.Substring(0, $str_pos)
        }
        
        # output newly formatting line
        Write-Output "$str_ip,$left_name.$str_domain"
    }
}
