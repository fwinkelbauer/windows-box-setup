properties {
    $artifactsDir = '.\artifacts'
}

task Invoke-Linter {
    $files = Get-ChildItem -Path '.\psakefile.ps1', '.\nuspec', '.\scripts' -Include '*.ps1', '*.psm1' -Recurse
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

task Clear-Artifacts {
    if (Test-Path $artifactsDir) {
        Get-ChildItem -Path $artifactsDir -Recurse | Remove-Item -Force -Recurse
    }
    else {
        New-Item -ItemType Directory -Path $artifactsDir
    }
}

task Build-Artifacts -depends Invoke-Linter, Clear-Artifacts {
    Import-Module Boxstarter.Chocolatey
    Copy-Item -Path $Boxstarter.BaseDir -Destination $artifactsDir -Recurse -Exclude '*.nupkg', '*.log'

    foreach ($nuspec in Get-ChildItem -Path '.\nuspec\**\*.nuspec') {
        choco pack $nuspec --output-directory "$artifactsDir\Boxstarter\BuildPackages"
    }

    Copy-Item -Path '.\scripts\*' -Destination $artifactsDir

    Compress-Archive -Path "$artifactsDir\*" -DestinationPath "$artifactsDir\box.zip"
}

task Invoke-Prettifier {
    $files = Get-ChildItem -Path '.\psakefile.ps1', '.\nuspec', '.\scripts' -Include '*.ps1', '*.psm1' -Recurse

    foreach ($file in $files) {
        $content = Get-Content $file | Out-String
        $prettyContent = Invoke-Formatter $content

        if (-not ($content -eq $prettyContent)) {
            $prettyContent | Out-File -FilePath $file -Encoding utf8 -NoNewline
        }
    }
}

task Default -depends Build-Artifacts
