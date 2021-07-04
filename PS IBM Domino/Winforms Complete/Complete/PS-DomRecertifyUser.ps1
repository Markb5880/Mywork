<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in April 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify
some of the Domino Database stucture, after running short bits of code and using Get-Member on some parts
of it and looking at online code snippets and reading some of the online info from IBM I have come up with
the function below to Recertify a users ID file.

######
Original Code: 06/04/2020 by MBaker

Added Code: 02/06/2020 - [System.Windows.MessageBox]::Show('User has Failed to Re-certify or does not Exist!')
To the Catch Block

This is how to use this function:

Set-RecertifyDominoUser "brian law"

Main use of this function is to connect to an IBM Domino Server and Recertify a users ID file.
** MAKE SURE TO RUN THIS BEFORE THE INITIAL EXPIRATION **
#>

Function Set-RecertifyDominoUser {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$User
        
    )
# /smallhome needs to be added to allow the user document to be recertified
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

try {
$Notesid=$adminprocess.RecertifyUser("$User")
[System.Windows.MessageBox]::Show("SUCCESS - The details for $User have been sent for proccessing, please wait a few minutes for this to be processed.",'Domino User Re-Certification','OK','Information')
$body="User $User Certification details have been sent for processing, Please Refresh and Check Domino Admin's Certsrv.nsf for Verification in a few minutes."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "Success-user Certification" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
catch {
[System.Windows.MessageBox]::Show("User $User does not Exist in the Domino Directory!",'User Re-Certify Error','OK','Error')
$body="User $User has FAILED to be Re-Certified Check either the Domino Logs or the Certsrv.nsf database for more information."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED-user Certification" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
}

Set-RecertifyDominoUser $User