function Make-Moves
{
    $i = 0
    $s = ""
    While ($true)
    {
        $a = @(
            "$s 0"
            "$s/||"
            "$s ^"
            "$s |\"
        )

        $b = @(
            "$s 0"
            "$s|||"
            "$s ^"
            "$s |"
            )

        $c = @(
            "$s 0"
            "$s||\"
            "$s ^"
            "$s/|"
            )

        $moves = $a,$b,$c,$b
        cls
        foreach ($element in $moves[$i])
        {
            Write-Output $element
        }
        Start-Sleep -Milliseconds 350
        $i++
        $s += " "
        if ($i -eq 4)
        {
            $i=0
        }
    }
}

Make-Moves
