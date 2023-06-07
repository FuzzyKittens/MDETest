function Send-Keystrokes {
    [cmdletbinding()]
    param
    (
        [Parameter(Mandatory=$true)]
        [string]$String
    )
    foreach ($char in $string) {
        $wsh.SendKeys($char)
        Start-Sleep -Milliseconds 800
    }
}

$wsh = New-Object -ComObject WScript.Shell
$wsh.SendKeys('^{ESC}')
Start-Sleep -Second 1
Send-Keystrokes -String "notepad"
$wsh.SendKeys('{ENTER}')
Start-Sleep -Second 1
Send-Keystrokes 'Please remember to lock your computer when you walk away.'
