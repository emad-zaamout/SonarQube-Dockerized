# This PowerShell script is used to download and install SonarQube scanner on Windows

# Define temporary directory for downloads
$tmp_dir = "C:\Temp"

# Ensure the temporary directory exists
if (-not (Test-Path $tmp_dir)) {
    New-Item -Path $tmp_dir -ItemType Directory
}

# Define the directory where the scanner will be installed
$opt_dir = "C:\Program Files\SonarQubeScanner"

# Ensure the installation directory exists
if (-not (Test-Path $opt_dir)) {
    New-Item -Path $opt_dir -ItemType Directory
}

# Set the version for Windows
$scanner_version = "sonar-scanner-cli-5.0.1.3006-windows"

Write-Host "`n=============================`n`t$scanner_version`t`n=============================`n"

# Define the URL for downloading the SonarQube scanner
$download_url = "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${scanner_version}.zip"
Write-Host "`nDownloading the SonarQube scanner from: $download_url`n"

# Download the SonarQube scanner
Invoke-WebRequest -Uri $download_url -OutFile "$tmp_dir\$scanner_version.zip"

# Unzip the downloaded file to the installation directory
Expand-Archive -Path "$tmp_dir\$scanner_version.zip" -DestinationPath $opt_dir

# Remove the downloaded zip file
Remove-Item "$tmp_dir\$scanner_version.zip"

# Print a success message with the installation location
Write-Host "SonarQube scanner installed to $opt_dir\$scanner_version"
