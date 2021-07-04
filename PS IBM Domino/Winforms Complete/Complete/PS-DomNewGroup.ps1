<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in March 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify
some of the Domino Database stucture, after running short bits of code and using Get-Member on some parts
of it and looking at online code snippets and reading some of the online info from IBM I have come up with
the function below to Create an Empty Domino Group.

######
Last Upated: 28/03/2020 by MBaker
Added-:

$members=@()
$members+=""
$members+=""
$Notesid=$adminprocess.AddGroupMembers("$NewGroup",$($members))

#####
This is how to use this function:

New-DominoEmptyGroup <NewGroupName>
New-DominoEmptyGroup Test7

Main use of this function is to connect to an IBM Domino Server and Create a New Group.
#>

Function New-DominoEmptyGroup {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$false)][string]$NewGroup
    )

cls
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession

# Initialize Lotus Notes Object
# "It'll use your open notes session and authentication Details"
$DomSession.Initialize()

# You need to have a members array of at least 2 strings, if creating an empty Group the 2 strings need to be empty!!
$members=@()
$members+=""
$members+=""

# Use Method from Objects returned in variable $domsession one of which is CreateAdministrationProcess which
# takes a Server as input
$adminProcess = $Domsession.CreateAdministrationProcess("Dom-01/smallhome")

# The output properties will be to do with the Certifiers and Cert Authority, these need to be filled in as below
$adminProcess.CertifierFile="C:\Program Files\IBM\Lotus\Notes\Data\ids"
$adminProcess.CertifierPassword="swindon"
$adminProcess.CertificateAuthorityOrg="/smallhome"

# If this executes with no error the variable $adminprocess will contain another set of objects
# one of which is a method called 'AddGroupMembers' which takes 2 inputs: NewGroupName and Empty Members list.
try {
$Notesid=$adminprocess.AddGroupMembers("$NewGroup",$($members))
[System.Windows.MessageBox]::Show('SUCCESSFUL - Your Requested Empty Domino Group has been created.','Domino Group Creation','OK','Information')
$body="New Group $NewGroup creation has been sent for processing, Please Check Domino Admin's Group View for Verification in a few minutes."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "Success-New Group Creation" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
catch {
[System.Windows.MessageBox]::Show('Group Creation Failure. Either the New Group you tried to create exists or alternatively Check the Administration database admin4.nsf for more information.','OK','Error')
$body="New Group $NewGroup has FAILED to be created Check either the Domino Logs or the Administration database admin4.nsf for more information."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED-New Group Creation" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
}
New-DominoEmptyGroup $NewGroup