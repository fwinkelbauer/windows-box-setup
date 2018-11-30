# This is an example to show how a script can be re-used using Chocolatey's
# package dependencies.

$ErrorActionPreference = 'Stop'

# Opens explorer at 'This PC' instead of 'Quick Access'
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 1

Set-WindowsExplorerOptions -EnableShowFileExtensions
