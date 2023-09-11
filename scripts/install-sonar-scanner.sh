#!/bin/bash

# This script is used to download and install SonarQube scanner

# Define temporary directory for downloads
# Check if the temporary directory exists, if not create it
tmp_dir="/tmp"
if [ ! -d "$tmp_dir" ]; then
    mkdir -p "$tmp_dir"
fi

# Define the directory where the scanner will be installed
# Check if the temporary directory exists, if not create it
opt_dir="/var/opt"
if [ ! -d "$opt_dir" ]; then
    mkdir -p "$opt_dir"
fi

# Change to the opt directory
# Change to the temporary directory
cd "$opt_dir" || exit
cd "$tmp_dir" || exit

# Check if the script is being run as root, if not exit with an error message
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit 1
fi

# Prompt the user to enter their operating system
# Check if the user entered a value for the operating system, if not exit with an error message
read -p "Which OS are you using? (windows, linux, mac): " os_name
if [ -z "$os_name" ]; then
    echo "OS name cannot be empty"
    exit 1
fi

# Convert the operating system name to lowercase
os_name="${os_name,,}"

# Map the operating system name to the corresponding SonarQube scanner version
case $os_name in
windows)
    scanner_version="sonar-scanner-cli-5.0.1.3006-windows"
    ;;
linux)
    scanner_version="sonar-scanner-cli-5.0.1.3006-linux"
    ;;
mac)
    scanner_version="sonar-scanner-cli-5.0.1.3006-macosx"
    ;;
*)
    # If the operating system is not supported, exit with an error message
    echo "Unsupported OS"
    exit 1
    ;;
esac

echo -e "\n\n\n\n\n\n=============================\n\t\t\t${scanner_version}\t\t\t\n=============================\n\n\n\n\n\n\n\n\n\n\n"
sleep 7

# Define the URL for downloading the SonarQube scanner
download_url="https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${scanner_version}.zip"
echo -e "\n\n*****\nDefine the URL for downloading the SonarQube scanner: \n\"https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/${scanner_version}.zip\"\n*****\n\n"

# Check if the installation directory exists, if not create it
if [ ! -d "${opt_dir}" ]; then
    mkdir -p "${opt_dir}"
fi

# Download the SonarQube scanner
wget -q -O "${tmp_dir}/${scanner_version}.zip" "$download_url"

# Unzip the downloaded file
unzip "${tmp_dir}/${scanner_version}.zip" -d "${tmp_dir}"

# Remove the downloaded zip file
rm "${tmp_dir}/${scanner_version}.zip"

# Define the directory name of the unzipped scanner
scanner_dir="${scanner_version/-cli/}"

# Move the unzipped scanner to the installation directory
mv "${tmp_dir}/${scanner_dir}" "${opt_dir}"

# Print a success message with the installation location
echo "SonarQube scanner installed to ${opt_dir}/${scanner_dir}"
