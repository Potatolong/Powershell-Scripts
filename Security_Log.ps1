Get-EventLog -list | 
Where {$_.logdisplayname -eq `
"security"}