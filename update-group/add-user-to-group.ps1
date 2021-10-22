
# update-security-group.ps1 C:\Temp\user_list.csv 

# example format for user-list.csv files
#
# UserPrincipalName
# me@example.com
# you@example.com
# them@example.com
# us@example.com



# location of file containing list of users
param(
    [Parameter(Mandatory)] $user_list
)


$work_path="C:\Temp\update-security-group"
$transcript_log="$work_path\update-security-group.log"

# create work directory, if not present
If( !(Test-Path $work_path) ) {
    New-Item -ItemType Directory -Force -Path $work_path
}


# Start transcript
Start-Transcript -Path $transcript_log -Append

# Import AD Module
Import-Module ActiveDirectory

# Import user list from CSV file ; trim any whitespace
$Users = Import-Csv $user_list | Foreach-Object { 
    $($_.UserPrincipalName).Trim() 
}


# Specify target group where the users will be added to
# You can add the distinguishedName of the group. 
# e.g. : CN=Pilot,OU=Groups,OU=Company,DC=example,DC=com
$Group = "Pilot" 

foreach ($User in $Users) {
    # Retrieve UPN
    $UPN = $User.UserPrincipalName

    # Retrieve UPN related SamAccountName
    $ADUser = Get-ADUser -Filter "UserPrincipalName -eq '$UPN'" | Select-Object SamAccountName

    # output if User not in AD
    if ($ADUser -eq $null) {
        Write-Host "$UPN does not exist in AD" -ForegroundColor Red
    }
    else {
        # Retrieve AD user group membership
        $ExistingGroups = Get-ADPrincipalGroupMembership $ADUser.SamAccountName | Select-Object Name

        # User already member of group
        if ($ExistingGroups.Name -eq $Group) {
            Write-Host "$UPN already exists in $Group" -ForeGroundColor Yellow
        }
        else {
            # Add user to group

            # "-WhatIf" option will output what would happen 
            # use this option to get an idea of what would be updated
            # comment this line out when ready to make the change
            Add-ADGroupMember -Identity $Group -Members $ADUser.SamAccountName -WhatIf

            # remove "-WhatIf" option to make the change
            # remove comment from line below when ready to make the change
            ## Add-ADGroupMember -Identity $Group -Members $ADUser.SamAccountName

            Write-Host "Added $UPN to $Group" -ForeGroundColor Green
        }
    }
}
Stop-Transcript



