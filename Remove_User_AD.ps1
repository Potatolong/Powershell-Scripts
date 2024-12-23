# Single use case, not bulk.
# Import Active Directory module (if not already imported)
Import-Module ActiveDirectory

# Prompt for the username (SamAccountName) to delete
$userName = Read-Host "Enter the username (SamAccountName) of the user to remove"

# Check if the user exists in AD
$user = Get-ADUser -Identity $userName -ErrorAction SilentlyContinue

if ($user) {
    # Ask for confirmation before removing the user
    $confirmation = Read-Host "Are you sure you want to delete user $userName? (Y/N)"
    
    if ($confirmation -eq 'Y') {
        try {
            # Remove the user from Active Directory
            Remove-ADUser -Identity $userName -Confirm:$false
            Write-Host "User $userName has been successfully removed from Active Directory." -ForegroundColor Green
        }
        catch {
            Write-Host "Error: $_" -ForegroundColor Red
        }
    }
    else {
        Write-Host "User removal canceled." -ForegroundColor Yellow
    }
}
else {
    Write-Host "User $userName not found in Active Directory." -ForegroundColor Red
}
