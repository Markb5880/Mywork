Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function WFDomUserRegistration {
cls
    
    # Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="New Domino User Registration."
    $form.Location.X=400
    $form.Location.Y=400
    $form.Size=New-Object System.Drawing.Size(700,400)
#Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(700,400)
    $Form.MinimumSize=New-Object System.Drawing.Size(700,400)
# Display an Image1 on a form
    $image = [System.Drawing.Image]::Fromfile('C:\Users\administrator\Downloads\lotus-notes-icon.png')     
    $pictureBox = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
    $pictureBox.Image=$image
    $pictureBox.Location = New-object System.Drawing.Size(0,90)
    $pictureBox.Width =  $image.Size.Width
    $pictureBox.Height =  $image.Size.Height
    $pictureBox.Image = $image
# Display an Image2 on a form
    $image = [System.Drawing.Image]::Fromfile('C:\Users\administrator\Documents\notes9.jpg')     
    $pictureBox1 = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
    $pictureBox1.Image=$image
    $pictureBox1.Location = New-object System.Drawing.Size(385,110)
    $pictureBox1.Width =  $image.Size.Width
    $pictureBox1.Height =  $image.Size.Height
    $pictureBox1.Image = $image    
#>    
# Draw FirstName Text Label
    $textlbl1=New-Object System.Windows.Forms.label
    $textlbl1.Location=New-Object System.Drawing.Size(2,15)
    $textlbl1.backcolor="Transparent"
    $textlbl1.size=New-Object System.Drawing.Size(112,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="FirstName:"
# Draw MiddleName Text Label
    $textlbl2=New-Object System.Windows.Forms.label
    $textlbl2.Location=New-Object System.Drawing.Size(220,15)
    $textlbl2.backcolor="Transparent"
    $textlbl2.size=New-Object System.Drawing.Size(112,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl2.Font=$FontFace
    $textlbl2.text="MiddleName:"
# Draw LastName Text Label
    $textlbl3=New-Object System.Windows.Forms.label
    $textlbl3.Location=New-Object System.Drawing.Size(455,15)
    $textlbl3.backcolor="Transparent"
    $textlbl3.size=New-Object System.Drawing.Size(107,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl3.Font=$FontFace
    $textlbl3.text="LastName:"

# Draw MailQuota Text Label
    $textlbl5=New-Object System.Windows.Forms.label
    $textlbl5.Location=New-Object System.Drawing.Size(2,64)
    $textlbl5.backcolor="Transparent"
    $textlbl5.size=New-Object System.Drawing.Size(112,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl5.Font=$FontFace
    $textlbl5.text="Max MailQuota:"
# Draw MailQuotaWarning Text Label
    $textlbl6=New-Object System.Windows.Forms.label
    $textlbl6.Location=New-Object System.Drawing.Size(220,64)
    $textlbl6.backcolor="Transparent"
    $textlbl6.size=New-Object System.Drawing.Size(137,24)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl6.Font=$FontFace
    $textlbl6.text="MailQuota Warning:"
# Draw ShortName Text Label
    $textlbl4=New-Object System.Windows.Forms.label
    $textlbl4.Location=New-Object System.Drawing.Size(446,64)
    $textlbl4.backcolor="Transparent"
    $textlbl4.size=New-Object System.Drawing.Size(130,16)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl4.Font=$FontFace
    $textlbl4.text="ShortName:"
# Draw MB0 Text Label
    $textlbl7=New-Object System.Windows.Forms.label
    $textlbl7.Location=New-Object System.Drawing.Size(162,64)
    $textlbl7.backcolor="Transparent"
    $textlbl7.size=New-Object System.Drawing.Size(32,24)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl7.Font=$FontFace
    $textlbl7.text="MB"
# Draw MB1 Text Label
    $textlbl8=New-Object System.Windows.Forms.label
    $textlbl8.Location=New-Object System.Drawing.Size(404,64)
    $textlbl8.backcolor="Transparent"
    $textlbl8.size=New-Object System.Drawing.Size(32,24)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl8.Font=$FontFace
    $textlbl8.text="MB"
# Draw FirstName Textbox
    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(75,11)
    $textbox1.size=New-Object System.Drawing.Size(140,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace
# Draw Middlename Textbox
    $textbox2=New-Object System.Windows.Forms.textbox
    $textbox2.Location=New-Object System.Drawing.Size(306,11)
    $textbox2.size=New-Object System.Drawing.Size(140,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox2.Font=$FontFace
# Draw LastName Textbox
    $textbox3=New-Object System.Windows.Forms.textbox
    $textbox3.Location=New-Object System.Drawing.Size(525,11)
    $textbox3.size=New-Object System.Drawing.Size(140,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox3.Font=$FontFace

# Draw MailQuota Textbox
    $textbox5=New-Object System.Windows.Forms.textbox
    $textbox5.Location=New-Object System.Drawing.Size(107,62)
    $textbox5.size=New-Object System.Drawing.Size(50,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox5.Font=$FontFace
# Draw MailQuotaWarning Textbox
    $textbox6=New-Object System.Windows.Forms.textbox
    $textbox6.Location=New-Object System.Drawing.Size(350,60)
    $textbox6.size=New-Object System.Drawing.Size(50,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox6.Font=$FontFace
# Draw shortname Textbox
    $textbox4=New-Object System.Windows.Forms.textbox
    $textbox4.Location=New-Object System.Drawing.Size(525,60)
    $textbox4.Enabled=$false
    $textbox4.size=New-Object System.Drawing.Size(140,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox4.Font=$FontFace

$label = New-Object System.Windows.Forms.Label
$label.Text = "User Registration in Progress. *** PLEASE WAIT!! ***"
$label.Location=New-Object System.Drawing.Size(265,150)
    $label.size=New-Object System.Drawing.Size(105,112)
    $label.forecolor="Green"
    $label.Visible=$false
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",12,[System.Drawing.FontStyle]::Bold)
    $label.Font=$FontFace
$form.Controls.Add($label)

# Add an 'Register New User' Button    
    $RegisterNewUserbutton=New-Object System.Windows.Forms.Button
    $RegisterNewUserbutton.Location = New-Object System.Drawing.Size(80,200)
    $RegisterNewUserbutton.Size = New-Object System.Drawing.Size(120,24)
    $RegisterNewUserbutton.Text = "Register New User"
    $RegisterNewUserbutton.forecolor = "Green"
    $RegisterNewUserbutton.add_click({$firstname=$textbox1.Text;$middle=$textbox2.Text;$lastname=$textbox3.Text;
    $textbox4.text=$firstname.substring(0,1)+$lastname;$ShortName=$textbox4.Text;$MailQuotaSizeLimit=$textbox5.Text;$MailQuotaWarningThreshold=$textbox6.Text;
     & "C:\Users\administrator\Documents\Domino Powershell\Complete\PS-DomUserRegistration.ps1";
    $textbox1.Clear();$textbox2.Clear();$textbox3.Clear();$textbox4.Clear();
    $textbox5.Clear();$textbox6.Clear();$label.Visible=$false
        })
    $Form.Controls.Add($RegisterNewUserbutton)
    
# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(473,200)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,24)
    $Exitbutton.Text = "Exit"
    $Exitbutton.forecolor = "Red"
    $Exitbutton.add_click({$Form.Close()})
# Add Controls to the Form
    $Form.Controls.Add($Exitbutton)
    $form.Controls.Add($textbox1)
    $form.Controls.Add($textbox2)
    $form.Controls.Add($textbox3)
    $form.Controls.Add($textbox4)
    $form.Controls.Add($textbox5)
    $form.Controls.Add($textbox6)
    $form.Controls.Add($textlbl1)
    $form.Controls.Add($textlbl2)
    $form.Controls.Add($textlbl3)
    $form.Controls.Add($textlbl4)
    $form.Controls.Add($textlbl5)
    $form.Controls.Add($textlbl6)
    $form.Controls.Add($textlbl7)
    $form.Controls.Add($textlbl8)
    $form.Controls.Add($pictureBox)
    $form.Controls.Add($pictureBox1)
# Show Form
    $form.ShowDialog()
    }
 WFDomUserRegistration