Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
Add-Type -AssemblyName PresentationFramework

Function MakeNewForm {
	
    $Form.Close()
	$Form.Dispose()
	checkedtwo
}
function checkedtwo {
Clear-Host

#   Create a New Form
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="User Details Selection List"
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
    $Grouplbl1.text="AD User List"
# AN INSTANCE OF THE LISTVIEW CLASS IS CREATED (THIS IS THE LISTVIEW CONTROL)       
    $Listview = New-Object System.Windows.Forms.ListView 
    $Listview.Location = New-Object System.Drawing.Size(3,25)
    $Listview.Size = New-Object System.Drawing.Size(550,256)
    $Font = New-Object System.Drawing.Font("Tahoma",8,[System.Drawing.FontStyle]::regular)
    $Listview.Font=$Font
    $Listview.CheckBoxes=$true
    $Listview.Name="Main"
    $Listview.AutoArrange=$true
    $Listview.GridLines=$true
    $Listview.MultiSelect=$false
    $listView.View = "details"
    $Listview.backcolor = "Black"
    $Listview.forecolor = "LightGreen"
    $Listview.FullRowSelect =$false

    $ChangeDBSizebutton2=New-Object System.Windows.Forms.Button
    $ChangeDBSizebutton2.Location = New-Object System.Drawing.Size(575,40)
    $ChangeDBSizebutton2.Size = New-Object System.Drawing.Size(45,55)
    $ChangeDBSizebutton2.BackColor="DarkBlue"
    $ChangeDBSizebutton2.ForeColor="White"
    $ChangeDBSizebutton2.Text = "Go"

    # Populate the User CheckboxList
    [void]$listView.Columns.Add("Name")
    [void]$listView.Columns.Add("JobTitle")
    [void]$listView.Columns.Add("Department")
    [void]$listView.Columns.Add("Email Address")
    $listView.Columns[0].Width = -2
    $listView.Columns[1].Width = -2
    $listView.Columns[2].Width = -2
    $listView.Columns[3].Width = -2
    $AllADUsers=Get-ADUser -Filter * -Properties Name,title,department,mail -SearchBase "OU=TS Tech Users,DC=smallhome,DC=local" |`
    sort name | select name,title,department,mail
    ForEach ($User in $AllADUsers)
    {
        $un=$user.Name
        $jt=$user.title
        $de=$user.Department
        $em=$user.mail
        $listView.items.add($un).SubItems.AddRange(($jt,$de,$em))
        
    }
    
    
    $Listview_ItemSelectionChanged={
        if ($Listview.SelectedItems.count -eq 0){return}
        
        $selection=$Listview.SelectedItems.Text
        [System.Windows.MessageBox]::Show("$selection has been selected.",'New Group Additions','OK','Information')
        
        }
    $Listview.add_ItemSelectionChanged($Listview_ItemSelectionChanged)
    $once=0
    
    $form.Controls.Add($ChangeDBSizebutton2)
    $form.Controls.add($Listview)
    
$form.ShowDialog()
}
checkedtwo