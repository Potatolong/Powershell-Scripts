#Trying out controllers 

Get-CustomerRecord | 
Where-Object { $_.LastActivity -lt (Get-Date).AddDays(-365) } | 
ConvertTo-HTML | 
Out-File \\intranet\www\reports\inactive-customers.html