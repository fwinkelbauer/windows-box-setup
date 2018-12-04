$ErrorActionPreference = 'Stop'

$artifactsDir = '.\artifacts'

function Invoke-Linter {
    $files = Get-ChildItem -Path '.\nuspec', '.\scripts' -Include '*.ps1', '*.psm1' -Recurse
    $foundIssues = $false

    foreach ($file in $files) {
        $name = $file.FullName
        $issues = Invoke-ScriptAnalyzer -Path $name

        if ($issues) {
            Write-Output "Found issues in file '$name'"
            $issues
            $foundIssues = $true
        }
    }

    if ($foundIssues) {
        Write-Error 'Please fix the linter issues above'
    }
}

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

Invoke-Linter
Clear-Artifacts
Copy-Boxstarter
Build-Packages
Copy-InstallScripts
Compress-Artifacts
