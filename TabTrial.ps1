Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing.graphics")
$Global:Form

function TabFormTest {
cls

# Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="This is my Group Tool form."
    $form.Location.X=2048
    $form.Location.Y=1024
    $form.Size=New-Object System.Drawing.Size(645,355)
  
    # TabControl Setup
    $tabcontrol=New-Object System.Windows.Forms.tabcontrol
    $tabcontrol.width=620
    $tabcontrol.height=305
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $tabcontrol.Font=$FontFace

    # Draw a Textbox
    $tabpage1=New-Object System.Windows.Forms.tabpage
    $tabpage1.name="Tab1"
    $tabpage1.Text="User Group Viewer"
    $Tabpage1.backcolor="LightGray"
    $tabpage1.width=480
    $tabpage1.height=480

    $dd=$null
    
    cls
    
    # Domain Textbox - top right
        $TextBox6 = New-Object System.Windows.Forms.TextBox 
        $TextBox6.Multiline = $false;
        $TextBox6.Location = New-Object System.Drawing.Size(230,5) 
        $TextBox6.Size = New-Object System.Drawing.Size(270,16)
        $Font = New-Object System.Drawing.Font("Tahoma",10,[System.Drawing.FontStyle]::regular)
        $TextBox6.Font=$Font
        $gdm=get-addomain | select dnsroot
        $gdm1=$gdm.dnsroot.tostring()
            
        $body1 = @"
Current Domain Name: $gdm1
"@
        $Textbox6.text=$body1

    # Scrollable User Selection Textbox - Mid Left
        $TextBox2 = New-Object System.Windows.Forms.Listbox 
        $TextBox2.Location = New-Object System.Drawing.Size(5,40) 
        $TextBox2.Size = New-Object System.Drawing.Size(170,64)
        $TextBox2.Height = 237
    
    # Scrollable Group Output Textbox - Bottom
        $TextBox3 = New-Object System.Windows.Forms.textbox
        $textbox3.multiline=$true
        $textbox3.AutoSize=$false
        $textbox3.scrollbars='vertical'
        $TextBox3.Location = New-Object System.Drawing.Size(230,130) 
        $TextBox3.Size = New-Object System.Drawing.Size(320,112)
        
    # Draw Chosen Username Text Label
        $textlbl1=New-Object System.Windows.Forms.label
        $textlbl1.Location=New-Object System.Drawing.Size(230,57)
        $textlbl1.backcolor="Transparent"
        $textlbl1.size=New-Object System.Drawing.Size(240,16)
        $FontFace = New-Object System.Drawing.Font(
        "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
        $textlbl1.Font=$FontFace
        $textlbl1.text="Currently Selected Username:"

     # Draw Chosen 'Group Membership' Text Label
         $textlbl2=New-Object System.Windows.Forms.label
         $textlbl2.Location=New-Object System.Drawing.Size(230,110)
         $textlbl2.backcolor="Transparent"
         $textlbl2.size=New-Object System.Drawing.Size(240,18)
         $FontFace = New-Object System.Drawing.Font(
         "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
         $textlbl2.Font=$FontFace
         $textlbl2.text="Selected User's Group Membership:"
        
    # Draw Username Textbox
        $textbox1a=New-Object System.Windows.Forms.textbox
        $textbox1a.Location=New-Object System.Drawing.Size(230,76)
        $textbox1a.size=New-Object System.Drawing.Size(210,64)
        $FontFace = New-Object System.Drawing.Font(
        "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
        $textbox1a.Font=$FontFace
     
        $dname =@()
    # Load the items and sort the list in Ascending order.
        $usr=Get-ADUser -filter * -SearchBase "OU=F1,OU=TS Tech Users,DC=SMALLHOME,DC=LOCAL" | where {$_.enabled -eq $true } | select samaccountname,name |sort samaccountname
        $usr.samaccountname | ForEach-Object {[void]$Textbox2.Items.Add($_);$dname=$usr.name}
    # Current AD User Count
        $TextBox5 = New-Object System.Windows.Forms.TextBox 
        $TextBox5.Location = New-Object System.Drawing.Size(5,5) 
        $TextBox5.Size = New-Object System.Drawing.Size(170,64)
        $Font = New-Object System.Drawing.Font("Tahoma",10,[System.Drawing.FontStyle]::regular)
        $TextBox5.Font=$Font
        $usrcnt=$Textbox2.items.Count
    
        $body5 = @"
Current AD User Count: $usrcnt
"@
        $Textbox5.text=$body5
            
       $Textbox2.add_click({$selection = $Textbox2.Selecteditem#;$Form.Controls.Clear($textbox1a)
        $adp=Get-ADPrincipalGroupMembership -Identity $selection | sort name
        $c=$adp.name # used for data line count
        
    # Display the 'users' groups, but we need to take care of the additional
    # new line at the end of the list.
        $lines=$c.count-1
        $textbox3.Clear()
    
        foreach($gp in $adp){
            $textbox3.appendtext($gp.samaccountname)
                if ($lines -gt 0){
                $textbox3.AppendText("`r`n")
            $lines=$lines-1
            }
        }
        $zz=$dname[$textbox2.SelectedIndex]
        $textbox1a.Text="$zz"
        $textbox3.Refresh()
            
        })
          
    #}
    $tabpage1.Controls.Add($textbox6)
    $tabpage1.Controls.Add($textbox2)
    $tabpage1.Controls.Add($textbox3)
    $tabpage1.Controls.Add($textlbl1)
    $tabpage1.Controls.Add($textbox1a)
    $tabpage1.Controls.Add($textbox5)
    $tabpage1.controls.add($textlbl2)

    $tabpage2=New-Object System.Windows.Forms.tabpage
    $tabpage2.name="Tab2"
    $tabpage2.Text="User Group Modifier"
    $tabpage2.width=300
    $tabpage2.height=500
    $Tabpage2.backcolor="LightGray"
    $tabcontrol.tabpages.add($tabpage1)
    $tabcontrol.tabpages.add($tabpage2)

    $textlbl2=New-Object System.Windows.Forms.label
    $textlbl2.Location=New-Object System.Drawing.Size(220,150)
    #$textlbl1.backcolor="Transparent"
    $textlbl2.size=New-Object System.Drawing.Size(500,650)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $textlbl2.Font=$FontFace

    Clear-Host

#   Group Text Label
    $Grouplbl1=New-Object System.Windows.Forms.label
    $Grouplbl1.Location=New-Object System.Drawing.Size(5,2)
    $FontFace = New-Object System.Drawing.Font("Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $Grouplbl1.Font=$FontFace
    $Grouplbl1.text="AD Group List"
#   Group Checkedlist Box    
    $script:GroupTBox = New-Object System.Windows.Forms.Checkedlistbox 
    $script:GroupTBox.Location = New-Object System.Drawing.Size(3,25)
    $script:GroupTBox.Size = New-Object System.Drawing.Size(260,256)
    $Font = New-Object System.Drawing.Font("Tahoma",8,[System.Drawing.FontStyle]::regular)
    $script:GroupTBox.Font=$Font
#   User Text Label
    $Userlbl1=New-Object System.Windows.Forms.label
    $Userlbl1.Location=New-Object System.Drawing.Size(400,2)
    $FontFace = New-Object System.Drawing.Font("Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
    $Userlbl1.Font=$FontFace
    $Userlbl1.text="AD User List"
#   User Checkedlist Box    
    $script:UserTBox = New-Object System.Windows.Forms.checkedListbox 
    $script:UserTBox.Location = New-Object System.Drawing.Size(403,25)
    $script:UserTBox.Size = New-Object System.Drawing.Size(210,256)
    $Font = New-Object System.Drawing.Font("Tahoma",8,[System.Drawing.FontStyle]::regular)
    $script:UserTBox.Font=$Font
# Populate the Group CheckboxList
    $AllADGroups=Get-ADGroup -Filter * | select name | Sort Name
    $AllADGroups.name | ForEach-Object{[void]$script:GroupTBox.items.Add($_)}
# Populate the User CheckboxList
    $AllADUsers=Get-ADUser -Filter * -Properties name -SearchBase "OU=TS Tech Users,DC=smallhome,DC=local" |`
    sort name |select Name
    $AllADUsers.name | ForEach-Object{[void]$script:UserTBox.items.Add($_)}
# 'Get Groups Button'    
    $ChangeDBSizebutton=New-Object System.Windows.Forms.Button
    $ChangeDBSizebutton.Location = New-Object System.Drawing.Size(300,30)
    $ChangeDBSizebutton.Size = New-Object System.Drawing.Size(60,40)
    $ChangeDBSizebutton.BackColor="DarkBlue"
    $ChangeDBSizebutton.ForeColor="White"
    $ChangeDBSizebutton.Text = "Get Groups"
# 'Add Users to Groups Button'
    $ChangeDBSizebutton1=New-Object System.Windows.Forms.Button
    $ChangeDBSizebutton1.Location = New-Object System.Drawing.Size(285,95)
    $ChangeDBSizebutton1.Size = New-Object System.Drawing.Size(90,76)
    $ChangeDBSizebutton1.BackColor="DarkBlue"
    $ChangeDBSizebutton1.ForeColor="White"
    $ChangeDBSizebutton1.Text = "Add Selected`r`nUser to Groups"
# 'Remove Users From Groups Button'
    $ChangeDBSizebutton2=New-Object System.Windows.Forms.Button
    $ChangeDBSizebutton2.Location = New-Object System.Drawing.Size(278,200)
    $ChangeDBSizebutton2.Size = New-Object System.Drawing.Size(115,64)
    $ChangeDBSizebutton2.BackColor="DarkBlue"
    $ChangeDBSizebutton2.ForeColor="White"
    $ChangeDBSizebutton2.Text = "Remove User from`r`nSelected Groups"
# Temp variables
    $b=@()
    $c=@()
    $a=@()
    $script:grplist=""
    $script:selectedUser=""
    $checkedcount=0
# Get Groups Button
    $ChangeDBSizebutton.add_click({
        [int]$i
# Check the user list to see if they are all empty, if so Display an Error message
    for ($i = 0; $i -lt $Script:UserTBox.Items.Count;$i++)
        {
# Variable to be used as an ERROR Flag            
            if ($Script:UserTBox.getItemChecked($i))
            {
            $Checkedcount+=1
            } 
        }
# NO USERS SELECTED
            if ($Checkedcount -eq 0)
            {
            [System.Windows.MessageBox]::Show("You have NOT selected a User.`r`nPlease select a user from`r`nthe AD User List!!",'No User checkbox Checked!!','OK','Error')
            }
# MORE THAN 1 USER SELECTED        
            if ($Checkedcount -gt 1)
            {
            [System.Windows.MessageBox]::Show("You have selected more than ONE User, please Select One user only!!",'Multiple User Selection Error','OK','Error')
#Clear All User Checkmarks                
                for ($i = 0; $i -lt $Script:UserTBox.Items.Count;$i++)
                {
                $script:UserTBox.SetItemChecked($i,$false) 
                }
                $Script:UserTBox.Enabled=$true
            } 
# Check to see which User has been selected.     
    for ($i = 0; $i -lt $Script:UserTBox.Items.Count;$i++)
        {        
        if ($Script:UserTBox.GetItemChecked($i)) 
            {
                $a=$Script:UserTBox.Items[$i].ToString()
                $checkedItemUserName=Get-ADUser -ldapfilter "(name=$a)" -SearchBase "OU=TS Tech Users,DC=smallhome,DC=local"
                $CheckedUsersGroups=Get-ADPrincipalGroupMembership $checkedItemUserName.SamAccountName
                $script:grplist=$CheckedUsersGroups.Name
            }
        } 
    $script:selectedUser=$checkedItemUserName.SamAccountName
            
    [int]$i
    for ($i = 0; $i -lt $script:GroupTBox.Items.Count;$i++)
    {
        $script:GroupTBox.SetItemChecked($i,$false)  
        foreach ($ugrp in $script:grplist)
        {
        if ($ugrp -contains $script:GroupTBox.items[$i])
            {
            $script:GroupTBox.SetItemChecked($i,$true)
            }
        }
    }
# MORE THAN 1 USER SELECTED        
if ($Checkedcount -gt 1)
{
    for ($i = 0; $i -lt $Script:GroupTBox.Items.Count;$i++)
    {
        $script:GroupTBox.SetItemChecked($i,$false) 
    }
    $Script:UserTBox.Enabled=$true
}     
})

# Add User to Groups Button
$ChangeDBSizebutton1.add_click({
    [int]$i
    for ($i = 0; $i -lt $Script:GroupTBox.Items.Count;$i++)
    {
        if ($script:GroupTBox.GetItemChecked($i))  
        {
            If ($script:GroupTBox.GetItemChecked($i) -eq $script:GroupTBox.Items[$i])
               {  
                $b=$script:GroupTBox.Items[$i].ToString()
                foreach ($SelectedGroup in $b)
                {
                    if ($script:grplist -notcontains $SelectedGroup)
                       {
                        Add-ADGroupMember $SelectedGroup -Members $script:selectedUser
                        $grplistnew+=$SelectedGroup+"`r`n"
                       } elseif ($script:grplist -like $grplistnew)
                            {
                            [System.Windows.MessageBox]::Show("$script:selectedUser is already a member of the following groups:`r`n$script:grplist",'New Group Additions','OK','Error')      
                            }
                       }
                }
            }   
        }
[System.Windows.MessageBox]::Show("$script:selectedUser has now been added as a member of the following groups:`r`n$grplistnew",'New Group Additions','OK','Information')  

# Clear all the checkbox items in both the Groups List as well as the User List
for ($i = 0; $i -lt $Script:GroupTBox.Items.Count;$i++)
        {
        $Script:GroupTBox.SetItemChecked($i,$false)
        }  
for ($i = 0; $i -lt $Script:UserTBox.Items.Count;$i++)
        {
        $script:UserTBox.setitemchecked($i,$false)
        }

        $Script:UserTBox.Enabled=$true
})

# Remove User From Selected Group(s) Button
$ChangeDBSizebutton2.add_click({
    [int]$i
    for ($i = 0; $i -lt $Script:GroupTBox.Items.Count;$i++)
    {
        if ($script:GroupTBox.GetItemChecked($i))  
        {
            If ($script:GroupTBox.GetItemChecked($i) -eq $script:GroupTBox.Items[$i])
            {  
                $b=$b+$script:GroupTBox.Items[$i]
            }
        }
    }
# compare two lists, one is the current list and one is the old list
    foreach($a in $script:grplist)
    {
      if ($b -notcontains $a)
        {
          $c=$c+$a
        }  
    }
# Now do the Remove    
    Remove-ADPrincipalGroupMembership $script:selectedUser -MemberOf $c -Confirm:$false
    [System.Windows.MessageBox]::Show("$script:selectedUser has now been Removed as a member of the following groups:`r`n$c",'New Group Additions','OK','Information')  

# Clear all the checkbox items in both the Groups List as well as the User List
for ($i = 0; $i -lt $Script:GroupTBox.Items.Count;$i++)
        {
        $Script:GroupTBox.SetItemChecked($i,$false)
        }  
for ($i = 0; $i -lt $Script:UserTBox.Items.Count;$i++)
        {
        $script:UserTBox.setitemchecked($i,$false)
        }
        $Script:UserTBox.Enabled=$true
})
<# Add an 'EXIT' Button
      
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(330,200)
    $Exitbutton.Size = New-Object System.Drawing.Size(75,48)
    $Exitbutton.Backcolor = "LightGreen"

    $Exitbutton.Forecolor = "purple"
    $Exitbutton.Text = "Exit"
    $Exitbutton.add_click({$Form.Close()})
#>
    $tabpage2.Controls.Add($Grouplbl1)
    $tabpage2.Controls.Add($Script:GroupTBox)
    $tabpage2.Controls.Add($Userlbl1)
    $tabpage2.Controls.Add($Script:UserTBox)
    $tabpage2.Controls.Add($ChangeDBSizebutton)
    $tabpage2.Controls.Add($ChangeDBSizebutton1)
    $tabpage2.Controls.Add($ChangeDBSizebutton2)
    #$Form.Controls.Add($Exitbutton)
    $form.Controls.Add($tabcontrol)

    $form.ShowDialog()
}
TabFormTest
