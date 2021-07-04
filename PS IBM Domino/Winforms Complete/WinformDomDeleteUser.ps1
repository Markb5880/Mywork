Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function WFDomDeleteUser {
cls

# Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="Delete Domino User."
    $form.Location.X=25
    $form.Location.Y=75
    $form.Size=New-Object System.Drawing.Size(300,300)
# Display an Image on a form
    $image = [System.Drawing.Image]::Fromfile('C:\Users\administrator\downloads\lotus-notes-icon.png')     
    $pictureBox = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
    $pictureBox.Image=$image
    $pictureBox.Location = New-object System.Drawing.Size(0,0)
    $pictureBox.Width =  $image.Size.Width
    $pictureBox.Height =  $image.Size.Height
    $pictureBox.Image = $image

# Draw User To Delete Text Label
    $textlbl1=New-Object System.Windows.Forms.label
    $textlbl1.Location=New-Object System.Drawing.Size(2,5)
    $textlbl1.backcolor="Transparent"
    $textlbl1.size=New-Object System.Drawing.Size(118,18)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="User To Delete:"
# Draw a Textbox
    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(45,35)
    $textbox1.size=New-Object System.Drawing.Size(200,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace
    $ToolTxtBx1 = New-Object System.Windows.Forms.ToolTip
    $ToolTxtBx1.SetToolTip($textbox1,"Enter [FirstName][Space][LastName]")
# Draw a Checkbox
    $checkbox1 = new-object System.Windows.Forms.checkbox
    $checkbox1.Location = new-object System.Drawing.Size(22,120)
    $checkbox1.Size = new-object System.Drawing.Size(20,40)
    $checkbox1.Text = "Check this box to Delete Mailfile"
    $checkbox1.Checked = $false
    $form.Controls.Add($checkbox1) 
# Draw Checkbox Text Label
    $textlbl2=New-Object System.Windows.Forms.label
    $textlbl2.Location=New-Object System.Drawing.Size(40,130)
    $textlbl2.backcolor="Transparent"
    $textlbl2.size=New-Object System.Drawing.Size(158,18)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl2.Font=$FontFace
    $textlbl2.text="Tick To Delete Mailfile:"

$label = New-Object System.Windows.Forms.Label
$label.Text = "User Deletion in Progress. *** PLEASE WAIT!! ***"
$label.Location=New-Object System.Drawing.Size(2,210)
    $label.size=New-Object System.Drawing.Size(296,64)
    $label.forecolor="red"
    $label.backcolor="black"
    $label.Visible=$false
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",12,[System.Drawing.FontStyle]::Bold)
    $label.Font=$FontFace
$form.Controls.Add($label)

# Add an 'Delete User' Button    
    $DeleteUserbutton=New-Object System.Windows.Forms.Button
    $DeleteUserbutton.Location = New-Object System.Drawing.Size(75,75)
    $DeleteUserbutton.Size = New-Object System.Drawing.Size(50,40)
    $DeleteUserbutton.Text = "Delete User"
    $DeleteUserbutton.forecolor = "Green"
    $DeleteUserbutton.add_click({$User=$textbox1.Text;if ($checkbox1.Checked){[int]$MailFileDelete=1}else{[int]$MailFileDelete=0};
    & "C:\Users\administrator\Documents\Domino Powershell\Complete\PS-DomDeleteUser.ps1";$textbox1.Clear();$label.Visible=$false
        })
    $Form.Controls.Add($DeleteUserbutton)
    
# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(150,75)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,40)
    $Exitbutton.Text = "Exit"
    $Exitbutton.forecolor = "Red"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)
    $form.controls.add($textlbl1)
    $form.controls.add($textlbl2)
    $form.Controls.Add($textbox1)
    $Form.Controls.Add($picturebox)
    $form.ShowDialog()
    }
 WFDomDeleteUser