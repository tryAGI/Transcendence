#!/bin/bash

# Set variables
ProvisioningName="Transcendence Distribution"
ProvisioningFileName=$(echo "$ProvisioningName" | tr ' ' '_')
CertificateName="Apple Distribution: Konstantin Stukov (K34VT7FG7P)"
ProvisioningProfilePath="$HOME/Downloads/$ProvisioningFileName.mobileprovision"

# Generate a random password
Password=$(openssl rand -base64 12)

# Encode the provisioning profile and .p12 file in base64
ProvisioningBase64=$(base64 < "$ProvisioningProfilePath")

# Print the output for GitHub Actions
echo "APPLE_BUILD_PROVISION_PROFILE_BASE64=$ProvisioningBase64"
echo "APPLE_CODESIGN_KEY=$CertificateName"
echo "APPLE_CODESIGN_PROVISION=$ProvisioningName" 
echo "APPLE_CODESIGN_PROVISION WARNING: If you have a space in the provisioning profile name, make sure you revert it back because file names can't have spaces"
echo "APPLE_KEYCHAIN_PASSWORD=$Password"
echo "APPLE_P12_PASSWORD=$Password"