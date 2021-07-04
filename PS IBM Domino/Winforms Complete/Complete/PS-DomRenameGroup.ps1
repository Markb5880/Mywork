<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86) in 64bit Windows, ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in March 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify
some of the Domino Database stucture, after running short bits of code and using Get-Member on some parts
of it and looking at online code snippets and reading some of the online info from IBM I have come up with
the function below to Rename a Domino Group.

######
Last Upated: 27/03/2020 by MBaker
Added-: 

[cmdletbinding()]
    param (
            [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$Group
    )

######
Last Upated: 28/03/2020 by MBaker
Added-: 

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$CurrentGroup,
        [parameter(Position=1,Mandatory=$true,ValueFromPipeline=$True)][string]$NewGroup
    
    )

#####
This is how to use this function:

Rename-DominoGroup Group1 Test3

Main use of this function is to connect to a IBM Domino Server
and Rename a Domino Group with inputs as OldGroup Name and NewGroup Name.
#>

Function Rename-DominoGroup {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$CurrentGroup,
        [parameter(Position=1,Mandatory=$true,ValueFromPipeline=$True)][string]$NewGroup
    
    )
cls
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession

# Initialize Lotus Notes Object
# "It'll use your current notes session and authentication Details"
$DomSession.Initialize()

$adminProcess = $Domsession.CreateAdministrationProcess("Dom-01/smallhome")

# Use Method from Objects returned in variable $domsession one of which is CreateAdministrationProcess which
# takes a Server as input

# The output properties will be to do with the Certifiers and Cert Authority, these need to be filled in as below
$adminProcess.CertifierFile="C:\Program Files\IBM\Lotus\Notes\Data\ids"
$adminProcess.CertifierPassword="swindon"
$adminProcess.CertificateAuthorityOrg="/smallhome"

# If this executes with no error the variable $adminprocess will contain another set of objects
# one of which is a method called 'RenameGroup' which takes 2 inputs: OldGroupName and NewGroupName.

try {
$Notesid=$adminprocess.RenameGroup("$CurrentGroup","$NewGroup")
[System.Windows.MessageBox]::Show("SUCCESS - Group $CurrentGroup has been sent for Processing. Please check the Groups view in the Domino Admin to ensure the requested Group has been renamed to $NewGroup!",'Domino Group Rename','OK','Information')
$body="Group $CurrentGroup name change details have been sent for processing, Please Refresh and Check Domino Directorys Groups View for Verification in a few minutes. New Group Name will be $NewGroup."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "Success-Group rename" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
catch {
[System.Windows.MessageBox]::Show("The Group $CurrentGroup to be Renamed does not exist in the Domino Directory !",'Group Rename Error','OK','Error')
$body="Group $CurrentGroup Rename has FAILED. $CurrentGroup does not exist in the Domino Directory."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED-Group Rename" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
}
Rename-DominoGroup $CurrentGroup $NewGroup
