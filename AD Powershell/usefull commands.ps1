#this line gets the computers IP Address
#Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Format-Table -Property IPAddress


#this line gets the username that is logged into target computer
#Get-WmiObject -Class Win32_ComputerSystem -Property UserName -ComputerName CLUK-OS-W0001 


#this line gets the make and model of current computer(also name)
#Get-WmiObject -Class Win32_ComputerSystem


#restarts the current PC
#(Get-WmiObject -Class Win32_OperatingSystem -ComputerName .).Win32Shutdown(2)


#gets the IP of current computer
#Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter IPEnabled=TRUE -ComputerName . | Format-Table -Property IPAddress


#shutdown a target machine
#Start-Sleep 60; Restart-Computer –Force –ComputerName TARGETMACHINE


#allows powershell to run anything
#Set-ExecutionPolicy Unrestricted


#gets the event log a selected log
#Get-EventLog -Log "Application"


#gets BIOS information
#Get-CimInstance -ClassName Win32_BIOS -ComputerName CLUK-OS-W0001


#logon session information 
#Get-CimInstance -ClassName Win32_LogonSession -ComputerName CLUK-OS-W0001



#user name and password
#$name = Read-Host 'What is your username?'
#$pass = Read-Host 'What is your password?' -AsSecureString


#lists the computers properties
#Get-ADComputer CLUK-OS-W0028 -Properties *

#adding the @() fixes an issue in powershell when getting a datasource 
#$WindowsVersionComboBox1.DataSource = @($Secondlist)

Get-ADUser -filter "name -like 'dar*'" | select name,sid