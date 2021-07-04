Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function WFDomNewGroup {
cls

# Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="Create Domino Group."
    $form.Location.X=25
    $form.Location.Y=75
    $form.Size=New-Object System.Drawing.Size(300,300)
#Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(300,300)
    $Form.MinimumSize=New-Object System.Drawing.Size(300,300)
# Display an Image on a form
    $image = [System.Drawing.Image]::Fromfile('C:\Users\administrator\Downloads\lotus-notes-icon.png')     
    $pictureBox = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
    $pictureBox.Image=$image
    $pictureBox.Location = New-object System.Drawing.Size(0,0)
    $pictureBox.Width =  $image.Size.Width
    $pictureBox.Height =  $image.Size.Height
    $pictureBox.Image = $image
    $pictureBox.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom
    
# Draw Group Text Label
    $textlbl1=New-Object System.Windows.Forms.label
    $textlbl1.Location=New-Object System.Drawing.Size(5,15)
    $textlbl1.backcolor="Transparent"
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="Group Name:"
# Draw a Textbox
    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(95,11)
    $textbox1.size=New-Object System.Drawing.Size(180,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace

# Add a 'Create Group' Button    
    $CreateGroupbutton=New-Object System.Windows.Forms.Button
    $CreateGroupbutton.Location = New-Object System.Drawing.Size(110,50)
    $CreateGroupbutton.Size = New-Object System.Drawing.Size(60,40)
    $CreateGroupbutton.Text = "Create Group"
    $CreateGroupbutton.forecolor = "Green"
    $CreateGroupbutton.add_click({$NewGroup=$textbox1.Text;
    & "C:\Users\administrator\Documents\Domino Powershell\Complete\PS-DomNewGroup.ps1";$textbox1.Clear()
        })
    $Form.Controls.Add($CreateGroupbutton)
    
# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(205,50)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,40)
    $Exitbutton.Text = "Exit"
    $Exitbutton.ForeColor="Red"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)
    $form.Controls.Add($textbox1)
    $form.Controls.Add($textlbl1)
    $Form.Controls.Add($picturebox)
    $form.ShowDialog()
    }
 WFDomNewGroup