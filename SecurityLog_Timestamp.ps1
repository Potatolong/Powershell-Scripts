*Getting time stamp logs from Security Event Log 

$date = (Get-Date).adddays(-1)
Get-EventLog security | 
where {$_.timewritten -gt $date}
