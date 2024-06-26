Add-Type -AssemblyName System.Web
$Password = [System.Web.Security.Membership]::GeneratePassword(32, 8)
$SelfSignedOutput = New-SelfSignedCertificate `
  -Type Custom `
  -Subject "CN=Konstantin Stukov" `
  -KeyUsage DigitalSignature `
  -FriendlyName "Konstantin Stukov self-signed dev cert" `
  -CertStoreLocation "Cert:\CurrentUser\My" `
  -TextExtension @("2.5.29.37={text}1.3.6.1.5.5.7.3.3", "2.5.29.19={text}")
$Thumbprint = $SelfSignedOutput.Thumbprint
$SecurePassword = ConvertTo-SecureString -String $Password -Force -AsPlainText
Export-PfxCertificate -Cert "Cert:\CurrentUser\My\$Thumbprint" -FilePath ".\cert.pfx" -Password $SecurePassword
certutil -encode ".\cert.pfx" ".\cert.base64"
$Base64 = Get-Content ".\cert.base64"
Remove-Item ".\cert.pfx"
Remove-Item ".\cert.base64"

echo "WINDOWS_PFX_THUMBPRINT=$Thumbprint"
echo "WINDOWS_PFX_PASSWORD=$Password"
echo "WINDOWS_PFX_FILE=$Base64"