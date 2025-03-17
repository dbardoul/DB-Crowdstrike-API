$hosts = Get-Content "C:\users\e220449\documents\VDI.txt"
$outarray = @()

foreach ($h in $hosts) {
    $hostdetails = Get-FalconHost -Filter "hostname:'$h'" -Detailed

    $policy = $hostdetails.policies.policy_id
    $policy = $policy.ToString()
    $policyGet = Get-FalconPreventionPolicy -Id $policy
    $policyName = $policyGet.name

    $groups = $hostdetails.groups
    $groupNames = @()
    foreach ($g in $groups) {
        $groupGet = Get-FalconHostGroup -Id $g
        $groupName = $groupGet.name 
        $groupNames += $groupName
    }
    $groupNamesJoined = $groupNames -join ', '

    $agent_version = $hostdetails.agent_version

    $row = New-Object PSObject
    $row | Add-Member -MemberType NoteProperty -Name "hostname" -Value $h
    $row | Add-Member -MemberType NoteProperty -Name "device_id" -Value $hostdetails.device_id
    $row | Add-Member -MemberType NoteProperty -Name "policy" -Value $policyName
    $row | Add-Member -MemberType NoteProperty -Name "groups" -Value $groupNamesJoined
    $row | Add-Member -MemberType NoteProperty -Name "agent_version" -Value $agent_version

    $outarray += $row
    $policyName = ""
}

$outarray | Export-Csv "C:\Users\e220449\Documents\VDI_details.csv" -NoTypeInformation