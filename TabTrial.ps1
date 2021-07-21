Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function TabFormTest {
cls

# Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="This is my test text form."
    $form.Location.X=2048
    $form.Location.Y=1024
    $form.Size=New-Object System.Drawing.Size(1024,640)
    
    $tabcontrol=New-Object System.Windows.Forms.tabcontrol
    $tabcontrol.width=768
    $tabcontrol.height=512
    
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",24,[System.Drawing.FontStyle]::Regular)
    $tabcontrol.Font=$FontFace
# Draw a Textbox
    $tabpage1=New-Object System.Windows.Forms.tabpage
    $tabpage1.name="Tab1"
    $tabpage1.Text="Tab1"
    $Tabpage1.backcolor="Green"
    $tabpage1.width=700
    $tabpage1.height=700

    # Draw User To Delete Text Label
    $textlbl1=New-Object System.Windows.Forms.label
    $textlbl1.Location=New-Object System.Drawing.Size(220,150)
    #$textlbl1.backcolor="Transparent"
    $textlbl1.size=New-Object System.Drawing.Size(500,650)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",72,[System.Drawing.FontStyle]::Regular)
    $textlbl1.Font=$FontFace
    $textlbl1.text="HELLO"

    $tabpage1.Controls.Add($textlbl1)

    $tabpage2=New-Object System.Windows.Forms.tabpage
    $tabpage2.name="Tab2"
    $tabpage2.Text="Tab2"
    $tabpage2.width=3
    $tabpage2.height=5
    $tabcontrol.tabpages.add($tabpage1)
    $tabcontrol.tabpages.add($tabpage2)

    $textlbl2=New-Object System.Windows.Forms.label
    $textlbl2.Location=New-Object System.Drawing.Size(220,150)
    #$textlbl1.backcolor="Transparent"
    $textlbl2.size=New-Object System.Drawing.Size(500,650)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",72,[System.Drawing.FontStyle]::Regular)
    $textlbl2.Font=$FontFace
    $textlbl2.text="WORLD"

    $tabpage2.Controls.Add($textlbl2)
# Add an 'EXIT' Button
      
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(350,400)
    $Exitbutton.Size = New-Object System.Drawing.Size(100,100)
    $Exitbutton.Backcolor = "LightGreen"

    $Exitbutton.Forecolor = "purple"
    $Exitbutton.Text = "Exit"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)
    $form.Controls.Add($tabcontrol)

    $form.ShowDialog()
    }
 TabFormTest