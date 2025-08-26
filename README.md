# 🚀 STM32F401CCU6开发项目

[![STM32](https://img.shields.io/badge/STM32-F401CCU6-blue.svg)](https://www.st.com/en/microcontrollers-microprocessors/stm32f401.html)
[![Keil](https://img.shields.io/badge/IDE-Keil%20uVision%205-green.svg)](http://www.keil.com/)
[![Standard Peripheral Library](https://img.shields.io/badge/Library-STM32F4xx%20StdPeriph-orange.svg)](https://www.st.com/en/embedded-software/stsw-stm32065.html)

> 🎯 基于**STM32F401CCU6**微控制器的完整开发项目模板，采用**标准外设库**开发，提供GPIO控制LED闪烁的示例代码。适合STM32初学者学习和项目快速启动。

## 📋 项目特色

- ✅ **ARM Cortex-M4内核**：84MHz主频，高性能32位微控制器
- 🔧 **完整工程模板**：基于Keil uVision 5的标准工程结构
- 📦 **标准外设库**：使用ST官方STM32F4xx标准外设库
- 💡 **LED控制示例**：GPIO控制PC13引脚LED闪烁
- 🛠️ **即开即用**：工程配置完整，可直接编译下载

## 🔧 硬件规格

| 参数 | 规格 |
|------|------|
| 🔲 **芯片型号** | STM32F401CCU6 |
| ⚡ **内核架构** | ARM Cortex-M4 32bit |
| 🚀 **主频** | 84MHz |
| 💾 **Flash** | 256KB |
| 🧠 **SRAM** | 64KB |
| 📌 **封装** | UFQFPN48 |
| 🔌 **I/O引脚** | 36个 |

## 📁 项目结构详解

### 🎯 User/ 目录 - 用户代码核心

```
User/
├── 📄 main.c              # 主程序文件
├── 📄 stm32f4xx_conf.h    # 外设库配置文件
├── 📄 stm32f4xx_it.c      # 中断服务函数实现
└── 📄 stm32f4xx_it.h      # 中断服务函数声明
```

#### 🔍 main.c - 主程序分析
```c
// LED控制示例 - PC13引脚闪烁
int main(void)
{
    GPIO_InitTypeDef GPIO_InitStructure;
    
    // 1. 使能GPIOC时钟
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, ENABLE);
    
    // 2. 配置PC13为推挽输出
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_13;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;
    GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_2MHz;
    GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
    GPIO_Init(GPIOC, &GPIO_InitStructure);
    
    // 3. LED闪烁循环
    while(1) {
        GPIO_SetBits(GPIOC, GPIO_Pin_13);    // LED亮
        Delay(0xFFFFFF);
        GPIO_ResetBits(GPIOC, GPIO_Pin_13);  // LED灭
        Delay(0xFFFFFF);
    }
}
```

#### ⚙️ stm32f4xx_conf.h - 库配置文件
- 📚 **外设库包含**：选择性包含所需的外设驱动头文件
- 🔧 **功能配置**：外部时钟、断言宏等系统配置
- 🎯 **针对F401**：专门配置适合STM32F401系列的外设

#### 🔔 中断处理文件
- **stm32f4xx_it.h**：中断函数声明
- **stm32f4xx_it.c**：中断服务函数实现，包含系统异常处理

### 🔨 Project/ 目录 - 工程配置

```
Project/
└── RVMDK（uv5）/          # Keil uVision 5工程文件
    ├── 📄 F401.uvprojx    # 主工程文件
    ├── 📄 F401.uvoptx     # 工程选项配置
    ├── 📂 Objects/        # 编译输出目录
    └── 📂 Listings/       # 编译列表文件
```

#### 🛠️ Keil工程配置要点
- **目标器件**：STM32F401CCU6
- **编译器**：ARM Compiler 5/6
- **调试器**：支持ST-Link、J-Link等
- **下载配置**：Flash下载算法已配置

### 📚 Libraries/ 目录 - 库文件架构

```
Libraries/
├── 📂 CMSIS/                      # ARM CMSIS标准
│   ├── 📂 Device/ST/STM32F4xx/   # STM32F4设备相关
│   │   ├── 📂 Include/           # 设备头文件
│   │   │   ├── stm32f4xx.h      # 主设备头文件
│   │   │   └── system_stm32f4xx.h # 系统配置
│   │   └── 📂 Source/            # 启动文件和系统文件
│   │       ├── 📂 Templates/arm/ # 启动汇编文件
│   │       └── system_stm32f4xx.c # 系统初始化
│   └── 📂 Include/               # CMSIS核心头文件
│       ├── core_cm4.h           # Cortex-M4核心定义
│       ├── core_cmFunc.h        # 核心函数
│       └── arm_math.h           # DSP数学库
└── 📂 STM32F4xx_StdPeriph_Driver/ # 标准外设库
    ├── 📂 inc/                   # 外设驱动头文件
    │   ├── stm32f4xx_gpio.h     # GPIO驱动
    │   ├── stm32f4xx_rcc.h      # 时钟控制
    │   ├── stm32f4xx_tim.h      # 定时器
    │   ├── stm32f4xx_usart.h    # 串口
    │   └── ...                  # 其他外设头文件
    └── 📂 src/                   # 外设驱动源文件
        ├── stm32f4xx_gpio.c     # GPIO驱动实现
        ├── stm32f4xx_rcc.c      # 时钟控制实现
        └── ...                  # 其他外设实现
```

#### 🔍 库文件架构详解

##### CMSIS层 - 硬件抽象
- **core_cm4.h**：Cortex-M4内核寄存器定义
- **stm32f4xx.h**：STM32F4系列设备寄存器映射
- **system_stm32f4xx.c**：系统时钟配置和初始化

##### 标准外设库 - 功能驱动
| 外设模块 | 功能描述 |
|----------|----------|
| 🔌 **GPIO** | 通用输入输出控制 |
| ⏰ **RCC** | 复位和时钟控制 |
| ⏱️ **TIM** | 定时器/计数器 |
| 📡 **USART** | 串行通信接口 |
| 🔄 **SPI** | 串行外设接口 |
| 📊 **I2C** | I²C总线接口 |
| 📈 **ADC** | 模数转换器 |
| 🔊 **DAC** | 数模转换器 |

## 💻 开发环境配置

### 🛠️ 所需工具
- **Keil uVision 5**：主要开发IDE
- **STM32CubeProg**：程序下载工具
- **ST-Link驱动**：调试器驱动

### 📋 编译步骤
1. 打开`Project/RVMDK（uv5）/F401.uvprojx`
2. 选择目标设备：STM32F401CCU6
3. 编译工程：Project → Build Target (F7)
4. 下载程序：Flash → Download (F8)

## 🎯 功能演示

### 💡 LED闪烁控制
- **目标引脚**：PC13 (通常连接板载LED)
- **工作模式**：推挽输出，2MHz速度
- **闪烁频率**：约1Hz (由延时函数控制)
- **电平逻辑**：高电平点亮，低电平熄灭

### 🔧 代码扩展建议
```c
// 添加按键检测
GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0;
GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN;
GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
GPIO_Init(GPIOA, &GPIO_InitStructure);

// 添加串口输出
USART_InitTypeDef USART_InitStructure;
// ... 串口配置代码

// 添加定时器精确延时
TIM_TimeBaseInitTypeDef TIM_TimeBaseStructure;
// ... 定时器配置代码
```

## 📖 学习路径

### 🎯 初学者
1. **理解GPIO**：LED控制原理
2. **时钟系统**：RCC时钟配置
3. **寄存器操作**：直接寄存器vs标准库

### 🚀 进阶开发
1. **定时器应用**：PWM、捕获、计数
2. **通信接口**：USART、SPI、I2C
3. **中断系统**：外部中断、定时器中断
4. **DMA传输**：数据高效传输

### 🔬 高级应用
1. **实时操作系统**：FreeRTOS移植
2. **USB通信**：USB设备开发
3. **DSP应用**：数字信号处理
4. **低功耗设计**：休眠模式应用

## 🔧 常用外设配置模板

<details>
<summary>📡 USART串口配置</summary>

```c
// USART1配置 (PA9-TX, PA10-RX)
void USART1_Config(void)
{
    GPIO_InitTypeDef GPIO_InitStructure;
    USART_InitTypeDef USART_InitStructure;
    
    // 使能时钟
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA, ENABLE);
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_USART1, ENABLE);
    
    // GPIO配置
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9 | GPIO_Pin_10;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
    GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;
    GPIO_Init(GPIOA, &GPIO_InitStructure);
    
    // 复用功能配置
    GPIO_PinAFConfig(GPIOA, GPIO_PinSource9, GPIO_AF_USART1);
    GPIO_PinAFConfig(GPIOA, GPIO_PinSource10, GPIO_AF_USART1);
    
    // USART配置
    USART_InitStructure.USART_BaudRate = 115200;
    USART_InitStructure.USART_WordLength = USART_WordLength_8b;
    USART_InitStructure.USART_StopBits = USART_StopBits_1;
    USART_InitStructure.USART_Parity = USART_Parity_No;
    USART_InitStructure.USART_HardwareFlowControl = USART_HardwareFlowControl_None;
    USART_InitStructure.USART_Mode = USART_Mode_Rx | USART_Mode_Tx;
    USART_Init(USART1, &USART_InitStructure);
    
    USART_Cmd(USART1, ENABLE);
}
```

</details>

<details>
<summary>⏰ 定时器PWM配置</summary>

```c
// TIM3 PWM配置 (PA6-TIM3_CH1)
void TIM3_PWM_Config(void)
{
    GPIO_InitTypeDef GPIO_InitStructure;
    TIM_TimeBaseInitTypeDef TIM_TimeBaseStructure;
    TIM_OCInitTypeDef TIM_OCInitStructure;
    
    // 使能时钟
    RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA, ENABLE);
    RCC_APB1PeriphClockCmd(RCC_APB1Periph_TIM3, ENABLE);
    
    // GPIO配置
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_AF;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz;
    GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;
    GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_NOPULL;
    GPIO_Init(GPIOA, &GPIO_InitStructure);
    
    GPIO_PinAFConfig(GPIOA, GPIO_PinSource6, GPIO_AF_TIM3);
    
    // 定时器基础配置
    TIM_TimeBaseStructure.TIM_Period = 1000-1;        // ARR
    TIM_TimeBaseStructure.TIM_Prescaler = 84-1;       // PSC
    TIM_TimeBaseStructure.TIM_ClockDivision = 0;
    TIM_TimeBaseStructure.TIM_CounterMode = TIM_CounterMode_Up;
    TIM_TimeBaseInit(TIM3, &TIM_TimeBaseStructure);
    
    // PWM配置
    TIM_OCInitStructure.TIM_OCMode = TIM_OCMode_PWM1;
    TIM_OCInitStructure.TIM_OutputState = TIM_OutputState_Enable;
    TIM_OCInitStructure.TIM_Pulse = 500;               // CCR
    TIM_OCInitStructure.TIM_OCPolarity = TIM_OCPolarity_High;
    TIM_OC1Init(TIM3, &TIM_OCInitStructure);
    
    TIM_OC1PreloadConfig(TIM3, TIM_OCPreload_Enable);
    TIM_Cmd(TIM3, ENABLE);
}
```

</details>

## 📞 技术支持

### 📚 参考资料
- [STM32F401xx数据手册](https://www.st.com/resource/en/datasheet/stm32f401cb.pdf)
- [STM32F4xx参考手册](https://www.st.com/resource/en/reference_manual/dm00031020-stm32f405-415-stm32f407-417-stm32f427-437-and-stm32f429-439-advanced-armbased-32bit-mcus-stmicroelectronics.pdf)
- [标准外设库用户手册](https://www.st.com/resource/en/user_manual/dm00023896-description-of-stm32f4-hal-and-lowlayer-drivers-stmicroelectronics.pdf)

### 🔗 相关链接
- [STMicroelectronics官网](https://www.st.com/)
- [Keil官方文档](http://www.keil.com/support/docs/)
- [ARM开发者文档](https://developer.arm.com/documentation/)

---

<div align="center">

**🎉 开始您的STM32F401CCU6开发之旅！**

Made with ❤️ for STM32 developers

</div>