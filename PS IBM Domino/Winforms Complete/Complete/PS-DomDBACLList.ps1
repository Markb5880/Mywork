<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in December by (myself) Mark Baker as 'a' just to see if I can de-mystify some of the Domino Database stucture,
after running short bits of code and using Get-Member on some parts of it and looking at online code snippets and reading some of the online
info from IBM I have come up with the function below to output a Database ACL list.
######
Last Upated: 06/12/2019 by MBaker
Added-: 

[cmdletbinding()]
    param (
            [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$NotesDB
    )
#####
This is how to use this function: Any paths are relative to the root directory of the domino data directory

Get-DominoDBACLList accounts_midb.nsf
Get-DominoDBACLList mail\mbaker.nsf
Get-DominoDBACLList archive\a_aridley.nsf

Main use of this function is to connect to a IBM Domino Server
and Output a Databases ACL List.
#>

Function Get-DominoDBACLList {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$NotesDB
    )

cls
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession

# Initialize Lotus Notes Object
# "It'll use your open notes session and authentication Details"
$DomSession.Initialize()

# Connect to Server, select db, use "","" for current connection details

$DomDatabase = $DomSession.GetDatabase("Dom-01","$NotesDB")

$DomMailPath=$NotesDB.substring(0,5)
$A=$NotesDB.Substring(5)
$ACL = $DomDatabase.ACL
if (-not $ACL){
[System.Windows.MessageBox]::Show("Database $A does not Exist in this Path $DomMailPath. Check in a different path or the database may not exist on this Server!",'Open Database Failure','OK','Error')
$body="Requested Database $A does not Exist in this Path $DomMailPath. Check in a different path or the database may not exist on this Server!"
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED - Database Not Found!" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
Exit
}

#The Variable below is for sorting later.
[string]$acllist=@()

$Firstentry = $ACL.GetFirstEntry()

 While ($Firstentry -ne $null)
    {
    $acllist+=$Firstentry.name+"`r`n"
        $Nextentry = $ACL.GetNextEntry($firstentry)
        $Firstentry = $Nextentry
    }
$textbox2.text=$acllist
}
Get-DominoDBACLList $NotesDB
#Get-DominoDBACLList mail\mjackson.nsf