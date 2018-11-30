$ErrorActionPreference = 'Stop'

$boxstarterModule = Join-Path $PSScriptRoot 'Boxstarter\Boxstarter.Chocolatey'
Import-Module $boxstarterModule
Invoke-ChocolateyBoxstarter -BootstrapPackage 'my.box.csharp'
