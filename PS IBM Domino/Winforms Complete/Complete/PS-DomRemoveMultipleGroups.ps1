<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in April 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify
some of the Domino Database stucture, after running short bits of code and using Get-Member on some parts
of it and looking at online code snippets and reading some of the online info from IBM I have come up with
the function below to Remove Multiple Domino Groups.

######
Original Creation: 07/04/2020 by MBaker

#####
This is how to use this function:

Remove-MultipleDominoGroups <Count of Total Groups-1> "<Group List separated by commas>"

Main use of this function is to connect to an IBM Domino Server and Delete a Group.
#>

Function Remove-MultipleDominoGroups {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][int]$GroupCount,
        [parameter(Position=1,Mandatory=$true,ValueFromPipeline=$True)][string]$RemoveGroup
    )

cls
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession

# Initialize Lotus Notes Object
# "It'll use your open notes session and authentication Details"
$DomSession.Initialize()

$GrpOut=@()

if ($GroupCount -ge 1){

#Split the groups into the array as the AddGroupMembers method will only process one group at a time.
foreach ($CurrentGroups in $RemoveGroup) {
    $GrpOut+=$Currentgroups.split("{,}")
    }
}
while ($GroupCount -ge 0){

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
try{
$Notesid=$adminprocess.DeleteGroup($GrpOut[$GroupCount],$False)
[void]$Grpout[$GroupCount]
$GroupCount --
}
catch {
[System.Windows.MessageBox]::Show('One or multiple Groups Do NOT exist in the Domino Directory! Please double-check the Groups View in the Domino Admin Tool to ensure your have correctly chosen the required Groups!','Remove Multiple Groups','OK','Error')
$body="One or multiple Groups Do NOT exist in the Domino Directory!"
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED - Non Existent Group" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
Exit
}
[System.Windows.MessageBox]::Show('SUCCESS - All requested groups have been sent for processing! Please refresh the Groups View in the Domino Admin Tool in a few minutes time to ensure the removal has been completed.','Remove Multiple Groups','OK','Information')
}
}
Remove-MultipleDominoGroups $GroupCount "$RemoveGroup"