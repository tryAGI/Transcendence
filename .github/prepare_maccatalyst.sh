#!/bin/bash

# Set variables
ProvisioningName="Transcendence Distribution MacOS"
ProvisioningFileName=$(echo "$ProvisioningName" | tr -d '-' | tr -d '(' | tr -d ')' | tr ' ' '_')
ProvisioningProfilePath="$HOME/Downloads/$ProvisioningFileName.provisionprofile"

# Encode the provisioning profile and .p12 file in base64
ProvisioningBase64=$(base64 < "$ProvisioningProfilePath")

# Print the output for GitHub Actions
echo "MACCATALYST_BUILD_PROVISION_PROFILE_BASE64=$ProvisioningBase64"
echo "MACCATALYST_CODESIGN_PROVISION=$ProvisioningName"