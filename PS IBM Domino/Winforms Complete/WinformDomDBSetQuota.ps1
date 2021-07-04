Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function WFDomDBSetQuota {
cls
    
    # Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="Set Database Quota."
    $form.Location.X=25
    $form.Location.Y=75
    $form.Size=New-Object System.Drawing.Size(370,300)
#Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(370,300)
    $Form.MinimumSize=New-Object System.Drawing.Size(370,300)
    #$form.backcolor="lightblue"
    #$form.forecolor="red"
# Display an Image on a form
    $image = [System.Drawing.Image]::Fromfile('C:\Users\administrator\downloads\lotus-notes-icon.png')     
    $pictureBox = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
    $pictureBox.Image=$image
    $pictureBox.Location = New-object System.Drawing.Size(40,0)
    $pictureBox.Width =  $image.Size.Width
    $pictureBox.Height =  $image.Size.Height
    $pictureBox.Image = $image
    #$pictureBox.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom
    
# Draw Chosen Database Text Label
    $textlbl1=New-Object System.Windows.Forms.label
    $textlbl1.Location=New-Object System.Drawing.Size(2,15)
    $textlbl1.backcolor="Transparent"
    $textlbl1.size=New-Object System.Drawing.Size(118,18)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="Chosen Database:"
# Draw NewQuotaSize Text Label
    $textlbl2=New-Object System.Windows.Forms.label
    $textlbl2.Location=New-Object System.Drawing.Size(2,48)
    $textlbl2.BackColor = [System.Drawing.Color]::FromName("Transparent")
    $textlbl2.size=New-Object System.Drawing.Size(116,18)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl2.Font=$FontFace
    $textlbl2.text="New Quota Size:"
# Draw NewQuotaWarningSize Text Label
    $textlbl3=New-Object System.Windows.Forms.label
    $textlbl3.Location=New-Object System.Drawing.Size(2,80)
    $picturebox.BackColor = "Transparent"
    $textlbl3.size=New-Object System.Drawing.Size(190,18)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl3.Font=$FontFace
    $textlbl3.text="New Quota Warning Size:"
# Draw MB Text Label
    $textlbl4=New-Object System.Windows.Forms.label
    $textlbl4.Location=New-Object System.Drawing.Size(240,80)
    $textlbl4.backcolor="Transparent"
    $textlbl4.size=New-Object System.Drawing.Size(118,18)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl4.Font=$FontFace
    $textlbl4.text="MB"
# Draw MB Text Label
    $textlbl5=New-Object System.Windows.Forms.label
    $textlbl5.Location=New-Object System.Drawing.Size(240,48)
    $textlbl5.backcolor="Transparent"
    $textlbl5.size=New-Object System.Drawing.Size(116,18)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl5.Font=$FontFace
    $textlbl5.text="MB"
# Draw Chosen Database Textbox
    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(172,11)
    $textbox1.size=New-Object System.Drawing.Size(140,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace
    $ToolTxtBx1 = New-Object System.Windows.Forms.ToolTip
    $ToolTxtBx1.SetToolTip($textbox1,"[Path]\[Database.Nsf]")
# Draw NewQuotaSize Textbox
    $textbox2=New-Object System.Windows.Forms.textbox
    $textbox2.Location=New-Object System.Drawing.Size(172,45)
    $textbox2.size=New-Object System.Drawing.Size(60,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox2.Font=$FontFace
    $ToolTxtBx2 = New-Object System.Windows.Forms.ToolTip
    $ToolTxtBx2.SetToolTip($textbox2,"A Numeric Value only is allowed.")
# Draw NewQuotaWarningSize Textbox
    $textbox3=New-Object System.Windows.Forms.textbox
    $textbox3.Location=New-Object System.Drawing.Size(172,75)
    $textbox3.size=New-Object System.Drawing.Size(60,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox3.Font=$FontFace
    $ToolTxtBx3 = New-Object System.Windows.Forms.ToolTip
    $ToolTxtBx3.SetToolTip($textbox3,"A Numeric Value only is allowed.")
# Add an 'Change Database Size' Button    
    $ChangeDBSizebutton=New-Object System.Windows.Forms.Button
    $ChangeDBSizebutton.Location = New-Object System.Drawing.Size(170,170)
    $ChangeDBSizebutton.Size = New-Object System.Drawing.Size(60,40)
    $ChangeDBSizebutton.Text = "Set DB Quotas"
    $ChangeDBSizebutton.forecolor = "Green"
    $ChangeDBSizebutton.add_click({$NotesDB=$textbox1.Text;$Sizequota=$textbox2.Text;$SizeWarning=$textbox3.text;
    & "C:\Users\administrator\Documents\Domino Powershell\complete\PS-DomDBSetQuota.ps1";$textbox1.Clear();$textbox2.Clear();$textbox3.Clear();
        })
    $Form.Controls.Add($ChangeDBSizebutton)
    
# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(255,170)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,40)
    $Exitbutton.Text = "Exit"
    $Exitbutton.forecolor = "Red"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)
    $form.Controls.Add($textbox1)
    $form.Controls.Add($textbox2)
    $form.Controls.Add($textbox3)
    $form.Controls.Add($textbox4)
    $form.Controls.Add($textlbl1)
    $form.Controls.Add($textlbl2)
    $form.Controls.Add($textlbl3)
    $form.Controls.Add($textlbl4)
    $form.Controls.Add($textlbl5)
    $form.Controls.Add($pictureBox)
    $form.ShowDialog()
    }
 WFDomDBSetQuota