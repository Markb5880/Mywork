# Set-ExecutionPolicy -Scope CurrentUser
$Mc_BuildName=Get-WmiObject win32_computersystem
$Mc_OS=Get-WmiObject Win32_OperatingSystem
$Manufacturer=$Mc_Buildname.Manufacturer
$Model=$Mc_BuildName.Model
$MC_Name=$Mc_BuildName.Name
$MC_OS=$Mc_OS.caption
$body = @"
Manufacturer:$Manufacturer<br/>
Model:$Model<br/>
Name:$MC_Name<br/>
OS:$Mc_OS <br/>
"@
$installedAppsList=Get-Ciminstance Win32_Product | select name, Version | sort name | out-file C:\installedapslist.txt
$attachment="C:\installedapslist.txt"
Send-MailMessage -From "administrator" -To "administrator" -Subject "Columbus Machine Build Complete" -Bodyashtml $body -SmtpServer "Dom-01/smallhome" -Attachments $attachment