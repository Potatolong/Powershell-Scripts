Get-EventLog -list | 
where {$_.logdisplayname -eq `
"security"} | fl *