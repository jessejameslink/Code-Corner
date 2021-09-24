$hashtable = @{
    Lastname = 'Hebb'
    Firstname = 'Jacob'
    Rank = 'WO1'
    }

$object = [PSCustomObject]$hashtable

<#example usage: 

>$object | Select-Object -Property Rank

Rank
----
WO1 
#>
