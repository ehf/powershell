
param(
    [Parameter(Mandatory)]
    $file_to_read
)

$octet_result = Import-Csv $file_to_read | ForEach-Object {
    if ( $($_.IPAddress).Trim() -as [IPAddress] -as [Bool] ) {
        $octets = $($_.IPAddress).Trim().Split('.')
        
        Write-Output "$($octets[0]).$($octets[1])" 
    }
}

Write-Output $octet_result | Sort-Object -Unique 


