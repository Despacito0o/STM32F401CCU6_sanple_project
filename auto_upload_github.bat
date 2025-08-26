@echo off
chcp 65001 >nul
echo ======================================
echo STM32F401CCU6项目自动上传到GitHub
echo 执行时间: %date% %time%
echo ======================================

REM 切换到项目目录
cd /d "D:\Doc\KEIL\STM32F401CCU6\STM32F401CCU6开发指南：创建空白工程\STM32F401CCU6_sample"

REM 检查是否有更改
git status --porcelain >nul 2>&1
if %errorlevel% neq 0 (
    echo [错误] Git仓库状态检查失败
    goto error_exit
)

REM 添加所有更改
echo [信息] 添加文件到Git暂存区...
git add .
if %errorlevel% neq 0 (
    echo [错误] 添加文件失败
    goto error_exit
)

REM 检查是否有要提交的更改
git diff --cached --quiet
if %errorlevel% equ 0 (
    echo [信息] 没有检测到更改，跳过提交
    goto success_exit
)

REM 提交更改
echo [信息] 提交更改...
git commit -m "自动提交 - %date% %time%"
if %errorlevel% neq 0 (
    echo [错误] 提交失败
    goto error_exit
)

REM 推送到GitHub
echo [信息] 推送到GitHub...
git push origin main
if %errorlevel% neq 0 (
    echo [警告] 推送失败，尝试推送到master分支...
    git push origin master
    if %errorlevel% neq 0 (
        echo [错误] 推送到GitHub失败
        goto error_exit
    )
)

:success_exit
echo [成功] 操作完成！
echo ======================================
exit /b 0

:error_exit
echo [失败] 操作失败！
echo ======================================
exit /b 1
