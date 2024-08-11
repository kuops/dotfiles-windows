# 设置系统代理
Write-Host '正在设置系统代理...'
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer -Value "127.0.0.1:7890"
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyEnable -Value 1

# 定义小鹤双拼输入法方案
Write-Host '定义小鹤双拼输入法方案...'
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS' -Name 'UserDefinedDoublePinyinScheme0' -Value '小鹤双拼*2*^*iuvdjhcwfg^xmlnpbksqszxkrltvyovt' -Type String -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS' -Name 'EnableDoublePinyin' -Value 1 -Type DWord -Force
Set-ItemProperty -Path 'HKCU:\Software\Microsoft\InputMethod\Settings\CHS' -Name 'DoublePinyinScheme' -Value 10 -Type DWord -Force

# 启用 Telnet 客户端功能
Write-Host '启用 Telnet 客户端功能...'
dism /online /Enable-Feature /FeatureName:TelnetClient

# 重置并配置 winget 包管理器源
Write-Host '配置 winget 包管理器源...'
winget source reset --force
winget source remove winget
winget source add winget https://mirrors.ustc.edu.cn/winget-source

# 使用 winget 安装软件（静默模式）
winget install --id ClashVergeRev.ClashVergeRev --silent
winget install --id Git.Git --silent --override '/VerySilent /NoRestart /o:PathOption=CmdTools /Components="icons,assoc,assoc_sh,gitlfs"'
winget install --id Tencent.QQ.NT --silent
winget install --id Alibaba.aDrive --silent
winget install --id Google.Chrome --silent
winget install --id Microsoft.OpenJDK.21 --silent
winget install --id Microsoft.VisualStudioCode --scope machine --override '/VERYSILENT /SP- /mergetasks="!runcode,addcontextmenufiles,addcontextmenufolders,desktopicon"'
winget install --id Python.Python.3.11 --silent --scope machine
winget install --id Telegram.Unigram --silent

# 关闭系统代理
Write-Host '关闭系统代理...'
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyEnable -Value 0

# 设置环境变量
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

# 配置 pip
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
