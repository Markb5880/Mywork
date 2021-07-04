Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function TSTechNew_ADUser {
cls

# Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="This is my test text form."
    $form.Location.X=100
    $form.Location.Y=100
    $form.Size=New-Object System.Drawing.Size(300,300)

# Draw a Textbox
    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(150,25)
    $textbox1.size=New-Object System.Drawing.Size(150,64)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace
    
    $textbox1.Text="This is the Mainform."
    $form.Controls.Add($textbox1)

# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(100,400)
    $Exitbutton.Size = New-Object System.Drawing.Size(100,100)
    $Exitbutton.Text = "Exit"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)

    $form.ShowDialog()
    }
 TSTechNew_ADUser