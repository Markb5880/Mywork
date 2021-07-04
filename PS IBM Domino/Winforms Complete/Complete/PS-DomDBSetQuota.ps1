<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in May 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify some of the Domino Database stucture,
after running short bits of code and using Get-Member on some parts of it and looking at online code snippets and reading some of the online
info from IBM I have come up with the function below to change a Databases Mail Quota and Mail Warning Quota.
######
Original Code: 02/05/2020 by MBaker

#####
This is how to use this function: Any paths are relative to the root directory of the domino data directory

Get-DomDBSetQuota "mail\jbloggs" 512 480

Main use of this function is to connect to a IBM Domino Server and allow setting of Mail Quotas.
#>

Function Set-DomDBSetQuota {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$false)][string]$NotesDB,
        [parameter(Position=1,Mandatory=$true,ValueFromPipeline=$false)]$SizeQuota,
        [parameter(Position=2,Mandatory=$true,ValueFromPipeline=$false)]$SizeWarning
    )
cls


# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession

# "It'll use your open notes session and authentication Details"
$DomSession.Initialize()

$DomDatabase = $DomSession.GetDatabase("Dom-01/smallhome","$NotesDB")
$DomMailPath=$NotesDB.substring(0,5)
$A=$NotesDB.Substring(5)
# The IF statement below is used for checking for the Existence of an input Database, as all databases
# Have a ReplicaID!
if ($DomDatabase.ReplicaID -ne $null){

# The $a & $b values are checked for the existence of numbers by using REGEX,
# If OK they are CAST as INT's for the numerics required in the calculations, else
# any existence of non-numerics are reported as Errors.

$a=$SizeQuota -match "^\d+$"

if ($a){
$b=$SizeWarning -match "^\d+$"
    if (-not $b){
    [System.Windows.MessageBox]::Show('You have entered text in the Quota Warning box, please enter a value!','Input Error','OK','Error')
    Exit
    }

$SizeQuota = $SizeQuota -as [int]
$SizeWarning = $SizeWarning -as [int]
$SizeQuota=$SizeQuota*1024
$SizeWarning=$SizeWarning*1024
$DomDatabase.SizeQuota=$SizeQuota
$DomDatabase.SizeWarning=$SizeWarning

[System.Windows.MessageBox]::Show('SUCCESS - Database values have been updated!','Set Database Quotas','OK','Information')
$body="The Database for chosen user has had its Quota and Warning values updated."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "SUCCESS - Database Quotas Updated." -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"    
}
    else {
    [System.Windows.MessageBox]::Show('You have entered text in the Quota box, please enter a value!','Input Error','OK','Error')
        }
    Exit
        } else {
        [System.Windows.MessageBox]::Show("User Database $A does NOT Exist in this Path $DomMailPath. Check in a different path or the database may not exist on this Server!",'Open Database Failure','OK','Error')
$body="Requested Database $A does not Exist in this Path $DomMailPath. Check in a different path or the database may not exist on this Server!"
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED - Database Not Found!" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
Exit
        }
}
Set-DomDBSetQuota $NotesDB $SizeQuota $SizeWarning
#Set-DomDBSetQuota mail\mjones.nsf 76 75