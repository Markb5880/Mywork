<#
Mark Baker 16th January 2024
Functions: test1 and test look after the flow of the form code
           Allrows look after the lower level child OU's where the usernames are
           SetupDataWithIndex looks after clearing the datasource Var row1 and re-initialising the arraylist
           Sets the relative variables and indexes and re-applies the new row1 data called from the Allrows function and points datasource back to the datatable fir viewing
           with Variable $DataGridView
Buttons:   All the buttons set an index and call the function SetupDatawithIndex, so the data changes on each refresh
Here String: $ouacc sets the accountname and the index is used to insert the correct string as part of the Searchbase parameter

The $script:{Variable} sets the scope in which the variable is used, else the functions would not be able to see it. $global can be used if linking scripts together.

This took me 3 larger revisions to get it to this stage, You could amend this code to pick out computers & their properties from relevant OU's
maybe separately or as part of a larger script.
#>
function test1 {
    test
}
function Allrows {
    $script:row1 = Get-ADUser -Filter * -Properties * -SearchBase "ou=$ou,ou=administration,ou=f1,ou=ts tech users,dc=smallhome,dc=local" | select-object name,lastlogondate,whencreated,passwordlastset,enabled | Sort-Object name    
}
function SetupDataWithIndex {
    $dataGridView.DataSource = $null
    $tableData = New-Object System.Collections.ArrayList
    $script:ou=$($script:accou[$script:i])
    Allrows
    $tableData.AddRange($row1)
    $dataGridView.DataSource=$tableData    
}
function test {
Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Collections

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(650,550)
$form.Text='User Info'

$ButtonX = New-Object System.Windows.Forms.Button
$ButtonX.Location = New-Object System.Drawing.Size(500,415)
$ButtonX.Size = New-Object System.Drawing.Size(70,32)
$ButtonX.Text = "All"
$ButtonX.Add_Click({
    $dataGridView.DataSource = $null
    $tableData = New-Object System.Collections.ArrayList
    $row1 = Get-ADUser -Filter * -Properties * -SearchBase "ou=administration,ou=f1,ou=ts tech users,dc=smallhome,dc=local" | Select-Object cn,company,department,lastlogondate,passwordlastset,enabled | Sort-Object cn
    $tableData.AddRange($row1)
	$dataGridView.DataSource=$tableData})

$dataGridView = New-Object System.Windows.Forms.DataGridView -Property @{
    Size = New-Object System.Drawing.Size(625, 400)
    Location = New-Object System.Drawing.Size(1, 10)
    ColumnHeadersVisible = $True
    DataSource = $tableData
    AutoSizeColumnsMode = 'AllCells'
    ColumnHeadersHeightSizeMode = 'AutoSize'
	RowHeadersVisible=$True
}
$script:accou=@(
    'Accounts'
    'engineering'
    'execs'
    'Facilities'
    'HR'
    'IT'
    'MS'
    'New Business'
    'Procurement'
    'Production'
    'QA'
    'Sales' 
)
$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(70,415)
$Button.Size = New-Object System.Drawing.Size(70,32)
$Button.Text = "Accounts"
$Button.Add_Click({
    $script:i=0
    SetupDataWithIndex
    })

$Button1 = New-Object System.Windows.Forms.Button
$Button1.Location = New-Object System.Drawing.Size(70,450)
$Button1.Size = New-Object System.Drawing.Size(73,32)
$Button1.Text = "Engineering"
$Button1.Add_Click({
    $script:i=1
    SetupDataWithIndex	
})

$Button2 = New-Object System.Windows.Forms.Button
$Button2.Location = New-Object System.Drawing.Size(135,415)
$Button2.Size = New-Object System.Drawing.Size(70,32)
$Button2.Text = "Execs"
$Button2.Add_Click({
    $script:i=2
    SetupDataWithIndex    
})

$Button3 = New-Object System.Windows.Forms.Button
$Button3.Location = New-Object System.Drawing.Size(144,450)
$Button3.Size = New-Object System.Drawing.Size(70,32)
$Button3.Text = "Facilities"
$Button3.Add_Click({
    $script:i=3
    SetupDataWithIndex
})

$Button4 = New-Object System.Windows.Forms.Button
$Button4.Location = New-Object System.Drawing.Size(206,415)
$Button4.Size = New-Object System.Drawing.Size(70,32)
$Button4.Text = "HR"
$Button4.Add_Click({
    $script:i=4
    SetupDataWithIndex
})

$Button5 = New-Object System.Windows.Forms.Button
$Button5.Location = New-Object System.Drawing.Size(215,450)
$Button5.Size = New-Object System.Drawing.Size(60,32)
$Button5.Text = "IT"
$Button5.Add_Click({
    $script:i=5
    SetupDataWithIndex
})

$Button6 = New-Object System.Windows.Forms.Button
$Button6.Location = New-Object System.Drawing.Size(277,415)
$Button6.Size = New-Object System.Drawing.Size(70,32)
$Button6.Text = "MS"
$Button6.Add_Click({
    $script:i=6
    SetupDataWithIndex
})

$Button7 = New-Object System.Windows.Forms.Button
$Button7.Location = New-Object System.Drawing.Size(277,450)
$Button7.Size = New-Object System.Drawing.Size(71,32)
$Button7.Text = "New Business"
$Button7.Add_Click({
    $script:i=7
    SetupDataWithIndex
})

$Button8 = New-Object System.Windows.Forms.Button
$Button8.Location = New-Object System.Drawing.Size(349,415)
$Button8.Size = New-Object System.Drawing.Size(81,32)
$Button8.Text = "Procurement"
$Button8.Add_Click({
    $script:i=8
    SetupDataWithIndex
})

$Button9 = New-Object System.Windows.Forms.Button
$Button9.Location = New-Object System.Drawing.Size(425,415)
$Button9.Size = New-Object System.Drawing.Size(81,32)
$Button9.Text = "Production"
$Button9.Add_Click({
    $script:i=9
    SetupDataWithIndex
})

$ButtonA = New-Object System.Windows.Forms.Button
$ButtonA.Location = New-Object System.Drawing.Size(349,450)
$ButtonA.Size = New-Object System.Drawing.Size(81,32)
$ButtonA.Text = "QA"
$ButtonA.Add_Click({
    $script:i=10
    SetupDataWithIndex
})

$ButtonB = New-Object System.Windows.Forms.Button
$ButtonB.Location = New-Object System.Drawing.Size(425,450)
$ButtonB.Size = New-Object System.Drawing.Size(81,32)
$ButtonB.Text = "Sales"
$ButtonB.Add_Click({
    $script:i=11
    SetupDataWithIndex
})

$Form.Controls.Add($dataGridView)
$Form.Controls.Add($Button)
$Form.Controls.Add($Button1)
$Form.Controls.Add($Button2)
$Form.Controls.Add($Button3)
$Form.Controls.Add($Button4)
$Form.Controls.Add($Button5)
$Form.Controls.Add($Button6)
$Form.Controls.Add($Button7)
$Form.Controls.Add($Button8)
$Form.Controls.Add($Button9)
$Form.Controls.Add($ButtonA)
$Form.Controls.Add($ButtonB) 
$Form.Controls.Add($ButtonX) 
$Form.ShowDialog()

}
test1