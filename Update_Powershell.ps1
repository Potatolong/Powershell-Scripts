#Updating powershell

#Check for version.

Write-Output "Checking for installed version, please hold:"

winget search Microsoft.PowerShell

#Silently updating powershell to v7.2 or Later

Write-Output "Installing updates, please wait:"

msiexec.exe /package PowerShell-7.3.1-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ADD_FILE_CONTEXT_MENU_RUNPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1 USE_MU=1 ENABLE_MU=1 ADD_PATH=1

#Quality Check 

Write-Output "Quality check to show version has been updated."

winget search Microsoft.PowerShell