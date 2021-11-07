$a=Get-EventLog Security | where{$_.EventID -eq 4801} | select -ExpandProperty message
$a.substring(60,69) | out-file c:\accname.txt
#test