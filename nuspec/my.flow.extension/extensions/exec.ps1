# Idea taken from the PSake project
# https://github.com/psake/psake
function exec {
    param(
        [Parameter(Mandatory = $true)]
        [scriptblock]$cmd,
        [int[]]$validExitCodes = @(0, 1641, 3010)
    )

    $global:lastexitcode = 0

    & $cmd

    if (-not ($global:lastexitcode -in $validExitCodes)) {
        throw "Exit code of command was '$lastexitcode'"
    }
}
