Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function WFDomRenameGroup {
cls

# Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="Rename Single Domino Group."
    $form.Location.X=25
    $form.Location.Y=75
    $form.Size=New-Object System.Drawing.Size(350,300)
#Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(350,300)
    $Form.MinimumSize=New-Object System.Drawing.Size(350,300)
# Display an Image on a form
    $image = [System.Drawing.Image]::Fromfile('C:\Users\administrator\Downloads\lotus-notes-icon.png')     
    $pictureBox = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
    $pictureBox.Image=$image
    $pictureBox.Location = New-object System.Drawing.Size(0,0)
    $pictureBox.Width =  $image.Size.Width
    $pictureBox.Height =  $image.Size.Height
    $pictureBox.Image = $image
    $pictureBox.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom
    
# Draw Existing GroupName Text Label
    $textlbl1=New-Object System.Windows.Forms.label
    $textlbl1.Location=New-Object System.Drawing.Size(5,15)
    $textlbl1.size=New-Object System.Drawing.Size(142,22)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="Existing Group Name:"

# Draw New GroupName Text Label
    $textlbl2=New-Object System.Windows.Forms.label
    $textlbl2.Location=New-Object System.Drawing.Size(5,48)
    $textlbl2.size=New-Object System.Drawing.Size(120,22)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl2.Font=$FontFace
    $textlbl2.text="New Group Name:"

# Draw Current GroupName Textbox
    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(150,12)
    $textbox1.size=New-Object System.Drawing.Size(72,96)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace

# Draw New GroupName Textbox
    $textbox2=New-Object System.Windows.Forms.textbox
    $textbox2.Location=New-Object System.Drawing.Size(150,45)
    $textbox2.size=New-Object System.Drawing.Size(160,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox2.Font=$FontFace

# Add a 'Rename Group' Button    
    $RenameGroupbutton=New-Object System.Windows.Forms.Button
    $RenameGroupbutton.Location = New-Object System.Drawing.Size(162,125)
    $RenameGroupbutton.Size = New-Object System.Drawing.Size(60,54)
    $RenameGroupbutton.Text = "Rename Group"
    $RenameGroupbutton.forecolor="Green"
    $RenameGroupbutton.add_click({$CurrentGroup=$textbox1.Text;$NewGroup=$textbox2.Text
    & "C:\Users\administrator\Documents\Domino Powershell\Complete\PS-DomRenameGroup.ps1";$textbox1.Clear();$textbox2.clear()
        })

    $Form.Controls.Add($RenameGroupbutton)
    
# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(235,125)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,40)
    $Exitbutton.Text = "Exit"
    $Exitbutton.forecolor="Red"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)
    $form.Controls.Add($textbox1)
    $form.Controls.Add($textbox2)
    $form.Controls.Add($textlbl1)
    $form.Controls.Add($textlbl2)
    $Form.Controls.Add($picturebox)
    $form.ShowDialog()
    }
 WFDomRenameGroup