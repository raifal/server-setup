$lines = Get-Content ..\secrets\docker.env
foreach ($line in $lines) {
    $a,$b = $line.split('=')
    Set-Variable $a $b
}

TODO not completed...

