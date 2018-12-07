$scriptRoot = Split-Path $MyInvocation.MyCommand.Definition
Get-ChildItem "$scriptRoot\*.ps1" | ForEach-Object { . $_ }
Export-ModuleMember -Function exec
Export-ModuleMember -Function once
