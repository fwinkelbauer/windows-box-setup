function Get-StoredUserCredential {
    $credFile = Join-Path $env:UserProfile 'cred.xml'

    if (Test-Path $credFile) {
        $cred = Import-CliXml -Path $credFile
    }
    else {
        $currentUser = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
        $cred = Get-Credential $currentUser
    }

    try {
        # Validate the credential object
        Start-Process 'cmd.exe' -ArgumentList '/c', 'echo' -Credential $cred

        $cred | Export-CliXml -Path $credFile

        return $cred
    }
    catch {
        throw "Invalid password for user '$currentUser'"
    }
}
