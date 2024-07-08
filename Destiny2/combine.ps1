# 选择合并的文件夹
$folders = ".\S24" #, ".\S23", ".\1", ".\2"
# 合并txt文件至combined.txt
function CombineTxt {
    param([string] $startingDir)
    Get-ChildItem $startingDir -Filter *.txt | Get-Content | Out-File (Join-Path $startingDir combined.txt)
    Get-ChildItem $startingDir | Where-Object { $_.PsIsContainer } | ForEach-Object { CombineTxt $_.FullName }
}
# 合并txt文件
foreach ($folder in $folders) {
    CombineTxt $folder
}
# 获取combined.txt文件
$combineds = Get-ChildItem -Path ".\" -Filter combined.txt -Recurse
# 输出至根目录wishlist.txt
$combineds | Get-Content | Out-File ".\wishlist.txt"
# 删除combined.txt
$combineds | Remove-Item