$TargetFolder = "<network drive>";
$RemoveThisPath = "<path>";
$TotalSize = 0;
$Threshold = 80;

$FolderItems = Get-ChildItem $TargetFolder
foreach ($i in $FolderItems)
{
	$GetSize = Get-ChildItem $i.FullName -recurse -force | Where-Object {$_.PSIsContainer -eq $false} | Measure-Object -property Length -sum | Select-Object Sum
	$TotalSize = $TotalSize + $GetSize.sum / 1MB
}
$TargetFolder + " = " + "{0:N2}" -f ($TotalSize) + "MB" 

if ($TotalSize -ge $Threshold)
{
	'Capacity Exceeded'
	Remove-Item -path "$RemoveThisPath" -Force -Recurse
}
else
{
	'Free Space Available'
}