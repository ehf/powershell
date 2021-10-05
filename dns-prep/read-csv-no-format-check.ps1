
Import-Csv .\Documents\dns-prep.csv | ForEach-Object {
    if  ( $_.IPAddress -match "^\d+")
    {
        Write-Host "$($_.IPAddress),$($_.HostName).$($_.Domain_new)"
    }
}

