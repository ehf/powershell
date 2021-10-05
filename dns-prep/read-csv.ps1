
Import-Csv .\Documents\nwn-network-inventory-dns-prep-1.csv | ForEach-Object {
    if  ( $_.IPAddress -match "^\d+")
    {
        Write-Host "$($_.IPAddress),$($_.HostName).$($_.Domain_new)"
    }
}

