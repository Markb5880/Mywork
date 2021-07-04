<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in March 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify
some of the Domino Database stucture, after running short bits of code and using Get-Member on some parts
of it and looking at online code snippets and reading some of the online info from IBM I have come up with
the function below to Create an Empty Domino Group.

######
Original Creation: 28/03/2020 by MBaker

#####
This is how to use this function:

Remove-DominoGroup <NewGroupName>
Remove-DominoGroup Test7

Main use of this function is to connect to an IBM Domino Server and Delete a Group.
#>

Function Remove-DominoGroup {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$RemoveGroup
    )

cls
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession

# Initialize Lotus Notes Object
# "It'll use your open notes session and authentication Details"
$DomSession.Initialize()

# Use Method from Objects returned in variable $domsession one of which is CreateAdministrationProcess which
# takes a Server as input
$adminProcess = $Domsession.CreateAdministrationProcess("Dom-01/smallhome")

# The output properties will be to do with the Certifiers and Cert Authority, these need to be filled in as below
$adminProcess.CertifierFile="C:\Program Files\IBM\Lotus\Notes\Data\ids\cert.id"
$adminProcess.CertifierPassword="swindon"
$adminProcess.CertificateAuthorityOrg="/smallhome"

# If this executes with no error the variable $adminprocess will contain another set of objects
# one of which is a method called 'DeleteGroup' which takes 2 inputs: GroupName to delete and Manual/AdminP procesing.
# *True* deletes all references to the group in the Domino Directory before issuing an administration process request or
# *False* which lets the administration process look after the deletion process.

try {
$Notesid=$adminprocess.DeleteGroup("$RemoveGroup",$False)
[System.Windows.MessageBox]::Show('SUCCESS - The selected group has been sent for processing. Check the Groups view in the Domino Admin in a few minutes to ensure the Required Group has been deleted.','Domino Remove Group','OK','Information')
$body="Group $RemoveGroup Deletion has been sent for processing, Please Refresh and Check Domino Admin's Group View for Verification in a few minutes."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "Success-Group Deletion" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
catch {
[System.Windows.MessageBox]::Show("The Group $RemoveGroup does not exist in the Domino Directory !",'Group Remove Error','OK','Error')
$body="Group $RemoveGroup has FAILED to be Deleted because it does not Exist in the Domino Directory."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED-Group Deletion" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
}
Remove-DominoGroup $RemoveGroup
#Remove-DominoGroup "testaa"