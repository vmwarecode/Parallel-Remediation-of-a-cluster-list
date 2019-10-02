$taskList = New-Object System.Collections.ArrayList
foreach ($cluster in $clusterList) {
     $baseline = Get-Baselines -Entity $cluster
     $task = Update-Entity -Baseline $baseline -Entity $cluster -ClusterDisableDistributedPowerManagement:$true -ClusterDisableFaultTolerance:$true -ClusterDisableHighAvailability:$true -RunAsync -Confirm:$false
     $taskList.Add($task)
}
while ($taskList.length) {
     foreach ($task in $taskList) {
           if ($task.PercentComplete -eq 100) {
                 $taskList.Remove($task)
           } Else {
                 Get-Task -id $task.id
                 $task = Get-Task -id $task.id
           }
     }
     Start-Sleep -Second 10
}