# Dotfiles Windows 11

```powershell
# 设置当前用户的执行策略，允许远程签名的脚本运行
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
# 修改 ProxyServer Value
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings' -Name ProxyServer -Value "127.0.0.1:7890"
# 执行
.\setup.ps1
```
