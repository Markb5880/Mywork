<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in December by (myself) Mark Baker as 'a' just to see if I can de-mystify some of the Domino Database stucture,
after running short bits of code and using Get-Member on some parts of it and looking at online code snippets and reading some of the online
info from IBM I have come up with the function below to collect and export out usernames and email addresses from Domino, the last of which are not
usually available from the Domino Admin Tool.
######
Last Upated: 12/12/2019 by MBaker

Save/Export routine added.

#>

Function Get-AllDominoEmailAddresses {

Add-Type -AssemblyName System.Windows.Forms
    $SaveAs1=New-Object System.Windows.Forms.SaveFileDialog

cls
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession

# Initialize Lotus Notes Object
# "It'll use your open notes session and authentication"
$DomSession.Initialize()

# Connect to Server and select db
$DomDatabase = $DomSession.GetDatabase("Dom-01","names.nsf")

# Open by People View (Decreases Chance of showing up Duplicate Email Addresses)
$DomView = $DomDatabase.GetView('People')
$DomDoc = $DomView.GetFirstDocument()

#The Variable below is for sorting later.
$mailist=@()

# Pick out Fullname & Email Address & write each line out to a file
while ($Domdoc -ne $null) {
        $internetAddress = [string] $Domdoc.GetItemValue("InternetAddress")
        $firstname = [string] $Domdoc.GetItemValue("FirstName")
        $LastName = [string] $Domdoc.GetItemValue("LastName")
        $FullName = [string] $firstname.PadRight(15)+$LastName
        $mailist+= $Fullname.PadRight(35) + $internetAddress
        $Domdoc = $Domview.GetNextDocument($Domdoc) 
    }  #end while

# Save/Export routine    
    $SaveAs1.Filter = "CSV Files (*.csv)|*.csv|Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
    $SaveAs1.SupportMultiDottedExtensions = $true;
    $SaveAs1.InitialDirectory = "C:\temp\"
    $SaveAs1.title="Save\Export All Company EMail addresses"
# This is where the actual save takes place!

if($SaveAs1.ShowDialog() -eq 'Ok'){
$mailist | sort | Out-File $($SaveAs1.filename)
}

}
Get-AllDominoEmailAddresses