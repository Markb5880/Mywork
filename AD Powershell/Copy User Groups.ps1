#Import-module activedirectory
# Version 1 - Copy all groups from one user to another - No error handling used
# Error handling should be implmented
$UserA=Get-ADUser -filter ('Name -like "daryl hannah"') -SearchBase "OU=TS Tech Users,DC=smallhome,DC=local"
$unameA=$UserA.name
$UserAgrps=Get-ADPrincipalGroupMembership $UserA.SamAccountName
#$UserAgrps.Name
$UserB=Get-ADUser -filter ('Name -like "harry giles"') -SearchBase "OU=TS Tech Users,DC=smallhome,DC=local"
$unameB=$UserB.samaccountname
$UserBgrps=Get-ADPrincipalGroupMembership $UserB.SamAccountName
foreach ($UserAgroup in $UserAgrps.Name){
    foreach($UserBGroup in $UserBgrps.Name){
        if ($UserBGroup -ne $UserAgroup){
            Add-ADGroupMember $UserAgroup -Members $unameB
            write-output "$unameB has been added to $UserAgroup."    
        }
        Else {Write-output "$unameB is already in $UserAgroup"}   
    }
}   
Write-Output "Both Users are now in the same groups!"

