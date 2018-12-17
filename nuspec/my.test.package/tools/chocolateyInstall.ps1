once 'you only list once' {
    choco list -lo
}

exec {
    choco this-is-not-the-error-you-are-looking-for
} -validExitCodes @(0, 1)

try {
    exec {
        choco some-invalid-argument
    }
} catch {
    Write-Warning 'The exec statement failed. This is expected.'
}
