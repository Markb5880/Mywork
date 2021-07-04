#Search-ADAccount -LockedOut -UsersOnly | FT Name,ObjectClass -A

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function get-lockoutlist {
#    [CmdletBinding()]Param()
#    [ParameterName]$computername
    try{
#    $computername=
    $e=$events.Count

    getevtproperties
    }
    catch {
    if ($e -lt 1){ $Textbox3.Text=" No Locked Accounts Found ! " }
    }
}


function getevtproperties {

    foreach ($event in $events){
    
    $username=$event.Properties[0].value
    $CallingPC=$event.Properties[1].Value
    $DC_That_Picked_Up_Lockout=$event.Properties[4].Value
    $OurDomain=$event.Properties[5].Value
    $timecreated=$event.timecreated

    $info=@"
    Lockedout User : $username
    Lockedout on PC: $CallingPC
    Reported from  : $DC_That_Picked_Up_Lockout
    Which Domain   : $OurDomain
    Time Created   : $timecreated     
"@
    $textbox3.Text=$info

Start-Sleep 10
  
  }

  }

      
Function Get-ADLockout {
Clear-Host

	$form = New-Object system.Windows.Forms.Form
    $form.topmost=$true	
    $Form.Text = "AD Account Lockout"
    $Form.size=New-Object System.Drawing.Size(400,400)

#Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(400,400)
    $Form.MinimumSize=New-Object System.Drawing.Size(400,400)
	$Font = New-Object System.Drawing.Font("Courier",12,[System.Drawing.FontStyle]::regular)
	$Form.Font = $Font

# ComboBox at top of Form
	$ComboBox1 = New-Object System.Windows.Forms.Combobox
	$ComboBox1.Location = New-Object System.Drawing.Size(4,4)
	$ComboBox1.Size = New-Object System.Drawing.Size(120,32)

# Textbox - Middle 
    $TextBox3 = New-Object System.Windows.Forms.TextBox 
    $TextBox3.Multiline = $true;
    $TextBox3.Location = New-Object System.Drawing.Size(4,48) 
    $TextBox3.Size = New-Object System.Drawing.Size(376,150)
    $Font = New-Object System.Drawing.Font("Tahoma",12,[System.Drawing.FontStyle]::regular)
    $TextBox3.Font=$Font

# Computer Hashtable
$computername=@{
    DC1='SVUKDC01'
    DC2='SVUKDC02'
    DC3='SVUKDC03'
    }
    $events=@()
# Read Computers from Hashtable above
    foreach ($computer in $computername.Values)
     {
     [void]$combobox1.Items.Add($computer)
     }
# Set Default DropDown Entry
$combobox1_SelectedIndexChanged={
    $z=""
    $events=""
    $events=Get-WinEvent -ComputerName  $combobox1.SelectedItem -FilterHashtable @{logname="Security";id=4740;starttime=(Get-date).adddays(-1)} -Credential f1\administrator -ErrorAction silentlycontinue -ErrorVariable z

get-lockoutlist
    }

    $combobox1.SelectedIndex=2
    $combobox1.add_SelectedIndexChanged($combobox1_SelectedIndexChanged)
    $form.controls.add($combobox1)
    $form.controls.add($Textbox3)

    $Button1 = New-Object System.Windows.Forms.Button
	$Button1.Location = New-Object System.Drawing.Size(3,245)
	$Button1.Size = New-Object System.Drawing.Size(80,50)
	$Button1.Text = "Exit"
    $Button1.Add_Click({$form.close();$form.Dispose()})
    $textbox3.Text=$info

    $form.controls.add($Button1)
    $form.ShowDialog()

    }
Get-ADLockout
