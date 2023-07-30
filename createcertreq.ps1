#POWERSHELL to generate cert

Write-Host "Creating CertificateRequest(CSR) for $CertName `r "

$CertName = "test.domain.com" 
$CSRPath = "c:\temp\$($CertName)_.csr"
$INFPath = "c:\temp\$($CertName)_.inf" 
$Signature = '$Windows NT$'

$INF =
@"
[Version]
Signature= "$Signature"

[NewRequest]
Subject = "CN=$CertName, O=OrganizationName, L=CityName, S=StateName, C=US"
KeySpec = 1
KeyLength=2048
Exportable = TRUE
MachineKeySet = TRUE
SMIME = False
PrivateKeyArchive = FALSE
UserProtected = FALSE
UseExistingKeySet = FALSE
ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
ProviderType = 12
RequestType = PKCS10
KeyUsage = 0xa0

[EnhancedKeyUsageExtension]

OID=1.3.6.1.5.5.7.3.1
OID=1.3.6.1.5.5.7.3.2

[Extensions]
2.5.29.17 = "{text}"
_continue_ = "dns=$CertName&"

"@

write-Host "Certificate Request is being generated `r " $INF | out-file -filepath $INFPath -force
certreq -new $INFPath $CSRPath

}
write-output "Certificate Request has been generated" 
