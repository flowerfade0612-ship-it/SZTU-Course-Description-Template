// ==========================================
// 课程描述文档模板 (Course Description Template)
// ==========================================
// 
// 本模板用于生成申请学校时所需的课程描述文档。
// 使用方法：
//   1. 修改下方的配置变量（Part 1-6）
//   2. 填写课程数据（Part 7-8）
//   3. 运行：typst compile "Course Description.typ"
//
// ==========================================

#import "template.typ": template-course-description, module-content, module-table, course, other-courses-table


// =============================================================================
// PART 1: 封面配置 (Cover Configuration)
// =============================================================================

// 封面是否显示
#let cover-show = true

// ------------------------------------
// 封面大标题 "Course Description" 配置
// ------------------------------------
#let cover-title-show = true
#let cover-title-text = "Course Description"
#let cover-title-size = 30pt
#let cover-title-weight = "bold"

// ------------------------------------
// 封面 Logo 配置
// ------------------------------------
#let cover-logo-show = true
#let cover-logo-path = "logo_bupt2.png"
#let cover-logo-width = 100%

// ------------------------------------
// 封面 Logo 下方的大学名称配置
// （显示在 Logo 下方、Course Description 标题上方）
// ------------------------------------
#let cover-university-above-title-show = true
#let cover-university-above-title-text = "Shenzhen Technology University"
#let cover-university-above-title-size = 30pt
#let cover-university-above-title-weight = "bold"

// ------------------------------------
// 专业名称配置
// ------------------------------------
#let cover-major-show = true
#let cover-major-text = "Automotive Service Engineering"
#let cover-major-size = 16pt
#let cover-major-weight = "semibold"

// ------------------------------------
// 学院名称配置（显示在专业名称下方）
// ------------------------------------
#let cover-school-show = true
#let cover-school-text = "School of Urban Transportation and Logistics"

// ------------------------------------
// 学生信息配置
// ------------------------------------

// 学生姓名
#let cover-student-name-show = true
#let cover-student-name = "Li Hua"

// 学生学号
#let cover-student-id-show = true
#let cover-student-id = "1234567890"

// 日期
#let cover-date-show = true
#let cover-date = "2026-1-1"
// ------------------------------------
// 水印配置
// ------------------------------------
#let watermark-show = true
#let watermark-path = "logo_bupt_translucent.png"
#let watermark-width = 160mm


// =============================================================================
// PART 2: 说明页配置 (Explanation Page Configuration)
// =============================================================================

// 是否显示说明页
#let explanation-show = true

// 说明页内容（可自由编辑文本格式、字体大小等）
#let explanation-content = [
  #align(center)[
    #v(1.5fr)
    
    // 说明页标题
    #text(weight: "bold", size: 30pt, "Explanation")
    
    #v(1.5fr)
    
    // 学分说明
    #text(weight: "semibold", size: 18pt)[
      1. 1 Credit in a course in Shenzhen Technology University corresponds 18 course hours (1 course hour = 45 min)
    ]
    
    #v(1fr)
    
    // ECTS 换算说明
    #text(weight: "medium", size: 16pt)[
      *2.* The European Credit Transfer System (ECTS) stipulates that the minimum ECTS required for undergraduate
      graduation in 3 years is 180 ECTS, while the standard period of study of the Bachelor's *Automotive Service Engineering* 
      at *Shenzhen Technology University* is 8 semesters (corresponding to ECTS = 30 by 8 = 240). 
      The minimum required credits for graduation with us are *202*. The conversion ratio between Credit (China) and ECTS 
      is therefore defined as follows:
      
      1 Credit (China) corresponding to 240 ÷ 202 ≈ *1.2* ECTS
    ]
  ]
  
  #v(2fr)
  
  // 学生信息表格
  //PS：如果觉得这一部分没有必要，或需要修改表格内容，可以直接删除或修改下面的代码块。
  #let table-font = text.with(weight: "bold")
  
  #table(
    columns: (auto, 1fr),
    align: horizon,
    table-font[Major in], table-font[Automotive Service Engineering],
    table-font[Nominal duration of my program in years], table-font[4 years],
    table-font[Total Credits], table-font[202],
    table-font[School], table-font[Shenzhen Technology University],
    table-font[Student ID], table-font[202100402002],
  )
  
  #v(2fr)
]


// =============================================================================
// PART 3: 课程总览表配置 (Module Content Configuration)
// =============================================================================

// 是否显示模块总览表（英文版 Course Content）
#let module-content-show-en = true

// 是否显示模块总览表（德语版 Modulinhalte）
#let module-content-show-de = true

// Module 列宽度（如果觉得太宽可调小，如 80pt；太窄可调大，如 120pt）
#let module-content-col-width = 100pt

// 学分计算配置（影响所有学分相关计算）
// 每学分对应的课时数（默认 18 小时）
#let credit-hours-per-credit = 18

// ECTS 换算系数
// 计算公式：ECTS = (30 × 正常毕业学期数) ÷ 毕业总学分要求
// 例如：(30 × 8) ÷ 202 ≈ 1.19 ≈ 1.2
#let credit-ects-conversion-ratio = 1.5


// =============================================================================
// PART 4: 模块前置表格配置 (Module Table Configuration)
// =============================================================================

// Module Table 显示控制开关
// 四个开关分别控制不同的显示方式：

// 开关1：总开关 - 是否显示 module table
#let module-table-show = true

// 开关2：是否显示英文版（无英文标题）
#let module-table-show-en = true

// 开关3：是否显示德文版（无德文标题）
#let module-table-show-de = false

// 开关4：是否显示双语版（有双语 version 标题）
#let module-table-show-bilingual = false


// =============================================================================
// PART 5: 其他未列出课程配置 (Other Courses Not Included)
// =============================================================================
//PS：这一部分是为了满足一些特殊情况，比如申请学校要求提供所有课程的描述，但有些课程不在上述模块中，或者你不想为它们单独创建模块和课程详情页。这时你可以使用这一部分来列出这些课程的基本信息（如课程名称和学分），并在文档末尾以表格形式展示。

// 是否显示其他未列出课程表格
#let other-courses-show = true

// 其他未列出课程数据
// 格式：(("课程名称", 学分), ...) 或 (("课程名称", 学分, 手动ECTS), ...)
#let other-courses-data = (
  ("Physical Education", 1),
  ("Moral and Legal Education", 2),
  ("Military Theory", 1),
)


// =============================================================================
// PART 6: 数据定义 (Data Definition)
// =============================================================================

// ------------------------------------
// 6.1 英文课程数据（所有英文表格共用此数据）
// 
// 数据格式支持（自动计算 ECTS 和课时）：
//   "模块名": (("课程名", 学分), ...)
// 
// 数据格式支持（手动指定 ECTS）：
//   "模块名": (("课程名", 学分, 手动ECTS), ...)
// 
// 数据格式支持（手动指定 ECTS 和课时）：
//   "模块名": (("课程名", 学分, 手动ECTS, 手动课时), ...)
//
// 示例：
//   ("Advanced Mathematics B1", 4)        - 4学分，自动计算 ECTS 和课时
//   ("Advanced Mathematics B1", 4, 10)    - 4学分，手动指定 ECTS 为 10
//   ("Advanced Mathematics B1", 4, 10, 80) - 4学分，手动指定 ECTS 为 10，课时为 80
// ------------------------------------
#let data-en = (
  "Mathematics": (
    ("Advanced Mathematics B1", 4),
    ("Advanced Mathematics B2", 4),
  ),
  "Basic Physics": (
    ("College Physics B1", 3),
    ("College Physics B2", 3),
  ),
  "Bachelor's Thesis": (
    ("Undergraduate Graduation Project Design(Thesis)", 16),
  ),
)

// ------------------------------------
// 6.2 德语课程数据（用于德语版表格）
// 
// 数据格式支持（与英文数据相同）：
//   "模块名": (("德语课程名", 学分), ...)                    - 自动计算 ECTS 和课时
//   "模块名": (("德语课程名", 学分, 手动ECTS), ...)          - 使用手动 ECTS
//   "模块名": (("德语课程名", 学分, 手动ECTS, 手动课时), ...) - 使用手动 ECTS 和课时
//
// 注意：如果德语数据中没有提供手动 ECTS/课时，系统会自动使用英文数据中对应课程的值
// ------------------------------------
#let data-de = (
  "Mathematik": (
    ("Höhere Mathematik B1", 4),
    ("Höhere Mathematik B2", 4),
  ),
  "Grundlagen der Physik": (
    ("Hochschulphysik B1", 3),
    ("Hochschulphysik B2", 3),
  ),
  
  "Bachelorarbeit": (
    ("Bachelor-Abschlussarbeit (Thesis)", 16),
  ),
)


// =============================================================================
// PART 7: 模板应用（一般不需要修改）
// =============================================================================

#show: template-course-description.with(
  // ---- 封面配置 ----
  cover-show: cover-show,
  
  // 封面大标题
  cover-title-show: cover-title-show,
  cover-title-text: cover-title-text,
  cover-title-size: cover-title-size,
  cover-title-weight: cover-title-weight,
  
  // 学院名称
  cover-school-show: cover-school-show,
  cover-school-text: cover-school-text,
  
  // 专业名称
  cover-major-show: cover-major-show,
  cover-major-text: cover-major-text,
  cover-major-size: cover-major-size,
  cover-major-weight: cover-major-weight,
  
  // 学生信息
  cover-student-name-show: cover-student-name-show,
  cover-student-name: cover-student-name,
  cover-student-id-show: cover-student-id-show,
  cover-student-id: cover-student-id,
  cover-date-show: cover-date-show,
  cover-date: cover-date,
  
  // Logo
  cover-logo-show: cover-logo-show,
  cover-logo-path: cover-logo-path,
  cover-logo-width: cover-logo-width,
  
  // Logo 下方的大学名称
  cover-university-above-title-show: cover-university-above-title-show,
  cover-university-above-title-text: cover-university-above-title-text,
  cover-university-above-title-size: cover-university-above-title-size,
  cover-university-above-title-weight: cover-university-above-title-weight,
  
  // ---- 水印配置 ----
  watermark-show: watermark-show,
  watermark-path: watermark-path,
  watermark-width: watermark-width,
  
  // ---- 说明页配置 ----
  explanation-show: explanation-show,
  explanation-content: explanation-content,
  
  // ---- 模块总览表配置 ----
  module-content-show-en: module-content-show-en,
  module-content-show-de: module-content-show-de,
  module-content-col-width: module-content-col-width,
  credit-hours-per-credit: credit-hours-per-credit,
  credit-ects-conversion-ratio: credit-ects-conversion-ratio,
  
  // ---- 模块前置表格配置 ----
  module-table-show: module-table-show,
  module-table-show-en: module-table-show-en,
  module-table-show-de: module-table-show-de,
  module-table-show-bilingual: module-table-show-bilingual,
  
  // ---- 数据 ----
  data-en: data-en,
  data-de: data-de,
)


// =============================================================================
// PART 8: 模块与课程详情（按模块填写）
// =============================================================================
// PS：这一部分是课程描述文档的核心内容，你需要为每个模块创建一个模块标题
// 并在下面为该模块的每门课程创建一个课程详情页。课程详情页需要包含课程名称、学分、ECTS（如果有手动指定）和课程描述。
// 课程描述可以是一个简短的文本，也可以包含更详细的内容，如课程大纲、教学方法、评估方式等。
// 你可以根据需要自由编辑课程描述的内容和格式。
// 课程详情允许填写的字段包括：
// - name: 课程名称（必填）
// - credit: 学分（必填）
// - ects: ECTS 学分（可选，如果 data-en/data-de 中已经提供了手动 ECTS 则不需要再填写）
// - description: 课程描述（可选，可以是文本或列表）
// - thesis-title: 论文题目（仅毕业论文课程使用，选填）
// - thesis-description: 论文描述（仅毕业论文课程使用，选填，可以包含研究背景、目的、方法、核心内容和结论等）
// - Course Hours: 课程总课时（可选，如果 data-en/data-de 中已经提供了手动课时则不需要再填写）
// - My Grade: 我的成绩（可选，根据需要填写）
// - Preparatory Course(s): 预备课程（可选，根据需要填写）
// - Prerequisite(s): 先修课程（可选，根据需要填写）
// - Content: 课程内容（可选，根据需要填写，可以是文本或列表）
// - Assessment: 评估方式（可选，根据需要填写，可以是文本或列表）

// module-table 是放置在每个模块标题下的前置表格，展示该模块下所有课程的基本信息（课程名称、学分、ECTS 等）
// 内容由 data-en 和 data-de 中对应模块的数据自动生成。
//
// 使用说明（对应 Part 4 的四个开关）：
// - 开关1（总开关）：控制是否显示 module-table
// - 开关2（英文版）：显示英文版表格（无版本标题），需填写 module-name-en
// - 开关3（德文版）：显示德文版表格（无版本标题），需填写 module-name-de
// - 开关4（双语版）：显示双语版表格（有 English Version / Deutsche Version 标题），需同时填写 module-name-en 和 module-name-de
//
// 注意：可以同时开启多个开关，例如同时开启英文版和德文版（无标题）+ 双语版（有标题），
// 但通常建议只选择一种显示方式。

// 以下举了一些例子，你可以根据需要修改课程描述的内容和格式，或者添加更多字段：

= Mathematics//模块标题示例

#module-table(// 模块前置表格示例，取决于你是否开启了对应的显示开关，如果选择不显示这一部分，则这一部分代码可以直接删除或注释掉
  data-en: data-en,
  data-de: data-de,
  module-name-en: "Mathematics",
  module-name-de: "Mathematik",
  is-visible: module-table-show,
  show-en: module-table-show-en,
  show-de: module-table-show-de,
  show-bilingual: module-table-show-bilingual,
)

#course(//课程详情示例
  name: [Advanced Mathematics B1],
  credit: 4,
  ects: 10,
  description: [
    This course offers a concise overview of the core theories and practical methods of single-variable calculus and elementary ordinary differential equations, serving as a foundational mathematics course for engineering and science undergraduates.
    
    *Detailed course content includes:*
    
    1. *Functions, limits and continuity:* Basic functions, limit operations, and function continuity.
    2. *Single-variable differential calculus:* Derivatives, differentials, mean value theorems, and application of derivatives.
    3. *Single-variable integral calculus:* Indefinite and definite integrals, integration methods, and integral applications.
    4. *Elementary ordinary differential equations:* First-order differential equations and second-order linear differential equations with constant coefficients.
  ],
)

#course(
  name: [Advanced Mathematics B2],
  credit: 4,
  description: [
    This course provides a concise overview of the core theories and practical methods of multivariable calculus and related branches.
    
    *Detailed course content includes:*
    
    1. *Differential equations:* Homogeneous equations, first-order linear differential equations.
    2. *Vector algebra and space analytic geometry:* Vector operations, plane and line equations.
    3. *Multivariable differential calculus:* Partial derivatives, total differentials.
    4. *Multiple integrals:* Double and triple integrals and their basic applications.
  ],
)

= Basic Physics

#module-table(
  data-en: data-en,
  data-de: data-de,
  module-name-en: "Basic Physics",
  module-name-de: "Grundlagen der Physik",
  is-visible: module-table-show,
  show-en: module-table-show-en,
  show-de: module-table-show-de,
  show-bilingual: module-table-show-bilingual,
)

#course(
  name: [College Physics B1],
  credit: 3,
  description: [
    This course offers a concise overview of the core theories of mechanics, special relativity, kinetic theory of gases, and thermodynamics.
  ],
)

#course(
  name: [College Physics B2],
  credit: 3,
  description: [
    This course offers a concise overview of electromagnetism, vibrations and waves, optics, and quantum physics.
  ],
)

// -------- Bachelor's Thesis 模块 --------
= Bachelor's Thesis

#module-table(
  data-en: data-en,
  data-de: data-de,
  module-name-en: "Bachelor's Thesis",
  module-name-de: "Bachelorarbeit",
  is-visible: module-table-show,
  show-en: module-table-show-en,
  show-de: module-table-show-de,
  show-bilingual: module-table-show-bilingual,
)

#course(
  name: [Undergraduate Graduation Project Design(Thesis)],
  credit: 16,
  thesis-title: [Research on Tort Liability and Insurance System of Intelligent Connected Vehicles],
  thesis-description: [
    *Background and Purpose*
    
    XXXXXX
    
    *Research Methods*
    
    1. *Literature Review*: XXXXX  
    2. *Comparative Analysis*: XXXXX
    
    *Core Content*  
    
    1. *XXXXX*: 
    2. *XXXXX*:  
    
    *Key Conclusions*
    
    XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
  ],
)


// =============================================================================
// PART 9: 其他未列出课程
// =============================================================================

#if other-courses-show [
  = Other courses not listed above include:
  
  #other-courses-table(
    courses: other-courses-data,
  )
]

// =============================================================================
// PART 10: 文档结尾
// =============================================================================
//这一部分一般为文档的结尾页，你可以自行编辑内容，下面已经给了一个示例，你可以根据需要修改：
Contact Person:\
Contact Information:

#h(1fr)School of Urban Transportation and Logistics\
#h(1fr)Shenzhen Technology University

// 文档结束
