$username = "<redacted>"
$password = ConvertTo-SecureString "<redacted>" -AsPlainText -Force
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $password
$tokenResponse = Invoke-RestMethod -Uri 'https://api.us-2.crowdstrike.com/oauth2/token' -ContentType 'application/x-www-form-urlencoded' -Authentication 'Basic' -Credential $cred -Method 'POST' -Body 'grant_type=client_credentials&scope=customer'
$token = ConvertTo-SecureString $tokenResponse.access_token -AsPlainText -Force

$cmdline = "C:\WINDOWS\system32\cmd.exe /c wmic os get localdatetime"
$url = "https://api.us-2.crowdstrike.com/detects/entities/summaries/GET/v1?filter=detection_id:'<redacted>:<redacted>'"
$type = 'application/json'
$auth = 'Bearer'
$props = @{
    Uri = $url
    ContentType = $type 
    Authentication = $auth
    Token = $token
}


$queryResponse = Invoke-RestMethod @props -Method 'POST'
$queryResponse

<#
$i = 1
foreach ($r in $result) {
    $uuid = $r.uuid
    $body = '[{"op":"replace","path":' + '"' + "/$uuid/state" + '"' + ',"value":4},{"op":"replace","path":' + '"' + "/$uuid/resolution" + '"' + ',"value":2}]'
    Invoke-RestMethod @props -Method 'PATCH' -Body $body
    Write-Host $i ": Closing " $uuid
    $i++
}
#>