# Course Description Template

基于 Typst 的专业大学课程描述文档模板，适用于申请国外大学、学分转换（ECTS）、课程认证等场景。

> **声明**: 本模板可灵活适配任何专业和学校，样式考虑了德国模块手册和通用英文课程描述两种常见类型。

---

## 📋 目录

- [功能特点](#-功能特点)
- [项目结构](#-项目结构)
- [快速开始](#-快速开始)
- [详细配置指南](#-详细配置指南)
- [数据格式](#-数据格式)
- [编译文档](#-编译文档)
- [常见问题](#-常见问题)

---

## ✨ 功能特点

### 📄 文档结构
- **封面页** - 包含学校 Logo、大学名称、专业名称、学院名称、学生信息
- **说明页** - 学分计算说明（可自定义）
- **课程总览表** - 所有课程的汇总（英文/德文双语版本）
- **模块前置表格** - 每个模块前的课程概览（四开关控制显示方式）
- **课程详情页** - 每门课程的详细描述
- **其他未列出课程** - 用于补充不在模块中的课程
- **目录** - 自动生成的文档目录

### 🎨 样式特性
- 自动计算 ECTS 学分（可配置转换系数）
- 自动计算课时（每学分课时数可配置）
- 支持手动覆盖 ECTS 和课时
- 水印背景（学校 Logo）
- 响应式表格设计

### 🌍 多语言支持
- **英文版** - 纯英文课程描述（无版本标题）
- **德文版** - 德语课程描述（无版本标题）
- **双语版** - 同时显示英文和德文（带 "English Version" / "Deutsche Version" 标题）

---
### 示例

| ![Course Description_01](https://github.com/user-attachments/assets/3386e3ba-56c0-4276-bec7-0402a1715abb) | ![Course Description_02](https://github.com/user-attachments/assets/40a4ac76-edd4-4d5c-ab6c-b7a354e588c0) |
| :------------------------------------------------------------------------------------------------------: | :------------------------------------------------------------------------------------------------------: |
| ![Course Description_03](https://github.com/user-attachments/assets/f795e8c6-e42f-42e5-934e-a5b128f1d492) | ![Course Description_04](https://github.com/user-attachments/assets/772e7c05-217c-40d7-8996-7e4da61effe0) |
| ![Course Description_05](https://github.com/user-attachments/assets/ec32a4cf-d1c2-47e9-9477-325cda16a85d) | ![Course Description_06](https://github.com/user-attachments/assets/c557a750-079a-46b8-b3cf-42a224a80dd5) |
| ![Course Description_07](https://github.com/user-attachments/assets/3bf184e0-5009-434f-bba7-6770518637ab) | ![Course Description_08](https://github.com/user-attachments/assets/aa55060c-d2e5-4ac1-9af9-05a81f085166) |>


---
### 💰 支持项目
如果这个课程描述模板对你有帮助，欢迎通过以下方式支持我：

小红书ID：205011192，首页置顶图文内购买

打赏将用于项目的持续维护和新功能开发，感谢你的支持！

---

## 📁 项目结构

```
.
├── template.typ              # 核心模板（样式和渲染函数，一般无需修改）
├── Course Description.typ    # 主内容文件（填写你的课程数据）
├── logo_bupt.png             # 学校 Logo（封面用）
├── logo_bupt2.png            # 学校 Logo 变体
├── logo_bupt_translucent.png # 水印 Logo
├── Course Description.pdf    # 生成的示例文档
└── README.md                 # 本文件
```

---

## 🚀 快速开始

### 1. 安装 Typst

首先安装 Typst 编译器：

```bash
# macOS
brew install typst

# Windows (使用 winget)
winget install --id Typst.Typst

# 或使用 cargo 安装
cargo install typst-cli
```

### 2. 下载模板

克隆或下载本项目：


### 3. 配置你的信息

打开 `Course Description.typ`，修改以下配置：

```typst
// Part 1: 封面配置
#let cover-student-name = "张三"
#let cover-student-id = "202100000001"
#let cover-date = "2025-01-15"
#let cover-major-text = "你的专业名称"
#let cover-school-text = "你的学院名称"
#let cover-university-text = "你的大学名称"
```

### 4. 填写课程数据

在 `Part 6: 数据定义` 中填写你的课程：

```typst
#let data-en = (
  "Mathematics": (
    ("Advanced Mathematics", 4),
    ("Linear Algebra", 3),
  ),
  // ... 更多模块
)
```

### 5. Typst 常用语法

在编写课程描述时，常用到的 Typst 语法格式：

| 语法 | 说明 | 示例 |
|------|------|------|
| `\` | 换行（斜杠+一个空格）| `第一行 \  第二行` |
| `#par(justify: true)[...]` | 段落两端对齐 | `#par(justify: true)[内容]` |
| `#align(center)[...]` | 居中对齐 | `#align(center)[居中内容]` |
| `#align(right)[...]` | 右对齐 | `#align(right)[靠右内容]` |
| `#h(1fr)`| 整行右对齐| `#h(1fr) +文字`|
| `*粗体*` | 粗体文字 | `*粗体文本*` |
| `_斜体_` | 斜体文字 | `_斜体文本_` |
| `#pagebreak()` | 强制分页 | 在需要分页处插入 |
| `// 注释` | 单行注释 | `// 这是注释` |
| `/* 多行 */` | 多行注释 | `/* 多行注释 */` |
| `== 标题` | 二级标题 | `== 章节标题` |
| `=== 标题` | 三级标题 | `=== 小节标题` |
| `- 项目` | 无序列表 | `- 列表项` |
| `+ 项目` | 有序列表 | `+ 列表项` |


**使用建议**：
- 需要在特定位置分页时，使用 `#pagebreak()`
- 想要强调某些文字时，使用`*内容*`，即可粗体
- 换行使用 `\` 而不是直接回车，Typst 中连续回车不会保留

---

## 📖 详细配置指南

### Part 1: 封面配置

#### 基本显示控制

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `cover-show` | 是否显示封面 | `true` |

#### 封面大标题配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `cover-title-show` | 是否显示大标题 | `true` |
| `cover-title-text` | 标题文本 | `"Course Description"` |
| `cover-title-size` | 字体大小 | `30pt` |
| `cover-title-weight` | 字体粗细 | `"bold"` |

#### Logo 配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `cover-logo-show` | 是否显示 Logo | `true` |
| `cover-logo-path` | Logo 图片路径 | `"logo_bupt2.png"` |
| `cover-logo-width` | Logo 宽度 | `100%` |

#### Logo 下方的大学名称（显示在 Logo 下方、Course Description 标题上方）

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `cover-university-show` | 是否显示 | `true` |
| `cover-university-text` | 大学名称文本 | `"Shenzhen Technology University"` |
| `cover-university-size` | Logo 下方字体大小 | `30pt` |
| `cover-university-weight` | Logo 下方字体粗细 | `"bold"` |

#### 专业名称配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `cover-major-show` | 是否显示专业名称 | `true` |
| `cover-major-text` | 专业名称 | `"Automotive Service Engineering"` |
| `cover-major-size` | 字体大小 | `16pt` |
| `cover-major-weight` | 字体粗细 | `"semibold"` |

#### 学院名称配置（显示在专业名称下方）

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `cover-school-show` | 是否显示学院名称 | `true` |
| `cover-school-text` | 学院名称 | `"School of Urban Transportation and Logistics"` |

#### 学生信息配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `cover-student-name-show` | 是否显示姓名 | `true` |
| `cover-student-name` | 学生姓名 | 必填 |
| `cover-student-id-show` | 是否显示学号 | `true` |
| `cover-student-id` | 学号 | 必填 |
| `cover-date-show` | 是否显示日期 | `true` |
| `cover-date` | 日期 | 必填 |

#### 水印配置

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `watermark-show` | 是否显示水印 | `true` |
| `watermark-path` | 水印图片路径 | `"logo_bupt_translucent.png"` |
| `watermark-width` | 水印宽度 | `160mm` |

### Part 2: 说明页配置

```typst
#let explanation-show = true
#let explanation-content = [
  // 自定义说明内容
  这里填写学分计算说明...
]
```

### Part 3: 课程总览表配置

控制文档前面的 **Module Content / Modulinhalte** 总表：

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `module-content-show-en` | 显示英文版 | `true` |
| `module-content-show-de` | 显示德文版 | `true` |
| `module-content-col-width` | Module 列宽度 | `100pt` |
| `credit-hours-per-credit` | 每学分课时数 | `18` |
| `credit-ects-conversion-ratio` | ECTS 转换系数 | `1.5` |

**ECTS 计算公式**: `ECTS = Credit × conversion-ratio`

### Part 4: 模块前置表格配置

每个模块标题下方可以显示课程概览表，通过**四个开关**控制：

| 开关 | 说明 | 效果 |
|------|------|------|
| `module-table-show` | 总开关 | 是否显示前置表格 |
| `module-table-show-en` | 英文版 | 英文表格 |
| `module-table-show-de` | 德文版 | 德文表格 |
| `module-table-show-bilingual` | 双语版 | 双语表格（有 "English Version" / "Deutsche Version" 标题） |

**使用建议**:
- 只显示英文: `show-en: true, show-de: false, show-bilingual: false`
- 只显示德文: `show-en: false, show-de: true, show-bilingual: false`
- 双语带标题: `show-en: false, show-de: false, show-bilingual: true`
- 同时显示英文+德文（无标题）: `show-en: true, show-de: true`
- 全部关闭: `show: false`

### Part 5: 其他未列出课程配置

用于补充不在模块中的课程：

| 配置项 | 说明 | 默认值 |
|--------|------|--------|
| `other-courses-show` | 是否显示其他未列出课程表格 | `true` |
| `other-courses-data` | 其他课程数据 | 见下文格式 |

**数据格式**:
```typst
#let other-courses-data = (
  ("课程名称", 学分),
  ("课程名称", 学分, 手动ECTS),
)
```

### Part 6: 数据定义

#### 英文数据格式

```typst
#let data-en = (
  "Mathematics": (                    // 模块名
    ("Advanced Mathematics B1", 4),   // (课程名, 学分)
    ("Advanced Mathematics B2", 4, 6), // (课程名, 学分, 手动ECTS)
    ("Linear Algebra", 3, 4.5, 54),   // (课程名, 学分, 手动ECTS, 手动课时)
  ),
  "Physics": (
    ("College Physics", 3),
  ),
)
```

#### 德文数据格式

与英文数据格式相同：

```typst
#let data-de = (
  "Mathematik": (
    ("Höhere Mathematik B1", 4),
    ("Höhere Mathematik B2", 4),
  ),
)
```

### Part 7: 模板应用

这部分一般不需要修改，只需要确保配置正确传递：

```typst
#show: template-course-description.with(
  cover-show: cover-show,
  cover-title-show: cover-title-show,
  // ... 其他配置
)
```

### Part 8: 模块与课程详情

为每个模块添加课程详情：

```typst
= Mathematics  // 模块标题

#module-table(
  data-en: data-en,
  data-de: data-de,
  module-name-en: "Mathematics",
  module-name-de: "Mathematik",
  is-visible: module-table-show,
  show-en: module-table-show-en,
  show-de: module-table-show-de,
  show-bilingual: module-table-show-bilingual,
)

#course(
  name: [Advanced Mathematics B1],
  credit: 4,
  description: [
    This course covers...
  ],
)
```

#### `module-table()` 函数参数
以下两个数据是否填写取决于在前面的模块前置表格配置选择了哪一项，当选择对应选项需要填写对应版本的模块名
| 参数 | 说明 |
|------|------|
| `module-name-en` | 英文模块名 |
| `module-name-de` | 德文模块名 |

#### `course()` 函数参数

| 参数 | 说明 | 必填 |
|------|------|------|
| `name` | 课程名称 | ✅ |
| `credit` | 学分 | ✅ |
| `ects` | ECTS（可选，自动计算） | ✅ |
| `hours` | 课时（可选，自动计算） | ❌ |
| `description` | 课程描述 | ❌ |
| `content` | 课程内容 | ❌ |
| `assessment` | 评估方式 | ❌ |
| `grade` | 成绩 | ❌ |
| `semester` | 学期 | ❌ |
| `thesis-title` | 论文题目（毕业论文用） | ❌ |
| `thesis-description` | 论文描述 | ❌ |

---

## 🔢 数据格式详解

### 课程数据元组格式

课程数据支持 2-4 个元素：

```typst
// 2个元素: 自动计算 ECTS 和课时
("Course Name", 4)

// 3个元素: 手动指定 ECTS，自动计算课时
("Course Name", 4, 6)

// 4个元素: 手动指定 ECTS 和课时
("Course Name", 4, 6, 72)
```

### 数据优先级

1. **手动指定** > 自动计算
2. 如果在 `course()` 中指定了 `ects` 或 `hours`，会覆盖数据中的值
3. 德文数据中的手动值优先于英文数据中的对应值

---

## 🛠️ 编译文档

### 基本编译

```bash
typst compile "Course Description.typ"
```

### 指定输出文件名

```bash
typst compile "Course Description.typ" "My Course Description.pdf"
```

### Watch 模式（推荐开发时使用）

```bash
typst watch "Course Description.typ"
```

### 指定字体路径（如有自定义字体）

```bash
typst compile --font-path ./fonts "Course Description.typ"
```

---

## ❓ 常见问题

### Q1: 如何隐藏某个模块的前置表格？

在 `#module-table()` 调用处设置 `is-visible: false`：

```typst
#module-table(
  data-en: data-en,
  module-name-en: "Mathematics",
  is-visible: false,  // 隐藏此模块的前置表格
)
```

### Q2: 如何调整表格列宽？

修改 `module-content-col-width`：

```typst
#let module-content-col-width = 120pt  // 增加 Module 列宽度
```

### Q3: 德文数据显示不正确？

确保德文数据中的模块名与 `module-name-de` 参数一致：

```typst
// 数据定义
#let data-de = (
  "Mathematik": (...),  // 模块名
)

// 调用时
#module-table(
  module-name-de: "Mathematik",  // 必须与数据中的键名一致
)
```

### Q4: 如何添加新的课程字段？

修改 `template.typ` 中的 `course()` 函数，添加新的参数和表格行。

### Q5: 水印 Logo 显示不清晰？

调整 `watermark-width` 或使用更高分辨率的 Logo 图片。

### Q6: 封面布局如何调整？

封面元素从上到下依次为：
1. Logo
2. 大学名称
3. Course Description 标题
4. 专业名称
5. 学院名称

通过对应的 `show` 开关可以控制每个元素的显示/隐藏。


---

## 🙏 致谢

- [Typst](https://typst.app/) - 现代化的排版系统
- https://github.com/dsyislearning/typst-course-description-template - 原始模板设计参考
