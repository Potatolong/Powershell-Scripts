$log = Get-EventLog -list | 
where {$_.logdisplayname -eq `
"security"}
$log.overflowaction