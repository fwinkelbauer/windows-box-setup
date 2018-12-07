once 'you only list once' {
    choco list -lo
}

try {
    exec {
        choco some-invalid-argument
    }
} catch {
    Write-Warning 'The exec statement failed. This is expected.'
}
