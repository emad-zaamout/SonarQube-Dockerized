#!/bin/bash

# This script is used to download and install SonarQube scanner on macOS

# Define temporary directory for downloads
tmp_dir="/tmp"

# Check if the temporary directory exists, if not create it
if [ ! -d "$tmp_dir" ]; then
    mkdir -p "$tmp_dir"
fi

# Define the directory where the scanner will be installed
opt_dir="/usr/local/opt" # This is a more conventional location for third-party software on macOS

# Check if the installation directory exists, if not create it
if [ ! -d "$opt_dir" ]; then
    sudo mkdir -p "$opt_dir"
fi

cd "$tmp_dir" || exit

# Ensure the user has the right permissions
if [ "$EUID" -ne 0 ]; then
    echo "Note: You may be prompted for your sudo password during this process."
fi

# Set the version for macOS
scanner_version="sonar-scanner-cli-5.0.1.3006-macosx"

echo -e "\n\n\n\n\n\n=============================\n\t\t\t${scanner_version}\t\t\t\n=============================\n\n\n\n\n\n\n\n\n\n\n"
sleep 3

# Define the URL for downloading the SonarQube scanner
download_url="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${scanner_version}.zip"
echo -e "\n\n*****\nDownloading the SonarQube scanner from: \n${download_url}\n*****\n\n"

# Download the SonarQube scanner
curl -L -o "${tmp_dir}/${scanner_version}.zip" "$download_url"

# Unzip the downloaded file
unzip "${tmp_dir}/${scanner_version}.zip" -d "${tmp_dir}"

# Remove the downloaded zip file
rm "${tmp_dir}/${scanner_version}.zip"

# Define the directory name of the unzipped scanner
scanner_dir="${scanner_version/-cli/}"

# Move the unzipped scanner to the installation directory
sudo mv "${tmp_dir}/${scanner_dir}" "${opt_dir}"

# Print a success message with the installation location
echo "SonarQube scanner installed to ${opt_dir}/${scanner_dir}"
