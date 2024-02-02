# Add relevant Assemblies

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing.graphics")
$global:pcmac
Function MakeNewForm {
	
    $Form.Close()
	$Form.Dispose()
	MakeForm
}
<# This function pings a selected MC from the drop down list and notifies you with either the
    No response message or the bios details of the remote MC.
#>
Function testping {
try {
    Test-Connection $selection "localhost" -count 1 -ErrorAction stop
    bios
    
    }
catch {
$Form.Controls.remove($TextBox4)
    $dd=$Error[0].CategoryInfo.Category.ToString()
    if ($dd="ResourceUnavailable"){
    $script:TextBox4 = New-Object System.Windows.Forms.TextBox 
    $TextBox4.Location = New-Object System.Drawing.Size(3,50) 
    $TextBox4.Size = New-Object System.Drawing.Size(210,64)
    $Font = New-Object System.Drawing.Font("Tahoma",8,[System.Drawing.FontStyle]::regular)
    $TextBox4.Font=$Font

    $mu=$selection.tostring() 
    #start-sleep 3    
    $body3 = @"
    No Response from:
    $mu
"@
    $Textbox4.text=$body3
    $Form.Controls.add($TextBox4)
    $form.Controls.Add($TextBox1.clear())
    $Form.Controls.remove($TextBox6)
    $result=-1
    
    return $result
   
    }

    }

}
# This function gets called by Testping above and then collects Bios info from remote computer.
Function Bios {
    $dd=$null
try {
    $Tempbios=get-wmiobject win32_bios -ComputerName $selection -ErrorAction stop
    $result=0
    biossuccess
    }
catch {
$Form.Controls.remove($TextBox4)
    $dd=$Error[0].CategoryInfo.Category.ToString()
    if ($dd="InvalidOperation") {
    $TextBox4 = New-Object System.Windows.Forms.textbox 
    $TextBox4.Location = New-Object System.Drawing.Size(3,50) 
    $TextBox4.Size = New-Object System.Drawing.Size(210,64)
    $Font = New-Object System.Drawing.Font("Tahoma",8,[System.Drawing.FontStyle]::regular)
    $TextBox4.Font=$Font
    $Form.Controls.remove($TextBox4)

    $form.update()
    $mu=$selection.tostring() 
        
    $body3 = @"
    No Response from:
    $mu
"@
    $Textbox4.text=$body3
    
    $Form.Controls.add($TextBox4)
    $form.Controls.Add($TextBox1.clear())
    $Form.Controls.remove($TextBox6)
    $result=-1
  
    $dd=$null
    return $result
   }
$Form.Controls.remove($TextBox4)
}
}
<# This function gets called if there is no error on the Bios function above (TestPing Function)
   Would have aleady indicated MC is online and contactable.
#>
function biossuccess {        
    $tm=$Tempbios.Manufacturer.tostring()
    $tn=$Tempbios.Name.tostring()
    $tsn=$Tempbios.SerialNumber.tostring()
    $tvn=$Tempbios.Version.tostring()

    $body = @"
    Manufacturer: $tm
    Name: $tn
    Serial number: $tsn
    Version: $tvn
"@
    $textbox1.text=$body
    $Form.Controls.Add($TextBox1)
    $Form.Controls.remove($TextBox4)
    $form.Update()
    $result=0
    $dd=$null
    RETURN $result

}
function PC_Mac {   
# Current PC Mac Address
    $Form.Controls.remove($TextBox6)

    $script:TextBox6 = New-Object System.Windows.Forms.TextBox 
    $TextBox6.Multiline = $true;
    $TextBox6.Location = New-Object System.Drawing.Size(3,71) 
    $TextBox6.Size = New-Object System.Drawing.Size(192,32)
    $Font = New-Object System.Drawing.Font("Tahoma",8,[System.Drawing.FontStyle]::regular)
    $TextBox6.Font=$Font

    $mac=WmiObject win32_networkadapterconfiguration -Filter 'ipenabled = "true"' -ComputerName $selection
    $pcmac=$mac.macaddress
    $body6 = @"
    Current PC Mac Address:
    $pcmac
"@
    $Textbox6.text=$body6
    $form.Controls.Add($TextBox6)
    $Form.Controls.add($TextBox4.Clear())
    $Form.Controls.remove($TextBox4)
    $result=0
    $dd=$null

    return $result
    }

Function MakeForm {
$dd=$null

cls
# Main Form Size
	$script:Form = New-Object system.Windows.Forms.Form
    $form.topmost=$true	
    $Form.Text = "Local Bios Info"
    $Form.size=New-Object System.Drawing.Size(420,385)

#Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(420,385)
    $Form.MinimumSize=New-Object System.Drawing.Size(420,385)
	$Font = New-Object System.Drawing.Font("Courier",12,[System.Drawing.FontStyle]::regular)
	$Form.Font = $Font

# Textbox at bottom of Form
	$script:TextBox1 = New-Object System.Windows.Forms.Textbox
	$TextBox1.Location = New-Object System.Drawing.Size(4,250)
	$TextBox1.Size = New-Object System.Drawing.Size(395,87)
    $TextBox1.Multiline=$True
    $TextBox1.Autosize=$False

# Domain Textbox - top left
    $TextBox3 = New-Object System.Windows.Forms.TextBox 
    $TextBox3.Multiline = $false;
    $TextBox3.Location = New-Object System.Drawing.Size(3,5) 
    $TextBox3.Size = New-Object System.Drawing.Size(210,72)
    $Font = New-Object System.Drawing.Font("Tahoma",8,[System.Drawing.FontStyle]::regular)
    $TextBox3.Font=$Font
    $gdm=get-addomain | select dnsroot
    $gdm1=$gdm.dnsroot.tostring()
        
    $body1 = @"
    Current Domain:
    $gdm1
"@
    $Textbox3.text=$body1

# Exit Buttons left side of Form
    $Button1 = New-Object System.Windows.Forms.Button
	$Button1.Location = New-Object System.Drawing.Size(3,195)
	$Button1.Size = New-Object System.Drawing.Size(80,50)
	$Button1.Text = "Exit"
	$Button1.Add_Click({$form.close()})

# Scrollable Textbox - Mid Right
    $TextBox2 = New-Object System.Windows.Forms.Listbox 
    $TextBox2.Location = New-Object System.Drawing.Size(200,80) 
    $TextBox2.Size = New-Object System.Drawing.Size(180,200)
    $TextBox2.Height = 180
# Load the items and sort the list in Ascending order.
    $computers=get-adcomputer -filter * -properties name -SearchBase "cn=Computers,DC=smallhome,DC=local" | where {$_.enabled -eq $true } | select name |sort name
    $computers.name | ForEach-Object {[void]$Textbox2.Items.Add($_)}

# Current PC Count
    $TextBox5 = New-Object System.Windows.Forms.TextBox 
    $TextBox5.Multiline = $false;
    $TextBox5.Location = New-Object System.Drawing.Size(3,28) 
    $TextBox5.Size = New-Object System.Drawing.Size(210,72)
    $Font = New-Object System.Drawing.Font("Tahoma",8,[System.Drawing.FontStyle]::regular)
    $TextBox5.Font=$Font
    $pccount=$Textbox2.items.Count

    $body5 = @"
    Current PC Count:
    $pccount
"@
    $Textbox5.text=$body5

# Display an Image on a form
    $image = [System.Drawing.Image]::Fromfile("C:\\Users\\administrator\\Pictures\\Screenshots\\adlogo.jpg",$true)     
    $pictureBox = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
    $pictureBox.Image=$image
    $pictureBox.Location = New-object System.Drawing.Size(220,5)
    $pictureBox.Width =  $image.Size.Width/2
    $pictureBox.Height =  $image.Size.Height/3
    $pictureBox.Image = $image
    $pictureBox.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom
    
#Select Computer from Listbox
#Ping Computer: See Function info at the top of this source code listing

    $Textbox2.add_click({$selection = $Textbox2.Selecteditem
    
    testping
    $result=(testping)[-1]
    if ($result -eq 0){
    pc_mac
    }
    })

# Add the controls to the form

    $form.controls.add($pictureBox)
	$Form.Controls.Add($TextBox1)
    $Form.Controls.Add($Button1)
	$Form.Controls.Add($Button2)
	$Form.Controls.Add($TextBox2)
    $Form.Controls.Add($TextBox3)
    $Form.Controls.Add($TextBox5)
    #$Form.Controls.Add($TextBox6)
    # $form.show()
    $form.showdialog()

# Now call the function
}
Makeform
