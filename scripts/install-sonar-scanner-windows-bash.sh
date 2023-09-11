#!/bin/bash

# This script is used to download and install SonarQube scanner on Windows using Git Bash

# Define temporary directory for downloads
tmp_dir="/c/Temp"

# Ensure the temporary directory exists
if [ ! -d "$tmp_dir" ]; then
    mkdir -p "$tmp_dir"
fi

# Define the directory where the scanner will be installed
opt_dir="/c/Program Files/SonarQubeScanner"

# Ensure the installation directory exists
if [ ! -d "$opt_dir" ]; then
    mkdir -p "$opt_dir"
fi

# Set the version for Windows
scanner_version="sonar-scanner-cli-5.0.1.3006-windows"

echo -e "\n=============================\n\t$scanner_version\t\n=============================\n"

# Define the URL for downloading the SonarQube scanner
download_url="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${scanner_version}.zip"
echo -e "\nDownloading the SonarQube scanner from: \n$download_url\n"

# Download the SonarQube scanner
curl -L -o "$tmp_dir/$scanner_version.zip" "$download_url"

# Unzip the downloaded file to the installation directory
unzip "$tmp_dir/$scanner_version.zip" -d "$opt_dir"

# Remove the downloaded zip file
rm "$tmp_dir/$scanner_version.zip"

# Print a success message with the installation location
echo "SonarQube scanner installed to $opt_dir/$scanner_version"
