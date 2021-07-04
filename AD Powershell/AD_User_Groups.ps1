Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"

function AD_User_Groups {

cls

# Create Mainform
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="Group Membership Form."
    $form.Location.X=300
    $form.Location.Y=300
    $form.Size=New-Object System.Drawing.Size(325,500)
    
# Multline Textbox for the user groups to be shown, each piece of data from the
# 'Select a user from AD' code block below; will be placed on individual lines of this textbox.
   
    $textbox2=New-Object System.Windows.Forms.textbox
    $textbox2.multiline=$true
    $textbox2.AutoSize=$false
    $textbox2.scrollbars='vertical'
    $textbox2.Location=New-Object System.Drawing.Size(22,75)
    $textbox2.size=New-Object System.Drawing.Size(240,0)
    $textbox2.Height=112
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",11,[System.Drawing.FontStyle]::regular)
    $textbox2.Font=$FontFace

# Select a user from AD
    #$chosen_user='schema admins'
    $textbox3=New-Object System.Windows.Forms.Listbox
    $textbox3.Location=New-Object System.Drawing.Size(22,192)
    $textbox3.size=New-Object System.Drawing.Size(240,48)
    $textbox3.Height=112
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",11,[System.Drawing.FontStyle]::regular)
    $textbox3.Font=$FontFace


    $ADUser=Get-ADUser -Filter * -Properties SamAccountName
    foreach ($txtbx3 in $ADUser){
    $textbox3.items.add($txtbx3.SamAccountName)
    }

    #if ($txtbx3 -ne $null){
#    $textbox3.selecteditem='administrator'
    $adp=Get-ADPrincipalGroupMembership -Identity $txtbx3
    $c=$adp.name # used for data line count

# Display the 'users' groups, but we need to take care of the additional
# new line at the end of the list.
    $lines=$c.count-1

    foreach($gp in $adp){
        $textbox2.AppendText($gp.name)
            if ($lines -gt 0){
            $textbox2.AppendText("`n")
        $lines=$lines-1
        }
    }
    $textbox3.Refresh()
    #}
        $form.controls.add($textbox3)

# Add the textbox to the form and set it to Read-Only.   
    $form.Controls.Add($textbox2)
    #$textbox2.ReadOnly=$true

# A label showing which user is having it's Groups displayed.
    $textbox1=New-Object System.Windows.Forms.label
    $textbox1.Location=New-Object System.Drawing.Size(42,5)
    $textbox1.size=New-Object System.Drawing.Size(200,40)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",11,[System.Drawing.FontStyle]::bold)
    $textbox1.Font=$FontFace
    
    $textbox1.text="Group Membership for user $txtbx3"
    $form.Controls.Add($textbox1)


    $form.ShowDialog()
    }

    
    AD_User_Groups