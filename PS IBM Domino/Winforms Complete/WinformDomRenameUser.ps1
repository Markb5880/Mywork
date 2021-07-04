Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function WFDomRenameUser {
cls
    
    # Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="Rename Domino User."
    $form.Location.X=25
    $form.Location.Y=75
    $form.Size=New-Object System.Drawing.Size(400,300)
#Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(400,300)
    $Form.MinimumSize=New-Object System.Drawing.Size(400,300)
# Display an Image on a form
    $image = [System.Drawing.Image]::Fromfile('C:\Users\administrator\Downloads\lotus-notes-icon.png')     
    $pictureBox = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
    $pictureBox.Image=$image
    $pictureBox.Location = New-object System.Drawing.Size(0,0)
    $pictureBox.Width =  $image.Size.Width
    $pictureBox.Height =  $image.Size.Height
    $pictureBox.Image = $image
    $pictureBox.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom
    
# Draw OldUserName Text Label
    $textlbl1=New-Object System.Windows.Forms.label
    $textlbl1.Location=New-Object System.Drawing.Size(2,15)
    $textlbl1.backcolor="Transparent"
    $textlbl1.size=New-Object System.Drawing.Size(112,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="User to Rename:"
# Draw NewlastName Text Label
    $textlbl2=New-Object System.Windows.Forms.label
    $textlbl2.Location=New-Object System.Drawing.Size(2,45)
    $textlbl2.backcolor="Transparent"
    $textlbl2.size=New-Object System.Drawing.Size(107,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl2.Font=$FontFace
    $textlbl2.text="New LastName:"
# Draw NewfirstName Text Label
    $textlbl3=New-Object System.Windows.Forms.label
    $textlbl3.Location=New-Object System.Drawing.Size(2,75)
    $textlbl3.backcolor="Transparent"
    $textlbl3.size=New-Object System.Drawing.Size(107,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl3.Font=$FontFace
    $textlbl3.text="New Firstname:"
# Draw NewmiddleName Text Label
    $textlbl4=New-Object System.Windows.Forms.label
    $textlbl4.Location=New-Object System.Drawing.Size(2,105)
    $textlbl4.backcolor="Transparent"
    $textlbl4.size=New-Object System.Drawing.Size(130,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl4.Font=$FontFace
    $textlbl4.text="New MiddleName:"
# Draw OldUsername Textbox
    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(122,11)
    $textbox1.size=New-Object System.Drawing.Size(140,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace
    $ToolTxtBx1 = New-Object System.Windows.Forms.ToolTip
    $ToolTxtBx1.SetToolTip($textbox1,"Enter [FirstName][Space][LastName]")
# Draw Newlastname Textbox
    $textbox2=New-Object System.Windows.Forms.textbox
    $textbox2.Location=New-Object System.Drawing.Size(122,45)
    $textbox2.size=New-Object System.Drawing.Size(140,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox2.Font=$FontFace
# Draw Newfirstname Textbox
    $textbox3=New-Object System.Windows.Forms.textbox
    $textbox3.Location=New-Object System.Drawing.Size(122,75)
    $textbox3.size=New-Object System.Drawing.Size(140,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox3.Font=$FontFace
# Draw Newmiddlename Textbox
    $textbox4=New-Object System.Windows.Forms.textbox
    $textbox4.Location=New-Object System.Drawing.Size(122,105)
    $textbox4.size=New-Object System.Drawing.Size(140,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox4.Font=$FontFace
# Textbox Defaults For Oldusername,Newlastname,Newfirstname,Newmiddlename
    $textbox1.text="*"
    $textbox2.text="*"
    $textbox3.text="*"
    $textbox4.text="*"
# Draw * Text Label
    $textlbl5=New-Object System.Windows.Forms.label
    $textlbl5.Location=New-Object System.Drawing.Size(270,33)
    $textlbl5.backcolor="Transparent"
    $textlbl5.size=New-Object System.Drawing.Size(112,80)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl5.Font=$FontFace
    $textlbl5.text="If there are to be no changes leave an * in the field."
# Add an 'Rename User' Button    
    $RenameUserbutton=New-Object System.Windows.Forms.Button
    $RenameUserbutton.Location = New-Object System.Drawing.Size(130,170)
    $RenameUserbutton.Size = New-Object System.Drawing.Size(60,40)
    $RenameUserbutton.Text = "Rename User"
    $RenameUserbutton.forecolor = "Green"
    $RenameUserbutton.add_click({$OldUsername=$textbox1.Text;$Newlastname=$textbox2.Text;$Newfirstname=$textbox3.Text;$Newmiddlename=$textbox4.Text;
    & "C:\Users\administrator\Documents\Domino Powershell\Complete\PS-DomRenameUser.ps1";$textbox1.text="*";$textbox2.text="*";$textbox3.text="*";$textbox4.text="*"
        })
    $Form.Controls.Add($RenameUserbutton)
    
# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(215,170)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,40)
    $Exitbutton.Text = "Exit"
    $Exitbutton.ForeColor="Red"
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
 WFDomRenameUser