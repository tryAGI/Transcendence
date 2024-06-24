#!/bin/bash

# Go to https://appstoreconnect.apple.com/access/integrations/api to create a new API key
# Create new Developer API key and download it. The file will be named AuthKey_$KeyId.p8

# Set variables
KeyId="5KUB874Z68"
IssuerId="c6121b4e-2a38-4759-a5f2-c2c04fd4beb6"
KeyPath="$HOME/Downloads/AuthKey_$KeyId.p8"

# Encode the provisioning profile and .p12 file in base64
KeyBase64=$(base64 < "$KeyPath")

# Print the output for GitHub Actions
echo "APP_STORE_CONNECT_PRIVATE_KEY_BASE64=$KeyBase64"
echo "APP_STORE_CONNECT_KEY_ID=$KeyId"
echo "APP_STORE_CONNECT_ISSUER_ID=$IssuerId"