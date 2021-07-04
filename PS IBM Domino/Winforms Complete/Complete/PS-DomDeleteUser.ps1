<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in March 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify
some of the Domino Database stucture, after running short bits of code and using Get-Member on some parts
of it and looking at online code snippets and reading some of the online info from IBM I have come up with
the function below to Create an Empty Domino Group.

######
Original Code: 28/03/2020 by MBaker

Code adjusted, changed, debugged and fully tested on 29/03/2020

Code changed: 30/03/2020
Added $Mailfiledelete variable and to test for a no Mailfile delete condition to make sure it just exits
and not delete the mailfile. Also temporarily added text output to make sure correct routine is running.
#####
This is how to use this function:

Delete-DominoUser "bob patz" 0 - Don't delete Mailfile
Delete-DominoUser "bob patz" 1 - Delete Mailfile from Home Server only
Delete-DominoUser "bob patz" 2 - Delete Mailfile from Home Server & Replica

Main use of this function is to connect to an IBM Domino Server and Delete a user.
#>

Function Delete-DominoUser {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$User,
        [parameter(Position=1,Mandatory=$true,ValueFromPipeline=$True)][int]$MailFileDelete
    )
# /smallhome needs to be added to allow the user document to be deleted
$user=$user+"/smallhome"
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
$adminProcess.CertifierFile="C:\Program Files (x86)\IBM\Lotus\Notes\Data\ids\cert.id"
$adminProcess.CertifierPassword="swindon"
$adminProcess.CertificateAuthorityOrg="/smallhome"
if ($MailFileDelete -ne 0){
# If this executes with no error the variable $adminprocess will contain another set of objects
# one of which is a method called 'DeleteUser' which takes 5 inputs: Username,immediate flag (True/False)
# 1=Mailfile Removal from Home Server only,2=Home Server & Replica, 0=No Mailfile Removal, DenyGroup to  move user to,
# and finally Windows User if connected through LDAP.
try {
$label.Visible=$true
$label.Update()
$Notesid=$adminprocess.DeleteUser("$User",$false,$MailFileDelete,"xemployee",$False)
}
catch
{
[System.Windows.MessageBox]::Show("$User Does NOT Exist in the Domino Directory!")
$body="$User Does NOT Exist in the Domino Directory!"
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "Failed - User Deletion." -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"    
Exit
}
# The below timer is required to allow some background processing to take place before the Mailfile deletion document is
# ready to be approved
start-sleep -s 300

# The username needs to have certain elements attached to check with the approval document and thy need to be identical
$User1 = $User -replace '/','/O='
$User1=$User1.Insert(0,'CN=')

#get all pending requests
$db = $Domsession.GetDatabase("Dom-01","admin4.nsf",$false)
$appView = $db.GetView("Pending Administrator Approval")

$doc = $appView.GetFirstDocument()

#loop through requests to find request pertaining to current user and action, then approve
try {

while($doc -ne $null){
    $requestTargetAccountDN = $doc.Items.Get(4).Text #5= ProxyNameList, contains DN of account
    #$TargetAccountDN=$requestTargetAccountDN
    $requestTargetDbPath = $doc.Items.Get(20) #20= ProxyDatabasePath contains mailpath (mail/shortname)

    if($requestTargetAccountDN -eq $User1){
        if($doc.ColumnValues.Get(5) -eq "Approve Mail File Deletion"){
            [void]$adminProcess.ApproveMailFileDeletion($doc.NoteID)
          $body="User $User has been Successfully deleted.If you have requested Mailfile deletion please check the Mail path."
          Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "SUCCESS - User Deletion Process." -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"  
          }
        $doc = $appView.GetNextDocument($doc)
    }
}
[System.Windows.MessageBox]::Show('The User deletion process has SUCCEEDED, please check the admin4.nsf for details.','Domino User Deletion','OK','Information')
EXIT
} catch {
[System.Windows.MessageBox]::Show('The User deletion process has FAILED, please check the admin4.nsf for details.','Domino User Deletion','OK','Error')
$body="User $User has FAILED to be deleted. Please check the admin4.nsf for details."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED - User Deletion Process" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"    
EXIT
}
}
try {
$label.Visible=$true
$label.Update()
$Notesid=$adminprocess.DeleteUser($User,$false,$MailfileDelete,"xemployee",$False)
[System.Windows.MessageBox]::Show('The User deletion process has SUCCEEDED, please check the admin4.nsf for details.','User deletion Information','OK','Information')
$body="User $User has been Successfully deleted.If you have requested Mailfile deletion please check the Mail path."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "SUccess - User Deletion Process." -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"  
} catch {
[System.Windows.MessageBox]::Show("$User cannot be found! Please check a different path else the database may not exist on this Server.",'User deletion Information','OK','Error')
$body="User $User has FAILED to be deleted. Please check the admin4.nsf for details."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED - User Deletion Process" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"    
EXIT          
}
}
Delete-DominoUser $User $MailFileDelete
#Delete-DominoUser "norma peters" 1