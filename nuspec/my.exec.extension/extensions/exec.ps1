# Idea taken from the PSake project
# https://github.com/psake/psake
function exec {
    param(
        [Parameter(Mandatory = $true)]
        [scriptblock]$cmd
    )

    $global:lastexitcode = 0
    & $cmd
    if ($global:lastexitcode -ne 0) {
        throw "Exit code of command was '$lastexitcode'"
    }
}
