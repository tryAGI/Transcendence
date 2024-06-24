#!/bin/bash

# Set variables
ProvisioningName="Transcendence (Non-App Store)"
CodeSignKey="Developer ID Application: Konstantin Stukov (K34VT7FG7P)"
PackageSigningKey="Developer ID Installer: Konstantin Stukov (K34VT7FG7P)"
ProvisioningFileName=$(echo "$ProvisioningName" | tr -d '-' | tr -d '(' | tr -d ')' | tr ' ' '_')
ProvisioningProfilePath="$HOME/Downloads/$ProvisioningFileName.provisionprofile"

# Encode the provisioning profile and .p12 file in base64
ProvisioningBase64=$(base64 < "$ProvisioningProfilePath")

# Print the output for GitHub Actions
echo "MACCATALYST_NON_APP_STORE_BUILD_PROVISION_PROFILE_BASE64=$ProvisioningBase64"
echo "MACCATALYST_NON_APP_STORE_CODESIGN_PROVISION=$ProvisioningName"
echo "MACCATALYST_NON_APP_STORE_CODESIGN_KEY=$CodeSignKey"
echo "MACCATALYST_NON_APP_STORE_PACKAGE_SIGNING_KEY=$PackageSigningKey"