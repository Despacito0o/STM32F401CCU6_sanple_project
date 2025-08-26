# STM32F401CCU6开发项目

这是一个基于STM32F401CCU6微控制器的开发项目，包含了完整的Keil uVision工程文件和自动化GitHub上传功能。

## 项目结构

```
STM32F401CCU6_sample/
├── User/                           # 用户代码
│   ├── main.c                     # 主程序文件
│   ├── stm32f4xx_conf.h          # 配置文件
│   ├── stm32f4xx_it.c            # 中断处理文件
│   └── stm32f4xx_it.h            # 中断处理头文件
├── Libraries/                      # 库文件
│   ├── CMSIS/                     # CMSIS库
│   └── STM32F4xx_StdPeriph_Driver/ # 标准外设库
├── Project/                        # 工程文件
│   └── RVMDK（uv5）/              # Keil uVision 5工程
├── auto_upload_github.bat         # 自动上传脚本
├── setup_github_automation.bat    # 一键设置脚本
└── github_upload_task.xml         # 任务计划程序配置
```

## 自动上传GitHub功能

### 快速设置（推荐）

1. **以管理员身份运行** `setup_github_automation.bat`
2. 按照提示输入GitHub用户名、邮箱和仓库URL
3. 脚本会自动完成所有配置

### 手动设置步骤

如果自动设置失败，可以按以下步骤手动配置：

#### 1. GitHub准备工作
- 在GitHub上创建一个新的仓库
- 获取仓库的HTTPS URL（例如：`https://github.com/yourusername/STM32F401CCU6_sample.git`）

#### 2. Git配置
```bash
git config --global user.name "你的用户名"
git config --global user.email "你的邮箱"
git remote add origin https://github.com/yourusername/STM32F401CCU6_sample.git
```

#### 3. 首次推送
```bash
git add .
git commit -m "初始提交"
git branch -M main
git push -u origin main
```

#### 4. 设置定时任务
以管理员身份在PowerShell中运行：
```powershell
schtasks /create /xml "github_upload_task.xml" /tn "STM32F401CCU6_GitHub_Upload"
```

## 使用说明

### 自动上传
- 系统会在每天**21:00**自动检查项目更改并上传到GitHub
- 只有当检测到文件更改时才会进行提交和推送

### 手动上传
直接运行 `auto_upload_github.bat` 可以立即执行上传操作

### 查看任务状态
1. 打开"任务计划程序"（Task Scheduler）
2. 查找名为"STM32F401CCU6_GitHub_Upload"的任务
3. 可以查看执行历史和状态

## 故障排除

### 常见问题

1. **推送失败**
   - 检查网络连接
   - 确认GitHub凭据是否正确
   - 可能需要设置个人访问令牌(Personal Access Token)

2. **任务计划程序设置失败**
   - 确保以管理员身份运行设置脚本
   - 检查Windows任务计划程序服务是否正常运行

3. **Git操作失败**
   - 确认Git已正确安装
   - 检查远程仓库URL是否正确

### 日志查看
- 任务执行日志可在任务计划程序中查看
- Git操作的详细信息会在命令行中显示

## 开发环境

- **MCU**: STM32F401CCU6
- **IDE**: Keil uVision 5
- **库**: STM32F4xx标准外设库
- **版本控制**: Git
- **自动化**: Windows任务计划程序

## 文件过滤

项目使用 `.gitignore` 文件过滤不必要的文件：
- 编译输出文件（.o, .bin, .hex等）
- Keil临时文件
- 调试配置文件
- 系统临时文件

保留重要的源代码和工程配置文件。

## 注意事项

1. 首次设置时需要GitHub认证
2. 建议使用个人访问令牌代替密码
3. 定时任务需要电脑在21:00时处于开机状态
4. 网络连接异常时会跳过上传，下次执行时会包含所有未上传的更改
