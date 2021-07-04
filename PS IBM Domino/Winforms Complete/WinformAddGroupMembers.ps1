Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function WFDomRemoveGroup {
cls

# Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="Add Group Members."
    $form.Location.X=25
    $form.Location.Y=75
    $form.Size=New-Object System.Drawing.Size(460,300)
#Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(460,300)
    $Form.MinimumSize=New-Object System.Drawing.Size(460,300)
# Display an Image on a form
    $image = [System.Drawing.Image]::Fromfile('C:\Users\administrator\Downloads\lotus-notes-icon.png')     
    $pictureBox = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
    $pictureBox.Image=$image
    $pictureBox.Location = New-object System.Drawing.Size(65,0)
    $pictureBox.Width =  $image.Size.Width
    $pictureBox.Height =  $image.Size.Height
    $pictureBox.Image = $image
    $pictureBox.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom
    
# Draw Group Text Label
    $textlbl1=New-Object System.Windows.Forms.label
    $textlbl1.Location=New-Object System.Drawing.Size(5,15)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="Group Name:"

# Draw Members Text Label
    $textlbl2=New-Object System.Windows.Forms.label
    $textlbl2.Location=New-Object System.Drawing.Size(5,48)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl2.Font=$FontFace
    $textlbl2.text="Members:"
    
# Draw 2 Members Min Text Label
    $textlbl3=New-Object System.Windows.Forms.label
    $textlbl3.Location=New-Object System.Drawing.Size(4,240)
    $textlbl3.size=New-Object System.Drawing.Size(420,16)
    $textlbl3.BackColor="red"
    $textlbl3.foreColor="Transparent"
   
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",8,[System.Drawing.FontStyle]::Bold)
    $textlbl3.Font=$FontFace

    $textlbl3.text="** Please note you must enter at least 2 members separated by commas! **"

# Draw Group Textbox
    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(95,15)
    $textbox1.size=New-Object System.Drawing.Size(200,96)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace
    $ToolTxtBx1 = New-Object System.Windows.Forms.ToolTip
    $ToolTxtBx1.SetToolTip($textbox1,"Enter a New Group Name or an Existing Group name.")

# Draw Members Textbox
    $textbox2=New-Object System.Windows.Forms.textbox
    $textbox2.Location=New-Object System.Drawing.Size(95,45)
    $textbox2.size=New-Object System.Drawing.Size(200,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox2.Font=$FontFace
    $ToolTxtBx2 = New-Object System.Windows.Forms.ToolTip
    $ToolTxtBx2.SetToolTip($textbox2,"Use Username/Internal address format:<User>/<Domain>")

# Add a 'ADD Group Member' Button    
    $AddGroupMembersbutton=New-Object System.Windows.Forms.Button
    $AddGroupMembersbutton.Location = New-Object System.Drawing.Size(132,100)
    $AddGroupMembersbutton.Size = New-Object System.Drawing.Size(60,54)
    $AddGroupMembersbutton.Text = "Add Group Members"
    $AddGroupMembersbutton.forecolor ="Green"
    $AddGroupMembersbutton.add_click({$NewGroup=$textbox1.Text;$members=$textbox2.Text
    & "C:\Users\administrator\Documents\Domino Powershell\Complete\PS-AddGroupMembers.ps1";$textbox1.Clear();$textbox2.clear()
        })
    
    
# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(207,100)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,54)
    $Exitbutton.Text = "Exit"
    $Exitbutton.ForeColor="Red"
    $Exitbutton.add_click({$Form.Close()})
    
    $Form.Controls.Add($AddGroupMembersbutton)
    $Form.Controls.Add($Exitbutton)
    $form.Controls.Add($textbox1)
    $form.Controls.Add($textbox2)
    $form.Controls.Add($textlbl1)
    $form.Controls.Add($textlbl2)
    $form.Controls.Add($textlbl3)
    $Form.Controls.Add($picturebox)
    $form.ShowDialog()
    }
 WFDomRemoveGroup