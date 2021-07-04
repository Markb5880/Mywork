<#
.SYNOPSIS
 This is a user group membership routine
.EXAMPLE
 AD_Usergrps
.DESCRIPTION
 Displays a Form where you can select a user via the 'samaccountname' the relevant User DisplayName is also shown.
 The groups that the chosen member is part of will be listed.
 Other info shown is the Domain name and also the total amount of users except machine management accounts. 
.NOTES
 Updated and finshed off on the 29th March 2021 By Mark Baker
#>

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing.graphics")

#Get-ADPrincipalGroupMembership mbaker | select name
Function AD_Usergrps {
$dd=$null

cls
# Main Form Size
	$script:Form = New-Object system.Windows.Forms.Form
    $form.topmost=$true	
    $Form.Text = "User Group Info"
    $Form.size=New-Object System.Drawing.Size(420,385)

#Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(420,385)
    $Form.MinimumSize=New-Object System.Drawing.Size(420,385)
	$Font = New-Object System.Drawing.Font("Courier",10,[System.Drawing.FontStyle]::regular)
	$Form.Font = $Font

# Domain Textbox - top left
    $TextBox6 = New-Object System.Windows.Forms.TextBox 
    $TextBox6.Multiline = $false;
    $TextBox6.Location = New-Object System.Drawing.Size(190,5) 
    $TextBox6.Size = New-Object System.Drawing.Size(195,72)
    $Font = New-Object System.Drawing.Font("Tahoma",8,[System.Drawing.FontStyle]::regular)
    $TextBox6.Font=$Font
    $gdm=get-addomain | select dnsroot
    $gdm1=$gdm.dnsroot.tostring()
        
    $body1 = @"
    Current Domain:
    $gdm1
"@
    $Textbox6.text=$body1

# Scrollable User Selection Textbox - Mid Right
    $TextBox2 = New-Object System.Windows.Forms.Listbox 
    $TextBox2.Location = New-Object System.Drawing.Size(10,40) 
    $TextBox2.Size = New-Object System.Drawing.Size(320,120)
    $TextBox2.Height = 90

# Scrollable Group Output Textbox - Bottom
    $TextBox3 = New-Object System.Windows.Forms.textbox
    $textbox3.multiline=$true
    $textbox3.AutoSize=$false
    $textbox3.scrollbars='vertical'
    $TextBox3.Location = New-Object System.Drawing.Size(10,180) 
    $TextBox3.Size = New-Object System.Drawing.Size(320,120)
    $TextBox3.Height = 112

# Draw Chosen Database Text Label
    $textlbl1=New-Object System.Windows.Forms.label
    $textlbl1.Location=New-Object System.Drawing.Size(5,139)
    $textlbl1.backcolor="Transparent"
    $textlbl1.size=New-Object System.Drawing.Size(72,18)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="Username:"
    $Form.Controls.Add($textlbl1)
# Draw Chosen Database Textbox
    $textbox1a=New-Object System.Windows.Forms.textbox
    $textbox1a.Location=New-Object System.Drawing.Size(81,136)
    $textbox1a.size=New-Object System.Drawing.Size(250,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1a.Font=$FontFace
 
    $dname =@()
# Load the items and sort the list in Ascending order.
    $usr=Get-ADUser -filter * -SearchBase "OU=F1,OU=TS Tech Users,DC=SMALLHOME,DC=LOCAL" | where {$_.enabled -eq $true } | select samaccountname,name |sort samaccountname
    $usr.samaccountname | ForEach-Object {[void]$Textbox2.Items.Add($_);$dname=$usr.name}
# Current AD User Count
    $TextBox5 = New-Object System.Windows.Forms.TextBox 
    $TextBox5.Location = New-Object System.Drawing.Size(5,5) 
    $TextBox5.Size = New-Object System.Drawing.Size(170,64)
    $Font = New-Object System.Drawing.Font("Tahoma",8,[System.Drawing.FontStyle]::regular)
    $TextBox5.Font=$Font
    $usrcnt=$Textbox2.items.Count

    $body5 = @"
    Current AD User Count:
    $usrcnt
"@
    $Textbox5.text=$body5
    $Form.Controls.Add($Textbox5)
    $form.controls.add($Textbox2) 
    $form.controls.add($Textbox3)
    $form.controls.add($Textbox6)

   $Textbox2.add_click({$selection = $Textbox2.Selecteditem#;$Form.Controls.Clear($textbox1a)
    $adp=Get-ADPrincipalGroupMembership -Identity $selection | sort name
    $c=$adp.name # used for data line count
    
# Display the 'users' groups, but we need to take care of the additional
# new line at the end of the list.
    $lines=$c.count-1
    $textbox3.Clear()

    foreach($gp in $adp){
        $textbox3.appendtext($gp.samaccountname)
            if ($lines -gt 0){
            $textbox3.AppendText("`r`n")
        $lines=$lines-1
        }
    }
    $zz=$dname[$textbox2.SelectedIndex]
    $textbox1a.Text="$zz"
    
    $textbox3.Refresh()
    $Form.Controls.Add($textbox1a)
    
    })
# Exit Button    
    $Exitgbutton=New-Object System.Windows.Forms.Button
    $Exitgbutton.Location = New-Object System.Drawing.Size(295,300)
    $Exitgbutton.Size = New-Object System.Drawing.Size(100,32)
    $Exitgbutton.Text = "Exit"
    $Exitgbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitgbutton)
 
    $form.showdialog()

}
AD_Usergrps

