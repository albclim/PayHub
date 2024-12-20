<powershell>

Write-Output "---------------------------------------"
Write-Output "Setting up Temporary Windows Admininistrator to interact with WinRM..."

net user ${"albgoncal"} '${"Koke@2020"}' /add /y
net localgroup administrators ${"albgoncal"} /add

Write-Output "---------------------------------------"
Write-Output "Setting up WinRM..."

winrm quickconfig -q
winrm set winrm/config/winrs '@{MaxMemoryPerShellMB="300"}'
winrm set winrm/config '@{MaxTimeoutms="1800000"}'
winrm set winrm/config/service '@{AllowUnencrypted="true"}'
winrm set winrm/config/service/auth '@{Basic="true"}'
netsh advfirewall firewall add rule name="WinRM 5985" protocol=TCP dir=in localport=5985 action=allow
net stop winrm
sc.exe config winrm start=auto
net start winrm
Set-ExecutionPolicy Bypass -Scope Process -Force; 

Write-Output "---------------------------------------"
Write-Output "Installing Chocolatey and Packages..."

Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

Install-PackageProvider -Name NuGet -RequiredVersion 2.8.5.201 -Force
Install-Module -Name PSPrivilege -Force
Install-Module -Name xWebAdministration -Force
Install-Module -Name xNetworking -Force
Install-Module -Name xPSDesiredStateConfiguration -Force 

choco install git.install -y
choco install notepadplusplus -y
choco install googlechrome -y

$env_OL:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env_OL:ChocolateyInstall\helpers\chocolateyProfile.psm1"

refreshenv

choco install winscp.install -y
choco install putty -y

</powershell>