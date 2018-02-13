 param (
    [string]$ou
 )

$computerList = Get-ADComputer -Filter * -SearchBase $ou | Select-Object -ExpandProperty Name
foreach ($computer in $computerList) {
    if (Test-Connection -ComputerName $computer -Quiet -Count 1){
    gwmi win32_operatingsystem -ComputerName $computer | select csname, @{LABEL='LastBootUpTime';EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}} 
    } else {
    $errors += "$computer was not reachable `n"
    }
    }
write-host $errors