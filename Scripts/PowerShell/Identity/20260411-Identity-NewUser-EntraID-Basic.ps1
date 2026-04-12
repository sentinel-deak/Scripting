<#
This is a basic script for creating a new user in Entra ID (formerly Azure AD) using Microsoft Graph PowerShell SDK.
It's a starting point and needs refinement for security, automation, error handling, and logging.
Future improvements: automate input, generate secure passwords, add to groups, etc.
#>

# Check if Microsoft.Graph.Users module is installed, install if not
# Might want to add this type of a section to the Basic AD script as well
if (-not (Get-Module -Name Microsoft.Graph.Users -ListAvailable)) {
    Write-Host "Installing Microsoft.Graph.Users module..." -ForegroundColor Yellow
    Install-Module -Name Microsoft.Graph.Users -Scope CurrentUser -Force -AllowClobber
}

# Import the module
Import-Module Microsoft.Graph.Users -ErrorAction Stop

# Connect to Microsoft Graph (requires interactive authentication)
# NOTE: You need appropriate permissions (User.ReadWrite.All) in your app registration or admin consent
Connect-MgGraph -Scopes "User.ReadWrite.All" -ErrorAction Stop

# Prompt for user details -- this is very manual >>> eventually want to automate this 
$FirstName = Read-Host "Enter the user's first name"
$LastName = Read-Host "Enter the user's last name"

# Build account properties -- very simplistic >>> eventually add checks for uniqueness, add logging, add error handling, make sure domain info and OU path is not hardcoded, etc
$Username = "$FirstName.$LastName".ToLower()
$DisplayName = "$FirstName $LastName"
$UserPrincipalName = "$Username@yourdomain.onmicrosoft.com"  # Replace with your actual domain
$Password = "TempPass123!"  # Temporary password (must meet complexity requirements) -- far too simple and insecure >>> eventually want to generate a random password and securely store it for the initial creation, then prompt the user to change it on first login

# Password profile for Entra ID
$PasswordProfile = @{
    Password                      = $Password
    ForceChangePasswordNextSignIn = $true
}

# Create the new user -- solid starting point >>> eventually want more properties, add error handling, and add logging
try {
    New-MgUser -DisplayName $DisplayName `
               -GivenName $FirstName `
               -Surname $LastName `
               -UserPrincipalName $UserPrincipalName `
               -MailNickname $Username `
               -PasswordProfile $PasswordProfile `
               -AccountEnabled $true

    Write-Host "User $UserPrincipalName created successfully!" -ForegroundColor Green
} catch {
    Write-Host "ERROR creating user: $($_.Exception.Message)" -ForegroundColor Red
}