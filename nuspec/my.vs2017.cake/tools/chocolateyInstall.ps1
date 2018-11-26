$ErrorActionPreference = 'Stop';

$parameters = @{
    PackageName   = $env:ChocolateyPackageName
    VsixUrl       = 'https://vs-publisher-1392591.gallerycdn.vsassets.io/extensions/vs-publisher-1392591/cakeforvisualstudio/0.2.0.0/1503436806448/229353/4/Cake.VisualStudio.vsix'
    Checksum      = '752A01E2A40A5DED7BED6FC16930B347205030AE693C75D3D5DC76DCCE407D02'
    ChecksumType  = 'sha256'
}

Install-VisualStudioVsixExtension @parameters
