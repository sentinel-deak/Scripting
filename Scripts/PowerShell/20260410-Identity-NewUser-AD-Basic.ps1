<#
This is a starting point for my identity security journey on the scripting side -- it's, admittedly, a very basic script and needs plenty of refinement in terms of automated onboarding AND especially security considerations. It will be cool to see where this goes in the future after getting more comfortable with PowerShell.
#>

# Import Active Directory module
Import-Module ActiveDirectory -ErrorAction Stop

# Prompt for user details -- this is very manual >>> eventually want to automate this 
$FirstName = Read-Host "Enter the user's first name"
$LastName = Read-Host "Enter the user's last name"

# Build account properties -- very simplistic >>> eventually add checks for uniqueness, add logging, add error handling, make sure domain info and OU path is not hardcoded, etc
$Username = "$FirstName.$LastName".ToLower()
$DisplayName = "$FirstName $LastName"
$UserPrincipalName = "$Username@yourdomain.com"  # Replace with your domain
$OU = "OU=Users,OU=Company,DC=yourdomain,DC=com"  # Update this path!

# Set temporary password (must meet complexity requirements) -- far too simple and insecure >>> eventually want to generate a random password and securely store it for the initial creation, then prompt the user to change it on first login
$Password = ConvertTo-SecureString "TempPass123!" -AsPlainText -Force

# Create the new user -- solid starting point >>> eventually want more properties, add error handling, and add logging
try {
    New-ADUser -Name $DisplayName `
               -GivenName $FirstName `
               -Surname $LastName `
               -SamAccountName $Username `
               -UserPrincipalName $UserPrincipalName `
               -AccountPassword $Password `
               -ChangePasswordAtLogon $true `
               -Enabled $true `
               -Path $OU `
               -DisplayName $DisplayName

    Write-Host "✅ User $Username created successfully!" -ForegroundColor Green
} catch {
    Write-Host "❌ Error creating user: $($_.Exception.Message)" -ForegroundColor Red
}   