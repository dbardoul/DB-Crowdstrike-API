#Line 5 "Get-FalconDetection" gets all falcon detections based on the command line
#The All switch gets every single one of them
# You have to escape all the double quotes if they are throughout the command line

$result = Get-FalconDetection -Filter "assigned_to_uid:null" -All
$outarray = @()
$i = 1

#This for loop goes through every detetction in Line 5 "Get-FalconDetection", closes them, assigns them to a user, and adds a comment
foreach ($r in $result) {
$r
    Edit-FalconDetection -Comment "This is a normal command line that gets the local date and time of a Windows device." -Status "closed" -AssignedToUuid "<redacted>" -Id $r
    <#
    $newrow = @{
        "Action" = "Closed";
        "ID" = $r
        "Comment" = "This is Cerner downtime viewer executible. Known good command line"
        "Assigned to" = "<redacted>"
    }
    $outarray += $newrow
    $i++
    #>
}

$outarray | Export-Csv "C:\Users\<redacted>\Documents\cs.csv" -NoTypeInformation