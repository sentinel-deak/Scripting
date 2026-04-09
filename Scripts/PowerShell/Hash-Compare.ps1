# Version: 1.4
	# Changes:
		# The script will search for the most recently downloaded ISO file in my Downloads folder
			# the file type and search location can be adjusted as needed, the above is just the current configuration
		# The 2nd text file is no longer needed for completion
		# The script will prompt the user for the correct algorithm and hash for comparison purposes		
# Date: 20250610
# Author: Quell
# Purpose: Increase speed for hash comparisons of downloaded files

# Define Variables
$directoryPath = "C:\Users\Cory\Downloads"
$fileExtension = "*.iso"
$newestFile = Get-ChildItem -Path $directoryPath -Filter $fileExtension | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$filePath = "$directoryPath\$newestFile"
$algo = Read-Host "Please enter the appropriate hash algorithm"
$hash = Read-Host "Please enter the known-good hash for comparison"

# Visual confirmation the correct file is being compared
Write-Host "The newest $fileExtension file is: $newestFile"

# Compare hashes
(Get-FileHash -Path "$filePath" -Algorithm "$algo").Hash -eq "$hash"


# ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

# Version: 1.3
	# Changes:
		# The script now finds the most recently downloaded ISO file from my Downloads folder and then compares the hash value in the text file "holder"
			# Currently, set up as described above, however, the script can be quickly adjusted for any file type in any location for hash comparison
		# Adjusted text file being used since the $FilePath variable from previous versions is being changed
		# Adjusted capitalization for variables for consistency
		# Adjusted Purpose of script
# Date: 20250610
# Author: Quell
# Purpose: Increase speed for hash comparisons of downloaded iso files

# Define Variables
# $directoryPath = "C:\Users\Cory\Downloads"
# $fileExtension = "*.iso"
# $newestFile = Get-ChildItem -Path $directoryPath -Filter $fileExtension | Sort-Object LastWriteTime -Descending | Select-Object -First 1
# $filePath = "$directoryPath\$newestFile"
# $algo = Get-Content "C:\Users\Cory\OneDrive\Scripts\HashCompareInfo.txt" | Select-Object -First 1
# $hash = Get-Content "C:\Users\Cory\OneDrive\Scripts\HashCompareInfo.txt" | Select-Object -Skip 1 -First 1

# Visual confirmation the correct iso is being compared
# Write-Host "The newest iso file is: $newestFile"

# Script to compare hashes
# (Get-FileHash -Path "$filePath" -Algorithm "$algo").Hash -eq "$hash"


# ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

# Version: 1.2
	# Changes:
		# The script reads a text file that contains the variable values to reduce the need to input the variable values in the text file "holder" and the script
# Date: 20250606
# Author: Quell
# Purpose: Compares Hashes

# Define Variables
# $FilePath = Get-Content "C:\Users\Cory\OneDrive\Scripts\HashCompareInfo.txt" | Select-Object -First 1
# $Algo = Get-Content "C:\Users\Cory\OneDrive\Scripts\HashCompareInfo.txt" | Select-Object -Skip 1 -First 1
# $Hash = Get-Content "C:\Users\Cory\OneDrive\Scripts\HashCompareInfo.txt" | Select-Object -Skip 2 -First 1

# Script to compare hashes
# (Get-FileHash -Path "$FilePath" -Algorithm "$Algo").Hash -eq "$Hash"


# ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

# Version: 1.1
	# Changes:
		# Adding variable to allow any algorithm to be used for hash comparison (SHA256 is expected to be the most common)
# Date: 20250605
# Author: Quell
# Purpose: Compares Hashes

# Define Variables
# $FilePath = Read-Host "Please enter the full downloaded file path"
# $Algo = Read-Host "Please enter the Algorithm to use for hash comparison"
# $Hash = Read-Host "Please enter the correct hash from the source"

# Script to compare hashes
# (Get-FileHash -Path "$FilePath" -Algorithm "$Algo").Hash -eq "$Hash"


# ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

# Version: 1.0
# Date: 20250605
# Author: Quell
# Purpose: Compares Hashes

# Define Variables
# $FilePath = Read-Host "Please enter the full downloaded file path"
# $Hash = Read-Host "Please enter the correct hash from the source"

# Script to compare hashes
# (Get-FileHash "$FilePath").Hash -eq "$Hash"