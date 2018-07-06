

$date = (Get-Date).adddays(-2)
(New-Object `
system.diagnostic.eventlog `
("security", "server02")).entries |
where {$_.timewritten -gt $date} | 
out-file C:\Users\Potat\Documents\Powershell_Script\Security.txt

