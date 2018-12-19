once 'you only list once' {
    choco list -lo
}

# 7z.exe is installed via Chocolatey. See C:\ProgramData\chocolatey\bin
exec {
    7z this-is-not-the-error-you-are-looking-for
} -validExitCodes @(0, 7)

try {
    exec {
        7z some-invalid-argument
    }
}
catch {
    Write-Warning 'The exec statement failed. This is expected.'
}
