function pass1 {
$r=-9
#param($r)
return $r
}

cls
pass1
$res=(pass1)[-1]
if ($res -gt 0){
Write-Output "$res is above 0"
}
if ($res -lt 0)
{
Write-Output "$res is below 0"
}
if ($res -eq 0)
{
Write-Output "$res is equal to 0"
}

