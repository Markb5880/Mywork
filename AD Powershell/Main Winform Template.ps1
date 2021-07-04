Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
$Global:Form

function mainform {
cls
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="This is my test text form."
    $form.Location.X=100
    $form.Location.Y=100
    $form.Size=New-Object System.Drawing.Size(1200,600)

    $form2button=New-Object System.Windows.Forms.Button
    $form2button.Location = New-Object System.Drawing.Size(100,100)
    $form2button.Size = New-Object System.Drawing.Size(100,100)
    $form2button.Text = "Form2"
    $form2button.add_click({Form2})
    $Form.Controls.Add($form2button)

    $form3button=New-Object System.Windows.Forms.Button
    $form3button.Location = New-Object System.Drawing.Size(220,100)
    $form3button.Size = New-Object System.Drawing.Size(100,100)
    $form3button.Text = "Form3"
    $form3button.add_click({Form3})
    $Form.Controls.Add($form3button)

    $form4button=New-Object System.Windows.Forms.Button
    $form4button.Location = New-Object System.Drawing.Size(340,100)
    $form4button.Size = New-Object System.Drawing.Size(100,100)
    $form4button.Text = "Form4"
    $form4button.add_click({Form4})
    $Form.Controls.Add($form4button)

    $textbox1=New-Object System.Windows.Forms.textbox
    $textbox1.Location=New-Object System.Drawing.Size(400,25)
    $textbox1.size=New-Object System.Drawing.Size(400,64)

    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",20,[System.Drawing.FontStyle]::Regular)
    $textbox1.Font=$FontFace
    
    $textbox1.Text="This is the Mainform."
    $form.Controls.Add($textbox1)
    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(100,400)
    $Exitbutton.Size = New-Object System.Drawing.Size(100,100)
    $Exitbutton.Text = "Exit"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)

    $form.ShowDialog()
    }
 function form2 {
    $form2=New-Object System.Windows.Forms.Form
    $form2.topmost=$true
    $form2.Text="This is form 2."
    $form2.Location.X=160
    $form2.Location.Y=160
    $form2.Size=New-Object System.Drawing.Size(300,600)

    $textbox2=New-Object System.Windows.Forms.textbox
    $textbox2.Location=New-Object System.Drawing.Size(90,5)
    $textbox2.size=New-Object System.Drawing.Size(120,64)

    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",11,[System.Drawing.FontStyle]::Regular)
    $textbox2.Font=$FontFace
    
    $textbox2.Text="This is form 2."
    $form2.Controls.Add($textbox2)
    $form2.Show()

    #$form2.hide()
    Start-Sleep 4
    $form2.Close()
    return
}
 function form3 {
    $form3=New-Object System.Windows.Forms.Form
    $form3.topmost=$true
    $form3.Text="This is form 3."
    $form3.Location.X=320
    $form3.Location.Y=160
    $form3.Size=New-Object System.Drawing.Size(300,600)

    $textbox3=New-Object System.Windows.Forms.textbox
    $textbox3.Location=New-Object System.Drawing.Size(90,5)
    $textbox3.size=New-Object System.Drawing.Size(120,64)

    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",11,[System.Drawing.FontStyle]::Regular)
    $textbox3.Font=$FontFace
    
    $textbox3.Text="This is form 3."
    $form3.Controls.Add($textbox3)

    $form3.Show()
    #$form2.hide()
    Start-Sleep 4
    $form3.Close()
    return
}
 function form4 {
    #$form.Controls.Add($($textbox1.Clear()))

    $form4=New-Object System.Windows.Forms.Form
    $form4.topmost=$true
    $form4.Text="This is form4."
    $form4.Location.X=480
    $form4.Location.Y=160
    $form4.Size=New-Object System.Drawing.Size(300,600)

    $textbox4=New-Object System.Windows.Forms.textbox
    $textbox4.Location=New-Object System.Drawing.Size(90,5)
    $textbox4.size=New-Object System.Drawing.Size(120,64)

    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",11,[System.Drawing.FontStyle]::Regular)
    $textbox4.Font=$FontFace
    
    $textbox4.Text="This is form 4."
    $form4.Controls.Add($textbox4)

    $form4.Show()
    #$form2.hide()
    Start-Sleep 4
    $form4.Close()
    return
}
Mainform