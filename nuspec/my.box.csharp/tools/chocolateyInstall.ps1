$ErrorActionPreference = 'Stop'

choco install git -y --no-progress
choco install visualstudio2017community --package-parameters '--locale en-US' -y --no-progress
choco install visualstudio2017-workload-manageddesktop -y --no-progress
choco install visualstudio2017-workload-netcoretools -y --no-progress
choco install vscode -y --no-progress

# Refresh environment to use tools such as "code" or "git"
Update-SessionEnvironment

choco install my.vs2017.cake -y --no-progress

code --install-extension cake-build.cake-vscode
code --install-extension gep13.chocolatey-vscode
