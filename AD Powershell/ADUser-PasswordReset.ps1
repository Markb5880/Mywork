Add-Type -AssemblyName "System.Windows.Forms"
Add-Type -AssemblyName "System.Drawing"
#[System.Reflection.Assembly]::LoadWithPartialName("System.Drawing.graphics")
Add-Type -AssemblyName PresentationFramework
$UserA=Get-ADUser -filter ('Name -like "daryl hannah"') -SearchBase "OU=TS Tech Users,DC=smallhome,DC=local"

Set-ADAccountPassword -Identity $user -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "$newPass" -Force)