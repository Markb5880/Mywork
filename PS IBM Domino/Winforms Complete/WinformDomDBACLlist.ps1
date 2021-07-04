Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function WFDomDBACLList {
cls

# Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="Domino DB ACL List."
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
    $textlbl1.Location=New-Object System.Drawing.Size(2,15)
    $textlbl1.backcolor="Transparent"
    $textlbl1.size=New-Object System.Drawing.Size(110,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="Database Name:"
# Draw DB Input Textbox
    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(112,11)
    $textbox1.size=New-Object System.Drawing.Size(170,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace
    $ToolTxtBx1 = New-Object System.Windows.Forms.ToolTip
    $ToolTxtBx1.SetToolTip($textbox1,"[Path]\[Database.Nsf]")
# Draw ACL List Textbox
    $textbox2=New-Object System.Windows.Forms.textbox
    $textbox2.Location=New-Object System.Drawing.Size(12,100)
    $textbox2.Multiline=$true
    $textbox2.size=New-Object System.Drawing.Size(261,136)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox2.Font=$FontFace
    $textbox2.Enabled=$false
# Add a DB ACL list Button    
    $GetDBACLListbutton=New-Object System.Windows.Forms.Button
    $GetDBACLListbutton.Location = New-Object System.Drawing.Size(130,50)
    $GetDBACLListbutton.Size = New-Object System.Drawing.Size(50,45)
    $GetDBACLListbutton.Text = "Get DB ACL List"
    $GetDBACLListbutton.forecolor ="Green"
    $GetDBACLListbutton.add_click({$NotesDB=$textbox1.Text;
    & "C:\Users\administrator\Documents\Domino Powershell\Complete\PS-DomDBACLList.ps1";$textbox2.Enabled=$true;$textbox1.Clear()
        })
    $Form.Controls.Add($GetDBACLListbutton)
    
# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(215,50)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,40)
    $Exitbutton.Text = "Exit"
    $Exitbutton.ForeColor="Red"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)
    $form.Controls.Add($textbox1)
    $form.Controls.Add($textbox2)
    $form.Controls.Add($textlbl1)
    $form.Controls.Add($pictureBox)
    $form.ShowDialog()
    }
 WFDomDBACLList