Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing.graphics")
$Global:Form

function TabFormTest {
cls

# Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="This is my test text form."
    $form.Location.X=2048
    $form.Location.Y=1024
    $form.Size=New-Object System.Drawing.Size(483,370)
  
    # TabControl Setup
    $tabcontrol=New-Object System.Windows.Forms.tabcontrol
    $tabcontrol.width=440
    $tabcontrol.height=325
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $tabcontrol.Font=$FontFace

    # Draw a Textbox
    $tabpage1=New-Object System.Windows.Forms.tabpage
    $tabpage1.name="Tab1"
    $tabpage1.Text="User Group Viewer"
    $Tabpage1.backcolor="Green"
    $tabpage1.width=480
    $tabpage1.height=480

    $dd=$null
    
    cls
    
    # Domain Textbox - top right
        $TextBox6 = New-Object System.Windows.Forms.TextBox 
        $TextBox6.Multiline = $false;
        $TextBox6.Location = New-Object System.Drawing.Size(180,5) 
        $TextBox6.Size = New-Object System.Drawing.Size(210,16)
        $Font = New-Object System.Drawing.Font("Tahoma",10,[System.Drawing.FontStyle]::regular)
        $TextBox6.Font=$Font
        $gdm=get-addomain | select dnsroot
        $gdm1=$gdm.dnsroot.tostring()
            
        $body1 = @"
Current Domain: $gdm1
"@
        $Textbox6.text=$body1

    # Scrollable User Selection Textbox - Mid Right
        $TextBox2 = New-Object System.Windows.Forms.Listbox 
        $TextBox2.Location = New-Object System.Drawing.Size(5,40) 
        $TextBox2.Size = New-Object System.Drawing.Size(170,120)
        $TextBox2.Height = 90
    
    # Scrollable Group Output Textbox - Bottom
        $TextBox3 = New-Object System.Windows.Forms.textbox
        $textbox3.multiline=$true
        $textbox3.AutoSize=$false
        $textbox3.scrollbars='vertical'
        $TextBox3.Location = New-Object System.Drawing.Size(5,150) 
        $TextBox3.Size = New-Object System.Drawing.Size(320,112)
        
    # Draw Chosen Username Text Label
        $textlbl1=New-Object System.Windows.Forms.label
        $textlbl1.Location=New-Object System.Drawing.Size(180,37)
        $textlbl1.backcolor="Transparent"
        $textlbl1.size=New-Object System.Drawing.Size(72,18)
        $FontFace = New-Object System.Drawing.Font(
        "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
        $textlbl1.Font=$FontFace
        $textlbl1.text="Username:"

     # Draw Chosen 'Group Membership' Text Label
         $textlbl2=New-Object System.Windows.Forms.label
         $textlbl2.Location=New-Object System.Drawing.Size(5,130)
         $textlbl2.backcolor="Transparent"
         $textlbl2.size=New-Object System.Drawing.Size(144,18)
         $FontFace = New-Object System.Drawing.Font(
         "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
         $textlbl2.Font=$FontFace
         $textlbl2.text="Group Membership:"
        
    # Draw Username Textbox
        $textbox1a=New-Object System.Windows.Forms.textbox
        $textbox1a.Location=New-Object System.Drawing.Size(180,56)
        $textbox1a.size=New-Object System.Drawing.Size(210,64)
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
        $Font = New-Object System.Drawing.Font("Tahoma",10,[System.Drawing.FontStyle]::regular)
        $TextBox5.Font=$Font
        $usrcnt=$Textbox2.items.Count
    
        $body5 = @"
Current AD User Count: $usrcnt
"@
        $Textbox5.text=$body5
            
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
            
        })
          
    #}
    $tabpage1.Controls.Add($textbox6)
    $tabpage1.Controls.Add($textbox2)
    $tabpage1.Controls.Add($textbox3)
    $tabpage1.Controls.Add($textlbl1)
    $tabpage1.Controls.Add($textbox1a)
    $tabpage1.Controls.Add($textbox5)
    $tabpage1.controls.add($textlbl2)

    $tabpage2=New-Object System.Windows.Forms.tabpage
    $tabpage2.name="Tab2"
    $tabpage2.Text="Tab2"
    $tabpage2.width=3
    $tabpage2.height=5
    $tabcontrol.tabpages.add($tabpage1)
    $tabcontrol.tabpages.add($tabpage2)

    $textlbl2=New-Object System.Windows.Forms.label
    $textlbl2.Location=New-Object System.Drawing.Size(220,150)
    #$textlbl1.backcolor="Transparent"
    $textlbl2.size=New-Object System.Drawing.Size(500,650)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",12,[System.Drawing.FontStyle]::Regular)
    $textlbl2.Font=$FontFace
    $textlbl2.text="WORLD"

    $tabpage2.Controls.Add($textlbl2)
# Add an 'EXIT' Button
      
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(350,200)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,75)
    $Exitbutton.Backcolor = "LightGreen"

    $Exitbutton.Forecolor = "purple"
    $Exitbutton.Text = "Exit"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)
    $form.Controls.Add($tabcontrol)

    $form.ShowDialog()
}
TabFormTest
