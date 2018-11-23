$ErrorActionPreference = 'Stop'

$artifactsDir = '.\artifacts'

function Clear-Artifacts {
    if (Test-Path $artifactsDir) {
        Get-ChildItem -Path $artifactsDir -Recurse | Remove-Item -Force -Recurse
    } else {
        New-Item -ItemType Directory -Path $artifactsDir
    }
}

function Copy-Boxstarter {
    Import-Module Boxstarter.Chocolatey
    Copy-Item -Path $Boxstarter.BaseDir -Destination $artifactsDir -Recurse -Exclude '*.nupkg'
}

function Build-Packages {
    foreach ($nuspec in Get-ChildItem -Path '.\nuspec\**\*.nuspec') {
        choco pack $nuspec --output-directory "$artifactsDir\Boxstarter\BuildPackages"
    }
}

function Copy-InstallScripts {
    Copy-Item -Path '.\scripts\*' -Destination $artifactsDir
}

function Compress-Artifacts {
    Compress-Archive -Path "$artifactsDir\*" -DestinationPath "$artifactsDir\box.zip"
}

Clear-Artifacts
Copy-Boxstarter
Build-Packages
Copy-InstallScripts
Compress-Artifacts
