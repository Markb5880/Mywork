Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function WFDomUserToHierarchical {
cls

# Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="User To Hierarchical."
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
    $textlbl1.Location=New-Object System.Drawing.Size(80,10)
    $textlbl1.backcolor="Transparent"
    $textlbl1.size=New-Object System.Drawing.Size(160,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="Hierarchical Convert:"
# Draw a Textbox
    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(69,35)
    $textbox1.size=New-Object System.Drawing.Size(170,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace
    $ToolTxtBx1 = New-Object System.Windows.Forms.ToolTip
    $ToolTxtBx1.SetToolTip($textbox1,"Enter [FirstName][Space][LastName]")

# Add an 'Hierarchical' Button    
    $Hierarchicalbutton=New-Object System.Windows.Forms.Button
    $Hierarchicalbutton.Location = New-Object System.Drawing.Size(68,75)
    $Hierarchicalbutton.Size = New-Object System.Drawing.Size(80,40)
    $Hierarchicalbutton.Text = "User To Hierarchical"
    $Hierarchicalbutton.add_click({$User=$textbox1.Text;
    & "C:\Users\administrator\Documents\Domino Powershell\Complete\PS-DomUpgradeUserToHierarchical.ps1";$textbox1.Clear()
        })
    $Form.Controls.Add($Hierarchicalbutton)
    
# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(185,75)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,40)
    $Exitbutton.Text = "Exit"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)
    $form.Controls.Add($textbox1)
    $form.Controls.Add($textlbl1)
    $form.Controls.Add($pictureBox)
    $form.ShowDialog()
    }
 WFDomUserToHierarchical