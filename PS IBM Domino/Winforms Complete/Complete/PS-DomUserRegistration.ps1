<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in March 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify
some of the Domino Database stucture, after running short bits of code and using Get-Member on some parts
of it and looking at online code snippets and reading some of the online info from IBM I have come up with
the function below to Create a New Lotus Notes User.

######
Original Code: 31/03/2020 by MBaker

A lot of work testing and diagnosing the different settings and values EVENTUALLY lead me to getting this working,
as at 08/04/2020 I just need to work out the settings for setting the correct email address per person.

23/04/2020  I have to give a shout out to MikeIT from Spiceworks who helped me finish this off! Variable $fwddomain was " " not ""
            the code line: [parameter(Position=9,Mandatory=$true,ValueFromPipeline=$True)][string]$fwddomain,
            had to have [AllowEmptyString()] added to it before [string]$fwddomain, to accomodate this.
#####
This is how to use this function:

New-DominoUserRegistration "hazell" "C:\Program Files\IBM\Lotus\Notes\Data\ids\people\dhazell.id" "CN=Dom-01/O=Smallhome" "Daniel" "" "swindon" "Work" "comment" "mail\dhazell" "" "password" 176 "dhazell"


Main use of this function is to connect to an IBM Domino Server and Create a New lotus notes user.
#>

Function New-DominoUserRegistration {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$lastname,
        [parameter(Position=1,Mandatory=$true,ValueFromPipeline=$True)][string]$Useridfile,
        [parameter(Position=2,Mandatory=$true,ValueFromPipeline=$True)][string]$mailserver,
        [parameter(Position=3,Mandatory=$true,ValueFromPipeline=$True)][string]$firstname,
        [parameter(Position=4,Mandatory=$false,ValueFromPipeline=$True)][AllowEmptyString()][string]$middle,
        [parameter(Position=5,Mandatory=$true,ValueFromPipeline=$True)][string]$certpw,
        [parameter(Position=6,Mandatory=$true,ValueFromPipeline=$True)][AllowEmptyString()][string]$location,
        [parameter(Position=7,Mandatory=$true,ValueFromPipeline=$True)][AllowEmptyString()][string]$comment,
        [parameter(Position=8,Mandatory=$true,ValueFromPipeline=$True)][string]$maildbpath,
        [parameter(Position=9,Mandatory=$true,ValueFromPipeline=$True)][AllowEmptyString()][string]$fwddomain,
        [parameter(Position=10,Mandatory=$true,ValueFromPipeline=$True)][string]$userpw,
        [parameter(Position=11,Mandatory=$true,ValueFromPipeline=$True)][int]$usertype,
        [parameter(Position=12,Mandatory=$true,ValueFromPipeline=$True)][string]$ShortName,
        [parameter(Position=13,Mandatory=$true,ValueFromPipeline=$True)]$MailQuotaSizeLimit,
        [parameter(Position=14,Mandatory=$true,ValueFromPipeline=$True)]$MailQuotaWarningThreshold
    )
cls
# Code block below is a user input check aginst entering text into fields that expects numeric values
$a=$MailQuotaSizeLimit -match "^\d+$"

if ($a){
$b=$MailQuotaWarningThreshold -match "^\d+$"
    if (-not $b){
    [System.Windows.MessageBox]::Show('You have entered text in the Quota Warning box, please enter a value!','MailFile Quota Warning Input Error','OK','Error')
    Exit
    }

$SizeQuota = $SizeQuota -as [int]
$SizeWarning = $SizeWarning -as [int]
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession
# Initialize Lotus Notes Object
# "It'll use your open notes session and authentication Details"
$DomSession.Initialize()

# Use Method from Objects returned in variable $domsession one of which is CreateAdministrationProcess which
# takes a Server as input
$adminProcess = $Domsession.CreateRegistration()

$expiration = (Get-Date).adddays(1095)

$adminprocess.certifieridfile="C:\Program Files (x86)\IBM\Lotus\Notes\Data\ids\cert.id"
$adminprocess.Expiration =$expiration
$adminprocess.RegistrationServer="Dom-01/smallhome"
$adminprocess.UpdateAddressBook=$true
$adminProcess.GroupList="TestGJ","TestGK"
$adminProcess.CreateMailDb=$true
$adminProcess.PolicyName="/RegistrationSettings"
$adminProcess.ShortName=$ShortName
[int]$adminProcess.MailOwnerAccess=2
$adminProcess.MailACLManager="LocalDomainAdmins"
$adminProcess.MailInternetAddress=$ShortName+"@smallhome.local"
$adminProcess.MailQuotaSizeLimit=$MailQuotaSizeLimit
$adminProcess.MailQuotaWarningThreshold=$MailQuotaWarningThreshold
$adminProcess.MailTemplateName="Mail85.ntf"
try {
$label.Visible=$true
$label.Update()
$Notesid=$adminprocess.RegisterNewUser($lastname,$Useridfile,$mailserver,$firstname,$middle,$certpw,$location,$comment,$maildbpath,$fwddomain,$userpw,$usertype)
[System.Windows.MessageBox]::Show("E-Mail Account for user $firstname $lastname has been SUCCESSFULLY Created/Registered!!",'Domino User Creation','OK','Information')
$body="New Domino E-Mail User $firstname $lastname has been Successfully Registered."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "Successfull E-Mail Registration!" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
catch {
[System.Windows.MessageBox]::Show("E-Mail Account Creation/Registration for $firstname $lastname has FAILED!",'Domino User Creation','OK','error')
$body="New Domino E-Mail User $firstname $lastname Failed Registration. Please Check Domino Logs."
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "Failed E-Mail Registration!" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
}
} else {
[System.Windows.MessageBox]::Show('You have entered text in the Quota box, please enter a value!','Mailfile Quota Input Error','OK','Error')
}
}
New-DominoUserRegistration "$lastname" "C:\Program Files (x86)\IBM\Lotus\Notes\Data\ids\people\$ShortName.id" "CN=Dom-01/O=Smallhome" "$firstname" "$middle" "swindon" "" "" "mail\$ShortName" "" "password" 176 "$ShortName" $MailQuotaSizeLimit $MailQuotaWarningThreshold
