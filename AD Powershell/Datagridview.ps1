function test1 {
    test
}
function test {
Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Collections

$row1 = Get-ADUser -Filter * -Properties * -SearchBase "ou=accounts,ou=administration,ou=f1,ou=ts tech users,dc=smallhome,dc=local" | select-object name,lastlogondate,whencreated,passwordlastset,enabled

$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(800,650)
$form.Text='User Info'

#$tableData = New-Object System.Collections.ArrayList
#$tableData.AddRange($row1)

#$datagridview.DataBindings.DefaultDataSourceUpdateMode = 0 
#$datagridview.DataSource= $TableData
#$datagridview.Refresh()
$dataGridView = New-Object System.Windows.Forms.DataGridView -Property @{
    Size = New-Object System.Drawing.Size(650, 400)
    Location = New-Object System.Drawing.Size(1, 10)
    ColumnHeadersVisible = $True
    DataSource = $row1
    AutoSizeColumnsMode = 'AllCells'
    ColumnHeadersHeightSizeMode = 'AutoSize'
}  
#$dataGridView.Columns[0].SortMode = DataGridViewColumnSortMode.automatic
<#
$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(135,450)
$Button.Size = New-Object System.Drawing.Size(120,25)
$Button.Text = "Show Dialog Box"
$Button.Add_Click({
    $dataGridView.DataSource = $null
    #$dataGridView.Rows.Clear()
    $row1 = Get-ADUser -Filter * -Properties * -SearchBase "ou=execs,ou=administration,ou=f1,ou=ts tech users,dc=smallhome,dc=local" | select-object name,lastlogondate,whencreated,passwordlastset,enabled
    $dataGridView.DataSource=$row1})
#>
$Form.Controls.Add($dataGridView)
$Form.Controls.Add($Button)
  
$Form.ShowDialog()

}
test1