powershell.exe Install-WindowsFeature -name Web-Server -IncludeManagementTools
powershell.exe Remove-Item -Path 'C:\inetpub\wwwroot\iisstart.htm'
powershell.exe Add-Content -Path 'C:\inetpub\wwwroot\iisstart.htm' -Value "$env:computername"