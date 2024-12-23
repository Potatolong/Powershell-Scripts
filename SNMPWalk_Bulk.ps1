#Load Windows forms for OpenFileDialog

Add-Type -AssemblyName System.Windows.Forms

#Create OpenFileDialog to select Input txt

$openFileDialog = New-Object System.Windows.Forms.OpenFileDialog
$openFileDialog.Filter = "Text Files (*.txt) | *.txt"
$openFileDialog.Title = "Select a text file containing IP addresses"

#Show OpenFileDialog 

if($OpenFileDailog.ShowDialog() -eq "OK") {
	$filePath = $OpenFileDialog.FileName
	Write-Host "File selected: $filePath"
} else {
	Write-Host "No file selected. Exiting."
	exit
}

#Ensure filePath is not empty.

if ([string]::IsNullOrWhiteSpace($filePath)) {
	Write-Hosts "No file path provided. Exiting script."
	exit
}

#Get SNMP version from User
$validVersion = @('1', '2c', '3')
$version = $null
while ($version -eq $null) {
	$inputVersion = Read-Host "Enter SNMP version (1, 2c, or 3)"
	if ($validVersion -contains $inputVersion) {
		$version = $inputVersion
		Write-Host "SNMP version set to: $version"
	} else {
		Write-Host "Invalid SNMP version entered. Please enter 1, 2c, or 3."
	}
}

#Get cstring from user. 

$CommunityString = Read-Host "Please enter the community string (e.g. private, public)"

#Read IPs from file 

$ipAddresses = Get-Content -Path $filePath
Write-Host "IP address loaded. Total count: $($ipAddressess.count)"

#CSV Output File 
currentDate = Get-Date -Format "yyyyMMdd_HH_mm"
$outputcsv = "SNMP_Bulk_Test_Output_$currentDate.csv"
$results = @()

foreach ($ip in $ipAddressess) {
	$scriptBlock = {
		param($ip, $version, $communityString)
#Please be sure to put the correct file path that SNMPWalk.exe has been saved to in order for this to work.
		"C:\<PLEASE INSERT THE FILE PATH FOR SNMPWALK.EXE>\SnmpWalk.exe -v:$version -c:$communityString -r:$ip 2>&1"
}
	$job = Start-Job -ScriptBlock $scriptBlock -ArgumentList $ip, $version, $communityString
	$finished = Wait-Job -Job $job -Timeout 8 
	if ($finished) {
		$job_output = Receive-Job $job
		$resultText = "$communityString is disabled"
	} else {
		$resultText = "$communityString is enabled"
		$job_output = Receive-Job -Job $job
	}
	Remove-Job -job $job -Force 
	$results += [PSCustomObject]@{
		IP = $IP
		CommunityString = $resultText
		Output_value = [string]$job_output[2..5]
	}
}

#Export results to CSV. Please be sure to put the correct file path to save the results.

$results | Export-Csv -Path "C:\<PLEASE PUT THE FILE PATH TO EXPORT>\$outputCsv" -NoTypeInformation

Write-Host "Results saved to $outputCsv"
