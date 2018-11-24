$ErrorActionPreference = 'Stop';

$parameters = @{
    PackageName   = $env:ChocolateyPackageName
    VsixId        = '3cf9b016-d63f-44ee-849d-6f3efc996134'
}

Uninstall-VisualStudioVsixExtension @parameters
