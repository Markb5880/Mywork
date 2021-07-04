<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in April 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify
some of the Domino Database stucture, after running short bits of code and using Get-Member on some parts
of it and looking at online code snippets and reading some of the online info from IBM I have come up with
the function below to add members to new or existing groups.

######
This is a modified version of the the New-DominoGroup code: 03/04/2020 by MBaker

#####
This is how to use this function:

New-DominoGroup <New or Existing group> <member list separated by  a ','>
New-DominoGroup Test7 "fredwest/smallhome,adamwest/smallhome"

Main use of this function is to connect to an IBM Domino Server and  Either Create a New Group along with group members
or add new group members to an existing group

#>

Function Set-AddGroupMembers {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$false)][string]$NewGroup,
        [parameter(Position=1,Mandatory=$true,ValueFromPipeline=$false)][string]$members
    )

cls

$DomSession = New-Object -ComObject Lotus.NotesSession

# "It'll use your open notes session and authentication Details"
$DomSession.Initialize()

# You need to have a members array of at least 2 strings, if creating an empty Group the 2 strings need to be empty!!
# It appears you cannot add a single user and an empty string or the other way around programatically?!??

$Newmember=@()

foreach ($out in $members) {
    $Newmember=$out.split("{,}")
    $Newmember+"/smallhome@smallhome"
    }
# Use Method from Objects returned in variable $domsession one of which is CreateAdministrationProcess which
# takes a Server as input
$adminProcess = $Domsession.CreateAdministrationProcess("Dom-01/smallhome")

# The output properties will be to do with the Certifiers and Cert Authority, these need to be filled in as below
$adminProcess.CertifierFile="C:\Program Files\IBM\Lotus\Notes\Data\ids\cert.id"
$adminProcess.CertifierPassword="swindon"
$adminProcess.CertificateAuthorityOrg="/smallhome"

# If this executes with no error the variable $adminprocess will contain another set of objects
# one of which is a method called 'AddGroupMembers' which takes 2 inputs: NewGroupName and a new Members list.
try {
$Notesid=$adminprocess.AddGroupMembers("$NewGroup",$($Newmember))
[System.Windows.MessageBox]::Show('Members SUCCESSFULLY added to New or Existing Group!','Add Group Members','OK','Information')
$body="Members Successfully added to New Group or Existing Group."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "Domino AddGroup Member Update" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
catch {
[System.Windows.MessageBox]::Show('Members FAILED to be added to New or Existing Group! Ensure you have entered at least 2 Group Members!!','Add Group Members','OK','Error')
$body="Members FAILED to be added to New Group or Existing Group."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "Domino AddGroup Member Update" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
}
Set-AddGroupMembers $NewGroup "$members"
