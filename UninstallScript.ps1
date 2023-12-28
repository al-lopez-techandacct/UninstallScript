$Windir = (get-item env:"windir").Value
$ProgFilesx86 = (Get-Item env:"ProgramFiles(x86)").Value
$ProgFiles = (Get-Item env:"ProgramW6432").Value
$ProgData = (Get-Item env:"ProgramData").Value
$Netskope_Ver = Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall  |
Get-ItemProperty |
Where-Object {$_.DisplayName -like "*Netskope*"} |
Select-Object -Property DisplayVersion, UninstallString, PSChildName

    ForEach ($Key in $Netskope_Ver)
    {   
        $Guid = $Key.PSChildName
        [Version]$Version = $Key.DisplayVersion
        $Password = '"M$Xw*8f0wucuHtD"'
        cmd /c "msiexec /x $Guid /qn PASSWORD=$Password REBOOT=ReallySuppress /l*v $Windir\Logs\NetskopeUninst_$Version.log"
    }
