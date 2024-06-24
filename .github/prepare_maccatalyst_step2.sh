#!/bin/bash

# This script requires manual export using Keychain Access on macOS to export the certificate as a .p12 file
# The exported .p12 file should be placed in the Downloads folder
# Use password from previous step

# Set variables
CertificatesPath="$HOME/Downloads/Certificates.p12"

# Encode the certificates in base64
CertificateBase64=$(base64 < "$CertificatesPath")

# Print the output for GitHub Actions
echo "MAC_INSTALLER_CERTIFICATE_BASE64=$CertificateBase64"

# Clean up
rm "$CertificatesPath"