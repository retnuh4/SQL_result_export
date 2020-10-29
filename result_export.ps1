$database = "DB_name"
$server = "ServerName" 
$result = Read-Host "csv = 1 | txt = 2"


if (Get-Module -ListAvailable -Name SqlServer) {
    Write-Host "Module installed.. moving on"
} 
else {
    Write-Host "Installing sqlServer Module"
    Install-Module -Name SqlServer -AllowClobber
}

$inputF= Read-Host "file path (quotes around path for txt results) of input file"
$outputF = Read-Host "file path and new file name (quotes around path for txt results) of output file ex: C:\Documents\resultsfile.txt"
#$fileName = Read-Host "File Name?"
#$finaldest = "$outputF - $fileName"

#NOSQLPS
Import-Module -Name SqlServer

if ($result -eq 1) {Invoke-Sqlcmd -Database $database -ServerInstance $server -InputFile $inputF | ConvertTo-Csv -NoTypeInformation | select -Skip 1 | Out-File -LiteralPath $outputF -Force -Encoding utf8
Write-Host "File placed in export destination"}
elseif ($result -eq 2) {sqlcmd -S $server -d $database -E -i $inputF -s '|' -W -h-1 -m 1 -o $outputF
Write-Host "File placed in export destination"}
else {"result selection was not 1 or 2.."}
#Write-Host $finaldest
#sqlcmd -S $server -d $database -E -i $inputF -s '|' -W -h-1 -m 1 -o $outputF
#Write-Host "File placed in export destination"

#Sqlcmd -S $server -d $database -E -i $inputF -s "," -W -w 250 -h-1 -m 1 -o $outputF