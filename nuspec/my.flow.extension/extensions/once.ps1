function once {
    param(
        [Parameter(Mandatory = $true)]
        [string]$name,
        [Parameter(Mandatory = $true)]
        [scriptblock]$cmd
    )

    $checkpointDir = Join-Path $env:ProgramData 'my.flow'
    $checkpoint = Join-Path $checkpointDir "$name.txt"

    if (Test-Path $checkpoint) {
        Write-Output "Skipping script block '$name' because of a checkpoint file"
        return
    }

    Write-Output "Creating checkpoint file for script block '$name'"
    New-Item -Path $checkpoint -Force

    & $cmd
}
