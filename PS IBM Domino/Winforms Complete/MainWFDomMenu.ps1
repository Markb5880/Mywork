Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
Add-Type -AssemblyName PresentationFramework
$Global:Form

function MainWFDomMenu {
cls
# test    
    # Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="Domino Tools Main Menu"
    $form.Location.x=400
    $form.Location.Y=400
    $form.Size=New-Object System.Drawing.Size(665,330)
#Now Lock the form so it cannot be re-sized.
    $Form.MaximumSize=New-Object System.Drawing.Size(665,330)
    $Form.MinimumSize=New-Object System.Drawing.Size(665,330)

# Display an Image on a form
    $image = [System.Drawing.Image]::Fromfile('C:\Users\administrator\pictures\dombgnd.jpg')     
    $pictureBox = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
    $pictureBox.Image=$image
    $pictureBox.Location = New-object System.Drawing.Size(2,0)
    $pictureBox.Width =  $image.Size.Width
    $pictureBox.Height =  $image.Size.Height
    $pictureBox.Image = $image

# 'CHANGE Database Size' Button    
    $ChangeDBSizebutton=New-Object System.Windows.Forms.Button
    $ChangeDBSizebutton.Location = New-Object System.Drawing.Size(2,11)
    $ChangeDBSizebutton.Size = New-Object System.Drawing.Size(60,40)
    $ChangeDBSizebutton.BackColor="DarkBlue"
    $ChangeDBSizebutton.ForeColor="White"
    $ChangeDBSizebutton.Text = "Set DB Quotas"
    $ChangeDBSizebutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomDBSetQuota.ps1"
        })
# 'GET DB ACL list' Button    
    $GetDBACLListbutton=New-Object System.Windows.Forms.Button
    $GetDBACLListbutton.Location = New-Object System.Drawing.Size(70,11)
    $GetDBACLListbutton.Size = New-Object System.Drawing.Size(50,45)
    $GetDBACLListbutton.BackColor="DarkBlue"
    $GetDBACLListbutton.ForeColor="White"
    $GetDBACLListbutton.Text = "Get DB ACL List"
    $GetDBACLListbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomDBACLlist.ps1"
        })
# 'ADD Group Members' Button    
    $AddGroupMembersbutton=New-Object System.Windows.Forms.Button
    $AddGroupMembersbutton.Location = New-Object System.Drawing.Size(129,11)
    $AddGroupMembersbutton.Size = New-Object System.Drawing.Size(60,54)
    $AddGroupMembersbutton.BackColor="Yellow"
    $AddGroupMembersbutton.ForeColor="DarkRed"
    $AddGroupMembersbutton.Text = "Add Group Members"
    $AddGroupMembersbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformAddGroupMembers.ps1"
        })
# 'CREATE Multiple Groups' Button    
    $AddGroupMembersMbutton=New-Object System.Windows.Forms.Button
    $AddGroupMembersMbutton.Location = New-Object System.Drawing.Size(129,72)
    $AddGroupMembersMbutton.Size = New-Object System.Drawing.Size(60,54)
    $AddGroupMembersMbutton.BackColor="Yellow"
    $AddGroupMembersMbutton.ForeColor="DarkRed"
    $AddGroupMembersMbutton.Text = "Create Multiple Groups"
    $AddGroupMembersMbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomNewMultiplegroups.ps1"
        })
# 'REMOVE Multiple Groups' Button    
    $RemoveGroupsbutton=New-Object System.Windows.Forms.Button
    $RemoveGroupsbutton.Location = New-Object System.Drawing.Size(129,132)
    $RemoveGroupsbutton.Size = New-Object System.Drawing.Size(60,54)
    $RemoveGroupsbutton.BackColor="Yellow"
    $RemoveGroupsbutton.ForeColor="DarkRed"
    $RemoveGroupsbutton.Text = "Remove Multiple Groups"
    $RemoveGroupsbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomRemoveMultipleGroups.ps1"
        })
# 'RENAME User' Button    
    $RenameUserbutton=New-Object System.Windows.Forms.Button
    $RenameUserbutton.Location = New-Object System.Drawing.Size(129,191)
    $RenameUserbutton.Size = New-Object System.Drawing.Size(60,40)
    $RenameUserbutton.BackColor="Black"
    $RenameUserbutton.ForeColor="Red"
    $RenameUserbutton.Text = "Rename User"
    $RenameUserbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomRenameUser.ps1"
        })
# 'REGISTER New User' Button    
    $RegisterNewUserbutton=New-Object System.Windows.Forms.Button
    $RegisterNewUserbutton.Location = New-Object System.Drawing.Size(197,197)
    $RegisterNewUserbutton.Size = New-Object System.Drawing.Size(120,24)
    $RegisterNewUserbutton.BackColor="Black"
    $RegisterNewUserbutton.ForeColor="Red"
    $RegisterNewUserbutton.Text = "Register New User"
    $RegisterNewUserbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomUserRegistration.ps1"
        })
# 'CERTIFY User' Button    
    $CertifyUserbutton=New-Object System.Windows.Forms.Button
    $CertifyUserbutton.Location = New-Object System.Drawing.Size(325,191)
    $CertifyUserbutton.Size = New-Object System.Drawing.Size(50,40)
    $CertifyUserbutton.BackColor="Black"
    $CertifyUserbutton.ForeColor="Red"
    $CertifyUserbutton.Text = "Certify User"
    $CertifyUserbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomRecertifyUser.ps1"
        })
# 'DELETE user' Button    
    $DeleteUserbutton=New-Object System.Windows.Forms.Button
    $DeleteUserbutton.Location = New-Object System.Drawing.Size(383,191)
    $DeleteUserbutton.Size = New-Object System.Drawing.Size(50,40)
    $DeleteUserbutton.BackColor="Black"
    $DeleteUserbutton.ForeColor="Red"
    $DeleteUserbutton.Text = "Delete User"
    $DeleteUserbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomDeleteUser.ps1"
        })
# 'CREATE Empty Group' Button    
    $CreateGroupbutton=New-Object System.Windows.Forms.Button
    $CreateGroupbutton.Location = New-Object System.Drawing.Size(200,11)
    $CreateGroupbutton.Size = New-Object System.Drawing.Size(60,48)
    $CreateGroupbutton.BackColor="DarkGreen"
    $CreateGroupbutton.ForeColor="White"
    $CreateGroupbutton.Text = "Create Empty Group"
    $CreateGroupbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomNewGroup.ps1"
        })
# 'RENAME Group' Button    
    $RenameGroupbutton=New-Object System.Windows.Forms.Button
    $RenameGroupbutton.Location = New-Object System.Drawing.Size(200,72)
    $RenameGroupbutton.Size = New-Object System.Drawing.Size(60,54)
    $RenameGroupbutton.BackColor="DarkGreen"
    $RenameGroupbutton.ForeColor="White"
    $RenameGroupbutton.Text = "Rename Group"
    $RenameGroupbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomRenameGroup.ps1"
        })
# 'REMOVE Group' Button    
    $RemoveGroupbutton=New-Object System.Windows.Forms.Button
    $RemoveGroupbutton.Location = New-Object System.Drawing.Size(200,132)
    $RemoveGroupbutton.Size = New-Object System.Drawing.Size(60,40)
    $RemoveGroupbutton.BackColor="DarkGreen"
    $RemoveGroupbutton.ForeColor="White"
    $RemoveGroupbutton.Text = "Remove Group"
    $RemoveGroupbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomRemoveGroup.ps1"
        })
# 'EXPORT All Group Names' Button    
    $ExpGrpNamesbutton=New-Object System.Windows.Forms.Button
    $ExpGrpNamesbutton.Location = New-Object System.Drawing.Size(270,11)
    $ExpGrpNamesbutton.Size = New-Object System.Drawing.Size(64,48)
    $ExpGrpNamesbutton.BackColor="DarkGreen"
    $ExpGrpNamesbutton.ForeColor="White"
    $ExpGrpNamesbutton.Text = "Export All Group Names"
    $ExpGrpNamesbutton.add_click({
    & "C:\Users\administrator\Documents\Domino Powershell\Complete\PS-DomGrplistAll.ps1"
        })
# 'EXPORT All Email Addresses' Button    
    $ExpEMailAddbutton=New-Object System.Windows.Forms.Button
    $ExpEMailAddbutton.Location = New-Object System.Drawing.Size(270,72)
    $ExpEMailAddbutton.Size = New-Object System.Drawing.Size(70,48)
    $ExpEMailAddbutton.BackColor="DarkGreen"
    $ExpEMailAddbutton.ForeColor="White"
    $ExpEMailAddbutton.Text = "Export All Email Addresses"
    $ExpEMailAddbutton.add_click({
    & "C:\Users\administrator\Documents\Domino Powershell\Complete\PS-DomAllEmailAddresses.ps1"
        })
# 'EXPORT Domino Group Members' Button    
    $GrpListbutton=New-Object System.Windows.Forms.Button
    $GrpListbutton.Location = New-Object System.Drawing.Size(270,132)
    $GrpListbutton.Size = New-Object System.Drawing.Size(95,40)
    $GrpListbutton.BackColor="DarkGreen"
    $GrpListbutton.ForeColor="White"
    $GrpListbutton.Text = "Export Domino Group Members"
    $GrpListbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomGroupMembers.ps1"
        })
<# Add an 'Hierarchical' Button    
    $Hierarchicalbutton=New-Object System.Windows.Forms.Button
    $Hierarchicalbutton.Location = New-Object System.Drawing.Size(382,185)
    $Hierarchicalbutton.Size = New-Object System.Drawing.Size(80,40)
    $Hierarchicalbutton.BackColor="Black"
    $Hierarchicalbutton.ForeColor="Red"
    $Hierarchicalbutton.Text = "User To Hierarchical"
    $Hierarchicalbutton.add_click({
    & "C:\Users\administrator\Documents\Winforms Complete\WinformDomUserToHiearchicalUser.ps1"
        })
#>
# Add an 'EXIT' Button    
    $Exitbutton=New-Object System.Windows.Forms.Button
    $Exitbutton.Location = New-Object System.Drawing.Size(580,235)
    $Exitbutton.Size = New-Object System.Drawing.Size(50,40)
    $Exitbutton.BackColor="Orange"
    $Exitbutton.ForeColor="Black"
    $Exitbutton.Text = "Exit"
    $Exitbutton.add_click({$Form.Close()})

    $Form.Controls.Add($Exitbutton)
    $form.Controls.Add($ExpEMailAddbutton)
    $form.Controls.Add($ExpGrpNamesbutton)
    $Form.Controls.Add($AddGroupMembersbutton)
    $Form.Controls.Add($GetDBACLListbutton) 
    $Form.Controls.Add($DeleteUserbutton)
    $Form.Controls.Add($CreateGroupbutton)
    $Form.Controls.Add($RenameGroupbutton)
    $Form.Controls.Add($RenameUserbutton)
    $Form.Controls.Add($RegisterNewUserbutton)
    $form.Controls.Add($GrpListbutton)
    $Form.Controls.Add($Hierarchicalbutton)
    $Form.Controls.Add($AddGroupMembersMbutton)
    $Form.Controls.Add($CertifyUserbutton)
    $Form.Controls.Add($RemoveGroupbutton)
    $Form.Controls.Add($RemoveGroupsbutton)
    $Form.Controls.Add($ChangeDBSizebutton)
    $form.Controls.Add($pictureBox)
    
    $form.ShowDialog()
    }
 MainWFDomMenu