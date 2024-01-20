Function MakeNewForm {
	MakeForm
    $Form.Close()
	$Form.Dispose()
	
}
function Makeform {
$form = New-Object System.Windows.Forms.Form
$form.Size = New-Object System.Drawing.Size(720,650)
$dataGridView = New-Object System.Windows.Forms.DataGridView
$dataGridView.Size=New-Object System.Drawing.Size(703,350)
$form.Text='User Info'
#$form.FormBorderStyle='Fixeddialog'
$form.Controls.Add($dataGridView)
$dataGridView.ColumnCount = 5
$dataGridView.ColumnHeadersVisible = $true
$dataGridView.Columns[0].Name = "UserName"
$dataGridView.Columns[1].Name = "lastlogondate"
$dataGridView.Columns[2].Name = "Date Acc Created"
$dataGridView.Columns[3].Name = "PWD Last Set"
$dataGridView.Columns[4].Name = "Enabled"
$global:dept="accounts"
$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(135,450)
$Button.Size = New-Object System.Drawing.Size(120,25)
$Button.Text = "Show Dialog Box"
$Button.Add_Click({$global:dept="execs"})
$Form.Controls.Add($Button)

$row1 = Get-ADUser -Filter * -Properties * -SearchBase "ou=$($global:dept),ou=administration,ou=f1,ou=ts tech users,dc=smallhome,dc=local" | select-object name,lastlogondate,whencreated,passwordlastset,enabled
foreach ($row in $row1)
{    
[void]$dataGridView.Rows.Add($row.name,$row.lastlogondate,$row.whencreated,$row.passwordlastset,$row.enabled)
}
$form.ShowDialog()
}
MakeNewform