<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in October by (myself) Mark Baker as 'a' just to see if I can de-mystify some of the Domino Database stucture,
after running short bits of code and using Get-Member on some parts of it and looking at online code snippets and reading some of the online
info from IBM I have come up with the function below to output a list of all mailgroups.
######
Last Upated: 06/12/2019 by MBaker
Added-: 

[cmdletbinding()]
    param (
    )

Last Upated: 12/12/2019 by MBaker
Added-: 

Save/Export routine

#####
This is how to use this function: Get-DominoGroupList these will be listed from the Domino Directory.

Main use of this function is to connect to a IBM Domino Server
and Export the Groups to a File
#>

Function Get-DominoGroupList {

[cmdletbinding()]
    param (
    )
 Add-Type -AssemblyName System.Windows.Forms
 $SaveAs1=New-Object System.Windows.Forms.SaveFileDialog

cls
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession

# Initialize Lotus Notes Object
# "It'll use your open notes session and authentication Details"
$DomSession.Initialize()

# Connect to Server, select db, use "","" for current connection details
$DomDatabase = $DomSession.GetDatabase("Dom-01","names.nsf")

# Open by Group View
$DomView = $DomDatabase.GetView('Groups')
$DomDoc = $DomView.GetFirstDocument()

#The Variable below is for sorting later.
$grplist=@()

# Pick out Fullname & Email Address & write each line out to a file
while ($Domdoc -ne $null) {
        $grpname = [string] $Domdoc.ColumnValues
        $grplist+= $grpname
        $Domdoc = $Domview.GetNextDocument($Domdoc) 
 }  #end while

# Save/Export routine    
    $SaveAs1.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
    $SaveAs1.SupportMultiDottedExtensions = $true;
    $SaveAs1.InitialDirectory = "C:\temp\"
    $SaveAs1.title="Save Domino group List"
# This is where the actual save takes place!

if($SaveAs1.ShowDialog() -eq 'Ok'){
$grplist | sort | Out-File $($SaveAs1.filename)
}

}
Get-DominoGroupList