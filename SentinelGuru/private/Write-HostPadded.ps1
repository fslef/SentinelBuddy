function Write-HostPadded {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]
        $Text,

        [Parameter(Mandatory = $false)]
        [int]
        $Width = 80,

        [Parameter(Mandatory = $false)]
        [char]
        $PaddingChar = ' ',

        [Parameter(Mandatory = $false)]
        [ConsoleColor]
        $ForegroundColor,

        [Parameter(Mandatory = $false)]
        [ConsoleColor]
        $BackgroundColor,

        [Parameter(Mandatory = $false)]
        [int]
        $IndentLevel = 0,

        [Parameter(Mandatory = $false)]
        [switch]
        $Centered = $false

    )

    $indentation = $IndentLevel * 4
    $effectiveWidth = $Width - $indentation
    $lines = $Text -split '\r?\n'
    $wrappedLines = foreach ($line in $lines) {
        if ($line.Length -le $effectiveWidth) {
            $line
        } else {
            $line -replace "(?<=\S{$effectiveWidth})(\S)", "`$1`n"
        }
    }

    if ($Centered) {
        $formattedLines = $wrappedLines | ForEach-Object { $_.PadLeft(([math]::Ceiling(($effectiveWidth + $_.Length) / 2)) + $indentation, $PaddingChar).PadRight($Width + $indentation, $PaddingChar) }
    } else {
        $formattedLines = $wrappedLines | ForEach-Object { (' ' * $indentation) + $_.PadRight($effectiveWidth, $PaddingChar) }
    }

    $formattedText = $formattedLines -join "`r`n"

    if ($ForegroundColor -and $BackgroundColor) {
        Write-Host $formattedText -ForegroundColor $ForegroundColor -BackgroundColor $BackgroundColor
    } elseif ($ForegroundColor) {
        Write-Host $formattedText -ForegroundColor $ForegroundColor
    } elseif ($BackgroundColor) {
        Write-Host $formattedText -BackgroundColor $BackgroundColor
    } else {
        Write-Host $formattedText
    }

}

####
# Write-HostPadded -Text "This is a test"
# Write-HostPadded -Text "This is a test" -PaddingChar '.'
# Write-HostPadded -Text "This is a test identation" -PaddingChar '.' -Indent 1
# Write-HostPadded -Text "This is a test identation" -IndentLevel 2
# Write-HostPadded -Text "This is a test identation" -IndentLevel 2
# Write-HostPadded -Text "This is a test identation" -IndentLevel 2 -ForegroundColor Yellow
# Write-HostPadded -Text "This is a test identation" -IndentLevel 2 -ForegroundColor Yellow
