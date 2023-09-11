#!/bin/bash

# Main script to install SonarQube scanner

echo "Which platform do you want to install the SonarQube scanner on?"
echo "1) Linux"
echo "2) Mac OSX"
echo "3) Windows (Git Bash)"
echo "4) Windows (PowerShell)"

read -p "Enter your choice: " choice

case $choice in
1)
    ./install_sonarqube-scanner_centos.sh
    ;;
2)
    ./install-sonar-scanner-macosx.sh
    ;;
3)
    ./install-sonar-scanner-windows-bash.sh
    ;;
4)
    ./install-sonar-scanner-windows-powershell.ps1
    ;;
*)
    echo "Invalid choice"
    exit 1
    ;;
esac
