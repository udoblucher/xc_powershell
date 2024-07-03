$p12CertPath = "PATH-TO-CERT.p12"
$p12CertPassword = "password#"

# Load the P12 certificate
$p12Cert = Get-PfxCertificate -FilePath $p12CertPath -Password (ConvertTo-SecureString -String $p12CertPassword -AsPlainText -Force)

# Define the API endpoint
$apiUrl = "https://YOUR-TENANT.console.ves.volterra.io/api/config/namespaces/NAMESPACE/u-vonblucher/http_loadbalancers/auto-demo"
$jsonPayloadFilePath = "pw-update-lb-demo.yaml"

# Read the YAML payload from the file
$jsonPayload = Get-Content -Path $jsonPayloadFilePath -raw

# Create a WebRequest object
$handler = New-Object System.Net.Http.HttpClientHandler
$handler.ClientCertificates.Add($p12Cert)

# Create a HttpClient object
$httpClient = New-Object System.Net.Http.HttpClient($handler)

# Set the request content
$content = New-Object System.Net.Http.StringContent($jsonPayload, [System.Text.Encoding]::UTF8, "application/json")

# Make the PUT request
$response = $httpClient.PutAsync($apiUrl, $content).Result
$responseContent = $response.Content.ReadAsStringAsync().Result

# Output the response
$responseContent