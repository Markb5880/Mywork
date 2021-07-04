function checked {
Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
Add-Type -AssemblyName PresentationFramework

Clear-Host

#   Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="Add/Remove AD User to And From Groups"
    $form.Location.x=400
    $form.Location.Y=400
    $form.Size=New-Object System.Drawing.Size(665,330)
#   Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(665,330)
    $Form.MinimumSize=New-Object System.Drawing.Size(665,330)
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
    $ChangeDBSizebutton1.Location = New-Object System.Drawing.Size(285,75)
    $ChangeDBSizebutton1.Size = New-Object System.Drawing.Size(90,40)
    $ChangeDBSizebutton1.BackColor="DarkBlue"
    $ChangeDBSizebutton1.ForeColor="White"
    $ChangeDBSizebutton1.Text = "Add Selected`r`nUser to Groups"
# 'Remove Users From Groups Button'
    $ChangeDBSizebutton2=New-Object System.Windows.Forms.Button
    $ChangeDBSizebutton2.Location = New-Object System.Drawing.Size(278,120)
    $ChangeDBSizebutton2.Size = New-Object System.Drawing.Size(105,55)
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

$Form.Controls.Add($Grouplbl1)
$Form.Controls.Add($Userlbl1)
$Form.Controls.add($UserTBox)
$Form.Controls.add($GroupTBox)            
$form.Controls.add($ChangeDBSizebutton)
$form.Controls.add($ChangeDBSizebutton1)
$form.Controls.add($ChangeDBSizebutton2)

$form.ShowDialog()
    
}
Checked
