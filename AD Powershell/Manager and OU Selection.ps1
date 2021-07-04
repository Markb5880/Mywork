$g=(get-aduser (get-aduser $user -Properties manager).manager).samaccountName

#Get a Users OU Location

$user1 = Get-ADUser -Identity $user

$userOU = ($user1.DistinguishedName -split ",",2)[-1]

$userOU

#Get just the user name from a distinguished name

Get-ADUser -Identity ncahill -Properties manager |
Select-Object -Property @{label='Manager';expression={$_.manager -replace '^CN=|,.*$'}}

#Who's Manager belongs to who?
$M=get-aduser -Filter * -Properties manager | where {$_.Manager -ne $null} |Select-Object -Property @{label='Manager';expression={$_.manager -replace '^CN=|,.*$'}} | sort manager | Get-Unique -AsString

# OU LIST
$OUList=Get-ADOrganizationalUnit -Filter * -Properties distinguishedname

foreach ($OU in $OUList){
$OU=$OUList.name
}

$p=Get-ADUser -Filter * -Properties Name,SamAccountName,AccountExpirationDate,Manager | select Name,SamAccountName,AccountExpirationDate,@{N='Manager';E={(Get-ADUser $_.Manager).sAMAccountName}}
if ($p.manager -ne $null)
{
sort $p.manager | Get-Unique -AsString
$p.manager
}
if ($p.manager -eq $null)
{
$p.manager="1"
}
#Manager Combo Box

# Create Mainform
function do-it {
    $form=New-Object System.Windows.Forms.Form
    $form.topmost=$true
    $form.Text="New Active Directory User Form."
    $form.Location.X=300
    $form.Location.Y=300
    $form.Size=New-Object System.Drawing.Size(650,500)

    $MgrTextBox1=New-Object System.Windows.Forms.textbox
    $MgrTextBox1.Location=New-Object System.Drawing.Size(5,150)
    $MgrTextBox1.size=New-Object System.Drawing.Size(520,24)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",9,[System.Drawing.FontStyle]::regular)
    $MgrTextbox1.Font=$FontFace
    
    $ComboBox1=New-Object System.Windows.Forms.Combobox
    $ComboBox1.Location=New-Object System.Drawing.Size(5,75)
    $ComboBox1.size=New-Object System.Drawing.Size(80,24)
    $FontFace = New-Object System.Drawing.Font(
    "Comic Sans MS",11,[System.Drawing.FontStyle]::regular)
    $Combobox1.font=$fontface
   # $Managersam=(get-aduser (get-aduser bpatz -Properties manager).manager).samaccountName

    #$Managers=get-aduser -Filter * -Properties manager | Where-Object {$_.Manager -ne $null} | Select-Object -Property @{label='Manager';expression={$_.manager -replace '^CN=|,.*$'}} | sort manager | Get-Unique -AsString
    $Managers1=get-aduser -Filter * -Properties manager | Where-Object {$_.Manager -ne $null} | Select-Object -Property @{label='Manager';expression={$_.manager}} | sort manager | Get-Unique -AsString
    
    $m=@()
    $man=@()
      
    for ($i=0;$i -lt $Managers1.Count; $i++){
    $m+=get-aduser $Managers1.manager[$i]

    $Combobox1.items.Add($m.samaccountname[$i])
    }
    $ComboBox1.SelectedIndex=1
    if ($combobox1.SelectedIndex -gt -1) {
    $ComboBox1_SelectedIndexChanged
    
    $user1 = Get-ADUser -Identity $ComboBox1.SelectedItem

    $ManOU = ($user1.DistinguishedName -split ",",2)[-1]
    
    $MgrTextBox1.Text=$ManOU
    $ComboBox1.add_SelectedIndexChanged($ComboBox1_SelectedIndexChanged)

    $form.Controls.Add($MgrTextBox1)
    $form.controls.add($ComboBox1)
    $form.ShowDialog()
    }}
do-it