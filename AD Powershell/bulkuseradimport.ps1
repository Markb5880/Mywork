Import-module activedirectory
Add-Type -AssemblyName "System.Drawing"
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName System.Windows.Forms
    $OpenFile=New-Object System.Windows.Forms.OpenFileDialog
function BulkADUserImport {
      $Parameters=@{}
      ForEach($User in $Users)
            {
      $Script:Processedusers +=1
      #$textlbl2.text="Processing Record Number:$Processedusers"  
       #     Clear-Host
      $Password = (ConvertTo-SecureString -AsPlainText $User.password -Force)
      $UserPrincipalName=$User.sAMAccountName+"@"+$User.Company
      $Parameters=@{
            Name=$user.Name
            AccountPassword=$Password
            GivenName=$user.GivenName
            Surname=$User.sn
            SamAccountName=$user.sAMAccountName
            Company=$User.Company
            Title=$User.Title
            State=$User.State
            Department=$User.Department
            Displayname=$User.Displayname
            country=$User.country
            path=$User.DistinguishedName
       #     Manager=$User.Manager
            Initials=$User.Initials   
            StreetAddress=$User.StreetAddress 
            OfficePhone=$User.'Telephone-Number' 
            UserPrincipalName=$UserPrincipalName
            EmailAddress=$UserPrincipalName
            enabled=$true
      }
      
      New-ADUser @Parameters
      
      #$textlbl2.update()
                  }
      
}    

# Create a New Form
$form=New-Object System.Windows.Forms.Form
$form.topmost=$true
$form.Text="Bulk Import of Active Directory Users."
$form.Location.X=25
$form.Location.Y=75
$form.Size=New-Object System.Drawing.Size(400,300)
#Now Lock the form so it cannot be re-sized.
$Form.MaximumSize=New-Object System.Drawing.Size(400,300)
$Form.MinimumSize=New-Object System.Drawing.Size(400,300)
# Display an Image on a form
$image = [System.Drawing.Image]::Fromfile('C:\Users\administrator.smallhome\onedrive\Documents\adlogo.jpg')     
$pictureBox = new-object Windows.Forms.PictureBox  #--instantiates a PictureBox
$pictureBox.Image=$image
$pictureBox.Location = New-object System.Drawing.Size(40,20)
$pictureBox.Width =  $image.Size.Width
$pictureBox.Height =  $image.Size.Height
$pictureBox.Image = $image
$pictureBox.Anchor = [System.Windows.Forms.AnchorStyles]::Bottom

# Draw OldUserName Text Label
$textlbl1=New-Object System.Windows.Forms.label
$textlbl1.Location=New-Object System.Drawing.Size(25,10)
$textlbl1.backcolor="Transparent"
$textlbl1.size=New-Object System.Drawing.Size(326,28)
$FontFace = New-Object System.Drawing.Font(
"Comic Sans MS",14,[System.Drawing.FontStyle]::Regular)
$textlbl1.Font=$FontFace
$textlbl1.text="Active Directory Bulk User Import:"

# Records Processed Text Label
$textlbl2=New-Object System.Windows.Forms.Label
$textlbl2.Location=New-Object System.Drawing.Size(50,170)
#$textlbl2.backcolor="Transparent"
$textlbl2.size=New-Object System.Drawing.Size(225,21)
$FontFace = New-Object System.Drawing.Font(
"Comic Sans MS",10,[System.Drawing.FontStyle]::Regular)
$textlbl2.Font=$FontFace

# Add an 'Rename User' Button    
$Importbutton=New-Object System.Windows.Forms.Button
$Importbutton.Location = New-Object System.Drawing.Size(60,110)
$Importbutton.Size = New-Object System.Drawing.Size(70,40)
$Importbutton.Text = "Import Multiple New Users"
$Importbutton.forecolor = "Green"
$Importbutton.add_click({    
      $OpenFile.Filter = "CSV Files (*.csv)|*.csv"
      $OpenFile.SupportMultiDottedExtensions = $true;
      $OpenFile.InitialDirectory = "C:\temp\"
      $OpenFile.title="Choose Bulk User Input CSV File"
      $OpenFile.ShowDialog()
      $OpenFile.FileName
  # Line above is where the actual FileName is Picked!
  # The Contents of the above Picked FileName is now pulled in the $Users Variable
  # For Processing.
  $Users=Import-Csv $OpenFile.filename
  
Try {

BulkADUserImport
[System.Windows.MessageBox]::Show("SUCCESS - $Processedusers User(s) records have been Added To Active Directory!",'Bulk user Import','OK','Information')
}
Catch {
[System.Windows.MessageBox]::Show('There has Been an Error, Records may already exist, there maybe an error in the input file or the Domain Controller does not exist!','Input Error','OK','Error')
}
    })
$Form.Controls.Add($Importbutton)

# Add an 'EXIT' Button    
$Exitbutton=New-Object System.Windows.Forms.Button
$Exitbutton.Location = New-Object System.Drawing.Size(275,110)
$Exitbutton.Size = New-Object System.Drawing.Size(50,40)
$Exitbutton.Text = "Exit"
$Exitbutton.ForeColor="Red"
$Exitbutton.add_click({$Form.Close()})

$Form.Controls.Add($Exitbutton)
#$form.Controls.Add($textbox1)
$form.Controls.Add($textlbl1)
#$form.Controls.Add($textlbl2)
$form.Controls.Add($pictureBox)
$form.ShowDialog()



