@echo off
chcp 65001 >nul
echo ======================================
echo STM32F401CCU6项目GitHub自动上传设置
echo ======================================

REM 检查管理员权限
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo [警告] 建议以管理员身份运行此脚本以设置任务计划程序
    echo.
)

echo [步骤1] 设置Git配置...
echo 请输入您的GitHub用户名:
set /p github_username="用户名: "
echo 请输入您的GitHub邮箱:
set /p github_email="邮箱: "

git config --global user.name "%github_username%"
git config --global user.email "%github_email%"

echo.
echo [步骤2] 创建GitHub仓库...
echo 请在GitHub上创建一个新的仓库，然后输入仓库URL:
echo 例如: https://github.com/yourusername/STM32F401CCU6_sample.git
set /p github_repo_url="仓库URL: "

echo.
echo [步骤3] 添加远程仓库...
git remote add origin %github_repo_url%
if %errorlevel% equ 0 (
    echo [成功] 远程仓库添加成功
) else (
    echo [信息] 远程仓库可能已存在，尝试更新...
    git remote set-url origin %github_repo_url%
)

echo.
echo [步骤4] 首次提交和推送...
git add .
git commit -m "初始提交 - STM32F401CCU6项目"
git branch -M main
git push -u origin main

if %errorlevel% equ 0 (
    echo [成功] 首次推送完成
) else (
    echo [错误] 推送失败，请检查网络连接和GitHub凭据
    echo 您可能需要配置GitHub认证令牌
    pause
    goto end
)

echo.
echo [步骤5] 设置任务计划程序...
echo 正在导入任务计划程序配置...

schtasks /create /xml "github_upload_task.xml" /tn "STM32F401CCU6_GitHub_Upload"

if %errorlevel% equ 0 (
    echo [成功] 任务计划程序设置完成
    echo 每天21:00将自动上传项目到GitHub
) else (
    echo [警告] 任务计划程序设置失败
    echo 您可以手动运行以下命令（以管理员身份）:
    echo schtasks /create /xml "github_upload_task.xml" /tn "STM32F401CCU6_GitHub_Upload"
)

echo.
echo [步骤6] 测试自动上传脚本...
echo 正在测试上传脚本...
call auto_upload_github.bat

:end
echo.
echo ======================================
echo 设置完成！
echo.
echo 使用说明:
echo 1. 每天21:00系统会自动上传项目到GitHub
echo 2. 手动上传: 运行 auto_upload_github.bat
echo 3. 查看任务状态: 在任务计划程序中查看"STM32F401CCU6_GitHub_Upload"
echo ======================================
pause
