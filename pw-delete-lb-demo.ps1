# Define the path to the P12 certificate and the password
$p12CertPath = "PATH-TO-CERT.p12"
$p12CertPassword = "password#"

# Load the P12 certificate
$p12Cert = Get-PfxCertificate -FilePath $p12CertPath -Password (ConvertTo-SecureString -String $p12CertPassword -AsPlainText -Force)

# Define the API endpoint
$apiUrl = "https://YOUR-TENANT.console.ves.volterra.io/api/config/namespaces/NAMESPACE/http_loadbalancers/LB-NAME"

# Create a WebRequest object
$handler = New-Object System.Net.Http.HttpClientHandler
$handler.ClientCertificates.Add($p12Cert)

# Create a HttpClient object
$httpClient = New-Object System.Net.Http.HttpClient($handler)

# Make the DELETE request
$response = $httpClient.DeleteAsync($apiUrl).Result
$responseContent = $response.Content.ReadAsStringAsync().Result

# Output the response
$responseContent
