<#TOP TIP: THIS MUST RUN UNDER POWERSHELL (X86), ELSE IT WILL NOT WORK!!
 
This Powershell Function was created in April 2020 by (myself) Mark Baker as 'a' just to see if I can de-mystify
some of the Domino Database stucture, after running short bits of code and using Get-Member on some parts
of it and looking at online code snippets and reading some of the online info from IBM I have come up with
the function below to Create Multiple Empty Domino Groups.

######
Last Upated: 05/04/2020 by MBaker

This takes a minimum of 2 groups to create

#####
This is how to use this function:

New-DominoGroup 2 ("TestBA,TestBB,TestBC")

The Group Count needs to be 1 less than the actual groups
AS THE ARRAYS ARE NUMBERED FROM [0]

Main use of this function is to connect to an IBM Domino Server and Create Multiple New Groups.
#>


Function New-DominoMultiGroups {

[cmdletbinding()]
        param (
        [parameter(Position=0,Mandatory=$true,ValueFromPipeline=$True)][int]$GroupCount,
        [parameter(Position=1,Mandatory=$true,ValueFromPipeline=$True)][string]$NewGroup
    )

cls
# Create Lotus Notes Object
$DomSession = New-Object -ComObject Lotus.NotesSession

# Initialize Lotus Notes Object
# "It'll use your open notes session and authentication Details"
$DomSession.Initialize()

# You need to have a members array of at least 2 strings, if creating an empty Group the 2 strings need to be empty!!

$members=@()
$members+=""
$members+=""

#Array to store the split groups in
$GrpOut=@()

if ($GroupCount -ge 1){

#Split the groups into the array as the AddGroupMembers method will only process one group at a time.
foreach ($NewGroups in $NewGroup) {
    $GrpOut+=$Newgroups.split("{,}")
    }
}
while ($GroupCount -ge 0){

# Use Method from Objects returned in variable $domsession one of which is CreateAdministrationProcess which
# takes a Server as input
$adminProcess = $Domsession.CreateAdministrationProcess("Dom-01/smallhome")

# The output properties will be to do with the Certifiers and Cert Authority, these need to be filled in as below
$adminProcess.CertifierFile="C:\Program Files\IBM\Lotus\Notes\Data\ids\cert.id"
$adminProcess.CertifierPassword="swindon"
$adminProcess.CertificateAuthorityOrg="/smallhome"

# If the 'CreateAdministrationProcess' executes with no error, the variable '$adminprocess' will contain another set of
# objects one of which is a method called 'AddGroupMembers' which takes 2 inputs: NewGroupName and a Members list
# which can be populated or empty. [See members array above].
$Notesid=$adminprocess.AddGroupMembers($GrpOut[$GroupCount],$($members))
[void]$Grpout[$GroupCount]
$GroupCount --
}}
New-DominoMultiGroups $GroupCount ("$NewGroup")