<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in April 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify
some of the Domino Database stucture, after running short bits of code and using Get-Member on some parts
of it and looking at online code snippets and reading some of the online info from IBM I have come up with
the function below to Rename a Domino User and recertify the id file.

######
Original Code: 07/04/2020 by MBaker

Parameter block copied from test function for registering users and calling parameters amended appropriately.

#####
This is how to use this function:

Set-DomRenameUser "Sandy Thom" "Verdana" "Sandy" "" "" "" "" "" $false

PLEASE NOTE IF YOU SET ANY OF THE INPUT PARAMETERS TO '*' nothing will be changed.

Main use of this function is to connect to an IBM Domino Server and Delete a user.
#>

Function Set-DomRenameUser {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$OldUsername,
        [parameter(Position=1,Mandatory=$true,ValueFromPipeline=$True)][string]$Newlastname,
        [parameter(Position=2,Mandatory=$true,ValueFromPipeline=$True)][string][AllowEmptyString()]$Newfirstname,
        [parameter(Position=3,Mandatory=$false,ValueFromPipeline=$True)][string][AllowEmptyString()]$Newmiddle,
        [parameter(Position=4,Mandatory=$false,ValueFromPipeline=$True)][string]$Neworgunit,
        [parameter(Position=5,Mandatory=$false,ValueFromPipeline=$True)][string]$Newaltcommonname,
        [parameter(Position=6,Mandatory=$false,ValueFromPipeline=$True)][string]$Newaltorgunit,
        [parameter(Position=7,Mandatory=$false,ValueFromPipeline=$True)][string]$Newaltlang,
        [parameter(Position=8,Mandatory=$true,ValueFromPipeline=$True)][bool]$Newrenamewindowsuser
    )
cls
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession
$OldUsername=$OldUsername+"/smallhome"
# Initialize Lotus Notes Object
# "It'll use your open notes session and authentication Details"
$DomSession.Initialize()

# Use Method from Objects returned in variable $domsession one of which is CreateAdministrationProcess which
# takes a Server as input
$adminProcess = $Domsession.CreateAdministrationProcess("Dom-01/smallhome")

# Current 'CreateAdministrationProcess' objects used and set below
$adminprocess.certifierfile="C:\Program Files (x86)\IBM\Lotus\Notes\Data\ids\cert.id"
$adminprocess.certifierPassword="swindon"
$adminProcess.CertificateAuthorityOrg="/smallhome"

# set and call relevant method: in this case 'RenameNotesUser'

try {
$Notesid=$adminprocess.RenameNotesUser($OldUsername,$Newlastname,$Newfirstname,$Newmiddle,$Neworgunit,$Newaltcommonname,$Newaltorgunit,$Newaltlang,$Newrenamewindowsuser)
[System.Windows.MessageBox]::Show("SUCCESS - Details for User $Oldusername have been sent for processing! Check Domino Admin's People view for Verification in a few minutes.",'Domino Rename User','OK','Information')
$body="A Rename User process has been sent for $OldUsername. Please Refresh and Check Domino Admin's People view for Verification in a few minutes."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "Success-User Rename" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
catch {
[System.Windows.MessageBox]::Show("A Rename User process has FAILED, User $OldUsername may not Exist in the Domino Directory!",'Rename Processing Error','OK','Error')
$body="A Rename User process has FAILED. Check either the Domino Logs or the admin4.nsf database for more information."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED-User Rename" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
}
Set-DomRenameUser "$OldUsername" "$Newlastname" "$Newfirstname" "$Newmiddle" "" "" "" "" $false
