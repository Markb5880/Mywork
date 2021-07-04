<#
TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in October by (myself) Mark Baker as 'a' just to see if I can de-mystify some of the Domino Database stucture,
after running short bits of code and using Get-Member on some parts of it and looking at online code snippets and reading some of the online
info from IBM I have come up with the function below to output a mailgroup plus it's members.
######
Last Upated: 06/12/2019 by MBaker
Added-: 

[cmdletbinding()]
    param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$DomGroup
    )

Last Upated: 12/12/2019 by MBaker
Added-: 

Save/Export routine

#####
This is how to use this function: Get-DominoGroupMembers 'mis_office_support_team' the text between the 's is the group name, these are not required
if the group name has spaces, then enclose it in double quotes, input can be any valid domino group that shows up in the Domino Directory.
#>

Function Get-DominoGroupMembers {
[cmdletbinding()]
    param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][string]$DomGroup
    )
 Add-Type -AssemblyName System.Windows.Forms
 $SaveAs1=New-Object System.Windows.Forms.SaveFileDialog
       
# This Function requires Domino Email groups as input and outputs to a file.

cls
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession

#$DomSession.InitializeUsingNotesUserName("FullAccess Administrator","password")
# "It'll use your open notes session and authentication, you can pass passwords into this"
$DomSession.Initialize()

# Connect to Server and select db

$DomDatabase = $DomSession.GetDatabase("Dom-01","names.nsf")


# Open - Groups View
$DomView = $DomDatabase.GetView('Groups')

$DomDoc = $DomView.GetFirstDocument()

#The Variable below is for sorting later.
$grplist=@()
#The Line below provides the Group Name
$grplist+= $DomGroup
# Select the Group by its Doc Key
        $grpname = $Domview.getdocumentbykey("$DomGroup")
# Now get the Members of the Group
try {
        $mem=$grpname.getitemvalue("members")
} catch {
[System.Windows.MessageBox]::Show("Group $DomGroup does not Exist in the Domino directory!",'Non Existent Group','OK','Error')
$body="Group $DomGroup does not Exist in the Domino directory!"
Send-MailMessage -From "administrator@smallhome.local" -To "administrator@smallhome.local" -Subject "FAILED - Non Existent Group" -Bodyashtml $body -SmtpServer "Dom-01.smallhome.local"
Exit
}
# Add them to an array, format them neatly
        $grplist+= $mem        

# Save/Export routine    
    $SaveAs1.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
    $SaveAs1.SupportMultiDottedExtensions = $true;
    $SaveAs1.InitialDirectory = "C:\temp\"

# This is where the actual save takes place!

if($SaveAs1.ShowDialog() -eq 'Ok'){
$grplist | sort | Out-File $($SaveAs1.filename)
}
        
}  #end while

#Get-DominoGroupMembers "Testbobo"
Get-DominoGroupMembers $DomGroup
