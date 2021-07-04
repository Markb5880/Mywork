Get-ADUser -filter * -Properties lastlogondate | select name,lastlogondate,sid | sort lastlogondate,`
name | Out-File c:\lastlogon.txt