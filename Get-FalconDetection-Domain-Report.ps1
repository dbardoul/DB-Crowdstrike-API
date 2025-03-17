$result = Get-FalconDetection -Filter "device.machine_domain:'<redacted>'" -All -Detailed
$outarray = @()

$result | ForEach {
    $r = $_
    $row = New-Object PSObject
    $row | Add-Member -MemberType NoteProperty -Name "detection_id" -Value $r.detection_id
    $row | Add-Member -MemberType NoteProperty -Name "created_timestamp" -Value $r.created_timestamp
    $row | Add-Member -MemberType NoteProperty -Name "device" -Value $r.device.hostname
    $row | Add-Member -MemberType NoteProperty -Name "behaviors.username" -Value $r.behaviors.username
    $row | Add-Member -MemberType NoteProperty -Name "behaviors.filename" -Value $r.behaviors.filename
    $row | Add-Member -MemberType NoteProperty -Name "behaviors.cmdline" -Value $r.behaviors.cmdline

    $outarray += $row
}

$outarray | Export-Csv "C:\Users\<redacted>\Documents\gcs.csv" -NoTypeInformation