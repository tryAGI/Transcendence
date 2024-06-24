#!/bin/bash

# Set variables
Alias="app"
KeystorePath="keystore.keystore"

# Generate a random password
Password=$(openssl rand -base64 12)

keytool -genkeypair -v -keystore $KeystorePath -alias $Alias -keyalg RSA -keysize 2048 -validity 10000 -keypass $Password -storepass $Password -dname "CN=Unknown, OU=Unknown, O=Unknown, L=Unknown, S=Unknown, C=Unknown"

# Encode the keystore in base64
KeyStoreBase64=$(base64 < "$KeystorePath")

# Print the output for GitHub Actions
echo "ANDROID_SIGNING_KEY_STORE_BASE64=$KeyStoreBase64"
echo "ANDROID_SIGNING_KEY_ALIAS=$Alias"
echo "ANDROID_SIGNING_KEY_PASSWORD=$Password"
echo "ANDROID_SIGNING_STORE_PASSWORD=$Password"

# Clean up
rm "$KeystorePath"