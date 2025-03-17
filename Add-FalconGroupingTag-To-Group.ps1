$result = Get-FalconHostGroupMember -Id <redacted> -All
foreach ($r in $result) {
    Add-FalconGroupingTag -Tag "FalconGroupingTags/GCS" -Id $r
}