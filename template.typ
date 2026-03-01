// =============================================================================
// 课程描述文档模板 (Course Description Template)
// 
// 本文件为模板核心文件，包含所有样式定义和渲染函数。
// 一般不需要修改此文件，只需修改 Course Description.typ 中的配置即可。
// =============================================================================


// =============================================================================
// PART 1: 全局状态变量 (Global State Variables)
// 用于在文档各处共享配置参数
// =============================================================================

// Module Table 显示控制开关
#let state-module-table-show = state("module-table-show", true)
#let state-module-table-show-en = state("module-table-show-en", true)
#let state-module-table-show-de = state("module-table-show-de", true)
#let state-module-table-show-bilingual = state("module-table-show-bilingual", true)

// ECTS 换算系数
#let state-ects-conversion-ratio = state("ects-conversion-ratio", 1.2)

// 每学分课时数
#let state-credit-hours = state("credit-hours", 18)


// =============================================================================
// PART 2: 模块总览表函数 (Module Content Function)
// 生成 Course Content / Modulinhalte 总表
// =============================================================================

// 数据格式支持：
//   ("课程名", 学分)           - 自动计算 ECTS
//   ("课程名", 学分, 手动ECTS) - 使用手动 ECTS
#let module-content(
  data: none,        // 模块数据字典
  col-width: 100pt, // Module 列宽度
  title: "Module Content",  // 页面标题
  headers: ("Module", "Course Title", "Credit", "ECTS", "Total ECTS"), // 表头
) = context {
  if data.len() == 0 {
    return text(fill: orange)[No module data provided.]
  }
  
  let conv-ratio = state-ects-conversion-ratio.get()
  let table-cells = ()
  let module-idx = 0
  
  for (module-name, courses) in data {
    let module-num = module-idx + 1
    
    // 处理课程数据，支持手动指定 ECTS
    let processed-courses = courses.map(course => {
      let course-name = course.at(0)
      let credit = course.at(1)
      // 如果提供了第3个值，使用手动 ECTS，否则自动计算
      let manual-ects = if course.len() >= 3 { course.at(2) } else { none }
      let final-ects = if manual-ects != none { manual-ects } else { calc.round(credit * conv-ratio, digits: 2) }
      return (course-name, credit, final-ects)
    })
    
    let total-credits = processed-courses.map(c => c.at(1)).sum()
    let total-ects = processed-courses.map(c => c.at(2)).sum()
    let course-count = processed-courses.len()
    
    for (cidx, course) in processed-courses.enumerate() {
      let course-name = course.at(0)
      let credit = course.at(1)
      let ects = course.at(2)
      let course-code = str(module-num) + "." + str(cidx + 1) + " " + course-name
      
      if cidx == 0 {
        // 模块名使用 rowspan 跨多行
        table-cells.push(table.cell(rowspan: course-count)[#module-num.#module-name])
        table-cells.push([#course-code])
        table-cells.push([#credit])
        table-cells.push([#ects])
        table-cells.push(table.cell(rowspan: course-count)[#calc.round(total-ects, digits: 2)])
      } else {
        table-cells.push([#course-code])
        table-cells.push([#credit])
        table-cells.push([#ects])
      }
    }
    module-idx = module-idx + 1
  }
  
  [
    #v(1fr)
    #h(1fr)#text(weight: "bold", size: 30pt, title)#h(1fr)
    #v(20pt)  // 增加标题下方的间距
    
    // 设置表格单元格样式
    #show table.cell.where(x: 0): it => strong(align(center+horizon, it))
    #show table.cell.where(y: 0): it => strong(align(center+horizon, it))
    #show table.cell.where(x: 4): it => align(center+horizon, it)
    #show table.cell.where(x: 2): it => align(center+horizon, it)
    #show table.cell.where(x: 3): it => align(center+horizon, it)
    
    #table(
      table.header(..headers.map(h => [#h])),
      columns: (col-width, 1fr, auto, auto, auto),
      ..table-cells
    )
    
    #v(1fr)
  ]
}


// =============================================================================
// PART 3: 模块前置表格底层渲染函数 (Module Table Render Function)
// =============================================================================

// 数据格式支持：
//   ("课程名", 学分)                    - 自动计算 ECTS 和课时
//   ("课程名", 学分, 手动ECTS)          - 使用手动 ECTS，自动计算课时
//   ("课程名", 学分, 手动ECTS, 手动课时) - 使用手动 ECTS 和课时
#let module-table-render(
  courses: (),
  ect-rate: none,
  hour-rate: none,
  row-padding: 0.7em,
  version-title: none,
  headers: none,
  total-labels: none,
) = context {
  // 如果没有传入参数，从全局状态读取
  let final-ect-rate = if ect-rate != none { ect-rate } else { state-ects-conversion-ratio.get() }
  let final-hour-rate = if hour-rate != none { hour-rate } else { state-credit-hours.get() }
  
  // 使用默认表头和标签
  let final-headers = if headers != none { headers } else { ("Course Title", "Credit", "ECT Credit", "Teaching Hour") }
  let final-total-labels = if total-labels != none { total-labels } else { ("Total Credits", "ECT Credits") }
  
  // 处理课程数据，支持手动指定 ECTS 和课时
  let processed-courses = courses.map(row => {
    let title = row.at(0)
    let credit = row.at(1)
    // 如果提供了第3个值，使用手动 ECTS，否则自动计算
    let manual-ects = if row.len() >= 3 { row.at(2) } else { none }
    // 如果提供了第4个值，使用手动课时，否则自动计算
    let manual-hours = if row.len() >= 4 { row.at(3) } else { none }
    
    let final-ects = if manual-ects != none { 
      manual-ects 
    } else { 
      calc.round(credit * final-ect-rate, digits: 2) 
    }
    
    let final-hours = if manual-hours != none { 
      manual-hours 
    } else { 
      calc.round(credit * final-hour-rate, digits: 1) 
    }
    
    return (title, credit, final-ects, final-hours)
  })
  
  // 计算总计（使用实际的 ECTS 值）
  let total-credits = processed-courses.map(it => it.at(1)).sum()
  let total-ect = processed-courses.map(it => it.at(2)).sum()
  
  // 构建表格显示数据
  let display-data = processed-courses.map(row => {
    let title = row.at(0)
    let credit = row.at(1)
    let ect = row.at(2)
    let hour = row.at(3)
    
    // 添加垂直间距以提高可读性
    let title-content = align(center, [
      #v(row-padding)
      #box(text(hyphenate: false)[#title])
      #v(row-padding)
    ])
    
    return (title-content, [#credit], [#ect], [#hour])
  })
  
  // 渲染表格
  linebreak()
  
  // 显示版本标题（如果有）
  if version-title != none {
    text(weight: "bold", size: 16pt)[#version-title]
    v(0.5em)
  }
  
  set text(weight: "semibold", size: 12pt)
  
  table(
    columns: (1fr, auto, auto, auto),
    rows: (auto),
    align: center + horizon,
    
    [*#final-headers.at(0)*], [*#final-headers.at(1)*], [*#final-headers.at(2)*], [*#final-headers.at(3)*],
    
    ..display-data.flatten(),
    
    table.cell(
      colspan: 4,
      align: center,
      text(style: "italic", weight: "bold")[
        #final-total-labels.at(0): #calc.round(total-credits, digits: 2) 
        #h(2em) 
        #final-total-labels.at(1): #calc.round(total-ect, digits: 2) 
      ]
    )
  )
  linebreak()
}


// =============================================================================
// PART 4: 模块前置表格函数 (Module Table Functions)
// 生成每个模块前的课程汇总表格
// 四个开关控制：show（总开关）、show-en（英文版）、show-de（德文版）、show-bilingual（双语版）
// =============================================================================

// ---- 版本1：纯英文版 ----
#let module-table-en(
  data,            // 数据字典
  module-name,     // 模块名称
  visible: auto,   // 是否可见
  show-version-title: false,  // 是否显示版本标题
) = context {
  // 检查是否显示英文版
  let should-show = if visible != auto { 
    visible 
  } else { 
    state-module-table-show.get() and state-module-table-show-en.get()
  }
  
  if not should-show {
    return none
  }
  
  let courses = data.at(module-name, default: none)
  if courses == none or courses.len() == 0 {
    return text(size: 10pt, fill: gray)[Module "#module-name" - no data]
  }
  
  return module-table-render(
    courses: courses,
    version-title: if show-version-title { "English Version" } else { none },
    headers: ("Course Title", "Credit", "ECT Credit", "Teaching Hour"),
    total-labels: ("Total Credits", "ECT Credits"),
  )
}

// ---- 版本2：纯德文版 ----
#let module-table-de(
  data,            // 数据字典（德语）
  module-name,     // 模块名称
  visible: auto,   // 是否可见
  show-version-title: false,  // 是否显示版本标题
) = context {
  // 检查是否显示德文版
  let should-show = if visible != auto { 
    visible 
  } else { 
    state-module-table-show.get() and state-module-table-show-de.get()
  }
  
  if not should-show {
    return none
  }
  
  let courses = data.at(module-name, default: none)
  if courses == none or courses.len() == 0 {
    return text(size: 10pt, fill: gray)[Modul "#module-name" - keine Daten]
  }
  
  return module-table-render(
    courses: courses,
    version-title: if show-version-title { "Deutsche Version" } else { none },
    headers: ("Kurstitel", "Credits", "ECTS-Punkte", "Unterrichtsstunden"),
    total-labels: ("Gesamtcredits", "ECTS-Punkte"),
  )
}

// ---- 版本3：双语版（带标题）----
// 
// 数据格式支持（德文和英文都可以）：
//   ("课程名", 学分)                    - 自动计算 ECTS 和课时
//   ("课程名", 学分, 手动ECTS)          - 使用手动 ECTS，自动计算课时
//   ("课程名", 学分, 手动ECTS, 手动课时) - 使用手动 ECTS 和课时
//
// 注意：德文数据和英文数据的格式完全相同，都支持手动指定
//
#let module-table-bilingual(
  data-en,           // 英文数据
  data-de,           // 德语数据
  module-name-en,    // 英文模块名
  module-name-de,    // 德语模块名
  visible: auto,     // 是否可见
) = context {
  // 检查是否显示双语版
  let should-show = if visible != auto { 
    visible 
  } else { 
    state-module-table-show.get() and state-module-table-show-bilingual.get()
  }
  
  if not should-show {
    return none
  }
  
  // 获取课程列表
  let en-courses = data-en.at(module-name-en, default: none)
  let de-courses-raw = data-de.at(module-name-de, default: none)
  
  if en-courses == none or en-courses.len() == 0 {
    return text(size: 10pt, fill: gray)[Module "#module-name-en" - no data]
  }
  
  // 构建德语课程列表（保留完整的元组格式，支持手动 ECTS 和课时）
  let de-courses = if de-courses-raw != none and de-courses-raw.len() > 0 {
    de-courses-raw.enumerate().map(((idx, de-course)) => {
      let de-name = de-course.at(0)
      let de-credit = if de-course.len() >= 2 { 
        de-course.at(1) 
      } else { 
        en-courses.at(idx, default: (none, 0)).at(1, default: 0) 
      }
      let manual-ects = if de-course.len() >= 3 { de-course.at(2) } else { none }
      let manual-hours = if de-course.len() >= 4 { de-course.at(3) } else { none }
      
      if manual-hours != none {
        (de-name, de-credit, manual-ects, manual-hours)
      } else if manual-ects != none {
        (de-name, de-credit, manual-ects)
      } else {
        (de-name, de-credit)
      }
    })
  } else {
    ()
  }
  
  return [
    // 英文版本
    #module-table-render(
      courses: en-courses,
      version-title: "English Version",
      headers: ("Course Title", "Credit", "ECT Credit", "Teaching Hour"),
      total-labels: ("Total Credits", "ECT Credits"),
    )
    
    // 德语版本
    #if de-courses.len() > 0 [
      #v(1em)
      #module-table-render(
        courses: de-courses,
        version-title: "Deutsche Version",
        headers: ("Kurstitel", "Credits", "ECTS-Punkte", "Unterrichtsstunden"),
        total-labels: ("Total Credits", "ECT Credits"),
      )
    ]
  ]
}

// ---- 统一入口函数 ----
// 四个开关控制：
//   is-visible / show: 总开关 - 是否显示 module table
//   show-en: 是否显示英文版（无英文标题）
//   show-de: 是否显示德文版（无德文标题）
//   show-bilingual: 是否显示双语版（有双语 version 标题）
//   bilingual: 兼容旧版本，相当于 show-bilingual
#let module-table(
  data-en: none,
  data-de: none,
  module-name-en: none,
  module-name-de: none,
  is-visible: auto,      // 兼容旧版本参数
  show_: auto,           // 新参数名（使用 show_ 因为 show 是关键字）
  show-en: false,
  show-de: false,
  show-bilingual: false,
  bilingual: auto,       // 兼容旧版本参数
) = context {
  // 确定总开关状态（优先使用新参数 show_，否则使用 is-visible）
  let final-show = if show_ != auto {
    show_
  } else if is-visible != auto {
    is-visible
  } else {
    state-module-table-show.get()
  }
  
  // 如果总开关关闭，直接返回空
  if not final-show {
    return none
  }
  
  // 确定双语开关状态（优先使用 show-bilingual，否则使用 bilingual）
  let final-bilingual = if show-bilingual {
    state-module-table-show-bilingual.get()
  } else if bilingual != auto {
    bilingual
  } else {
    false
  }
  
  // 获取各版本显示状态
  let final-show-en = if show-en { state-module-table-show-en.get() } else { false }
  let final-show-de = if show-de { state-module-table-show-de.get() } else { false }
  
  // 如果没有开启任何具体版本，默认显示英文版
  let has-specific-version = show-en or show-de or show-bilingual or bilingual != auto
  let default-to-en = not has-specific-version
  
  // 根据开关组合渲染
  return [
    // 英文版（无标题）
    #if (show-en and final-show-en) or default-to-en {
      module-table-en(
        data-en,
        module-name-en,
        show-version-title: false,
      )
    }
    
    // 德文版（无标题）
    #if show-de and final-show-de and data-de != none {
      module-table-de(
        data-de,
        module-name-de,
        show-version-title: false,
      )
    }
    
    // 双语版（有版本标题）
    #if (show-bilingual or bilingual != auto) and final-bilingual and data-de != none {
      module-table-bilingual(
        data-en,
        data-de,
        module-name-en,
        module-name-de,
      )
    }
  ]
}


// =============================================================================
// PART 5: 课程详情函数 (Course Function)
// 生成单个课程的详细信息表格
// =============================================================================

#let course(
  // 基本信息
  name: none,
  id: none,
  semester: none,
  credit: none,
  grade: none,
  
  // 可覆盖的学时和 ECTS 计算
  hours: none,
  ects: none,
  
  // 先修课程
  preparatory: none,
  prerequisite: none,
  
  // 描述内容
  content: none,
  description: none,
  assessment: none,
  
  // 论文信息（用于毕业论文）
  thesis-title: none,
  thesis-description: none,
  
  // 计算参数（默认从全局状态读取）
  ects-rate: none,
  hour-rate: none,
) = context {
  // 如果没有传入参数，从全局状态读取
  let final-ects-rate = if ects-rate != none { ects-rate } else { state-ects-conversion-ratio.get() }
  let final-hour-rate = if hour-rate != none { hour-rate } else { state-credit-hours.get() }
  
  // 二级标题：课程名
  heading(depth: 2)[#name]
  
  // 自动计算 ECTS 和学时
  let final-ects = if ects != none { 
    ects 
  } else if credit != none { 
    calc.round(credit * final-ects-rate, digits: 2) 
  } else { 
    none 
  }
  
  let final-hours = if hours != none { 
    hours 
  } else if credit != none { 
    calc.round(credit * final-hour-rate, digits: 1) 
  } else { 
    none 
  }
  
  // 构建表格数据
  let cells = (
    ([*Course Title*], name),
    ([*Course No.*], id),
    ([*Semester*], semester),
    ([*Credit*], if credit != none { [#credit] } else { none }),
    ([*ECTS*], if final-ects != none { [#final-ects] } else { none }),
    ([*Course Hours*], if final-hours != none { [#final-hours] } else { none }),
    ([*My Grade*], grade),
    ([*Preparatory Course(s)*], preparatory),
    ([*Prerequisite(s)*], prerequisite),
    ([*Content*], content),
    ([*Thesis Title*], thesis-title),
    ([*Thesis Description*], thesis-description),
    ([*Description*], description),
    ([*Assessment*], assessment),
  )
  
  // 过滤掉值为 none 的行
  let table-args = ()
  for row in cells {
    if row.at(1) != none {
      table-args.push(row.at(0))
      table-args.push(row.at(1))
    }
  }
  
  // 渲染表格
  table(
    columns: (auto, 1fr),
    ..table-args,
  )
  linebreak()
}


// =============================================================================
// PART 6: 辅助函数 (Helper Functions)
// =============================================================================

// 列出其他未包含在模块中的课程
#let courses-not-included(
  courses: none,
) = {
  text()[
    #text(weight: "semibold", size: 16pt, "Other courses not listed above include:")
    #parbreak()
    #text(weight: "medium")[#courses]
  ]
}


// =============================================================================
// PART 7: 主模板函数 (Main Template Function)
// 设置文档整体结构和样式（放在最后，因为需要使用前面定义的函数）
// =============================================================================

#let template-course-description(
  // ---- 封面配置 (Cover) ----
  cover-show: true,
  
  // 封面大标题
  cover-title-show: true,
  cover-title-text: "Course Description",
  cover-title-size: 30pt,
  cover-title-weight: "bold",
  
  // 学院名称（显示在专业名称下方）
  cover-school-show: true,
  cover-school-text: "School of Engineering",
  
  // 专业名称
  cover-major-show: true,
  cover-major-text: "Automotive Service Engineering",
  cover-major-size: 16pt,
  cover-major-weight: "semibold",
  
  // 学生信息
  cover-student-name-show: true,
  cover-student-name: none,
  cover-student-id-show: true,
  cover-student-id: none,
  cover-date-show: true,
  cover-date: none,
  
  // 封面 Logo
  cover-logo-show: true,
  cover-logo-path: none,
  cover-logo-width: 100%,
  
  // 封面 Logo 下方的大学名称（显示在 Logo 下方，大标题上方）
  cover-university-above-title-show: false,
  cover-university-above-title-text: none,
  cover-university-above-title-size: 20pt,
  cover-university-above-title-weight: "bold",
  
  // ---- 水印配置 (Watermark) ----
  watermark-show: true,
  watermark-path: none,
  watermark-width: 160mm,
  
  // ---- 说明页配置 (Explanation Page) ----
  explanation-show: true,
  explanation-content: none,
  
  // ---- 模块总览表配置 (Module Content) ----
  module-content-show-en: true,
  module-content-show-de: true,
  module-content-col-width: 100pt,
  credit-hours-per-credit: 18,
  credit-ects-conversion-ratio: 1.2,
  
  // ---- 模块前置表格配置 (Module Table) ----
  // 四个开关控制显示
  module-table-show: true,          // 总开关：是否显示 module table
  module-table-show-en: true,       // 开关1：是否显示英文版（无英文标题）
  module-table-show-de: false,      // 开关2：是否显示德文版（无德文标题）
  module-table-show-bilingual: false,  // 开关3：是否显示双语版（有双语 version 标题）
  
  // ---- 数据 (Data) ----
  data-en: none,
  data-de: none,
  
  // ---- 文档主体 ----
  doc,
) = {
  // ----- 初始化全局状态变量 -----
  state-module-table-show.update(module-table-show)
  state-module-table-show-en.update(module-table-show-en)
  state-module-table-show-de.update(module-table-show-de)
  state-module-table-show-bilingual.update(module-table-show-bilingual)
  state-ects-conversion-ratio.update(credit-ects-conversion-ratio)
  state-credit-hours.update(credit-hours-per-credit)
  
  // ----- 1. 封面页 (Cover Page) -----
  if cover-show {
    page()[
      #align(center)[
        // Logo
        #if cover-logo-show {
          image(cover-logo-path, width: cover-logo-width)
        }
        
        // Logo 下方的大学名称（显示在 Logo 下方，大标题上方）
        #if cover-university-above-title-show and cover-university-above-title-text != none {
          v(3fr)  // 增加与标题的间距
          text(weight: cover-university-above-title-weight, size: cover-university-above-title-size)[#cover-university-above-title-text]
          v(3fr)  // 增加与标题的间距
        }
        
        // 大标题
        #if cover-title-show {
          v(2fr)
          text(weight: cover-title-weight, size: cover-title-size)[#cover-title-text]
          v(2fr)
        }
        
        // 专业名称
        #if cover-major-show {
          text(weight: cover-major-weight, size: cover-major-size)[#cover-major-text]
        }
        
        // 学院名称（显示在专业下方）
        #if cover-school-show {
          parbreak()
          v(0.5em)
          text(weight: "semibold", size: 18pt)[#cover-school-text]
        }
      ]
      #v(3fr)
      #set text(weight: "medium", size: 14pt)
      
      // 学生姓名
      #if cover-student-name-show {
        [Name: #cover-student-name #parbreak()]
      }
      
      // 学生学号
      #if cover-student-id-show {
        [Student No. #cover-student-id #parbreak()]
      }
      
      // 日期
      #if cover-date-show {
        [Date: #cover-date #parbreak()]
      }
    ]
  }
  
  // ----- 2. 说明页 (Explanation Page) -----
  if explanation-show and explanation-content != none {
    page(
      header: [
        Course Description - #cover-student-name
        #h(1fr)
        #cover-school-text
      ],
      footer: context [#h(1fr)],
      background: if watermark-show {
        image(watermark-path, width: watermark-width)
      } else { none },
      explanation-content
    )
  }
  
  // ----- 3. 模块总览表 - 英文版 (Module Content - English) -----
  if module-content-show-en and data-en != none {
    page(
      header: [
        Course Description - #cover-student-name
        #h(1fr)
        #cover-school-text
      ],
      footer: context [#h(1fr)],
      background: if watermark-show {
        image(watermark-path, width: watermark-width)
      } else { none },
      module-content(
        data: data-en,
        col-width: module-content-col-width,
        title: "Module Content",
        headers: ("Module", "Course Title", "Credit", "ECTS", "Total ECTS"),
      )
    )
  }
  
  // ----- 4. 模块总览表 - 德语版 (Module Content - German) -----
  if module-content-show-de and data-de != none {
    page(
      header: [
        Modulinhalte - #cover-student-name
        #h(1fr)
        #cover-school-text
      ],
      footer: context [#h(1fr)],
      background: if watermark-show {
        image(watermark-path, width: watermark-width)
      } else { none },
      module-content(
        data: data-de,
        col-width: module-content-col-width,
        title: "Modulinhalte",
        headers: ("Modul", "Kurstitel", "Credits", "ECTS", "Gesamt ECTS"),
      )
    )
  }
  
  // ----- 5. 设置正文页面样式 -----
  set page(
    header: [
      Course Description - #cover-student-name
      #h(1fr)
      #cover-school-text
    ],
    footer: context [
      #h(1fr)
      #counter(page).display("1 / 1", both: true)
      #h(1fr)
    ],
    background: if watermark-show {
      image(watermark-path, width: watermark-width)
    } else { none }
  )
  
  // ----- 6. 目录页 -----
  page(footer: [])[
    #outline(
      title: "Table of Contents",
      indent: 2em,
    )
  ]
  
  // ----- 7. 正文内容 -----
  counter(page).update(1)
  set par(justify: true)
  set heading(numbering: "1.1.")
  doc
}


// =============================================================================
// PART 8: 其他未列出课程表格函数 (Other Courses Not Included Function)
// =============================================================================

// 数据格式支持：
//   ("课程名", 学分)           - 自动计算 ECTS
//   ("课程名", 学分, 手动ECTS) - 使用手动 ECTS
#let other-courses-table(
  courses: (),
  ect-rate: none,
) = context {
  // 如果没有传入参数，从全局状态读取
  let final-ect-rate = if ect-rate != none { ect-rate } else { state-ects-conversion-ratio.get() }
  
  // 处理课程数据，支持手动指定 ECTS
  let processed-courses = courses.map(row => {
    let name = row.at(0)
    let credit = row.at(1)
    // 如果提供了第3个值，使用手动 ECTS，否则自动计算
    let manual-ects = if row.len() >= 3 { row.at(2) } else { none }
    let final-ects = if manual-ects != none { manual-ects } else { calc.round(credit * final-ect-rate, digits: 2) }
    return (name, credit, final-ects)
  })
  
  // 计算总计
  let total-credits = if processed-courses.len() > 0 { processed-courses.map(it => it.at(1)).sum() } else { 0 }
  let total-ects = if processed-courses.len() > 0 { processed-courses.map(it => it.at(2)).sum() } else { 0 }
  
  // 构建表格行
  let table-rows = processed-courses.map(row => {
    let name = row.at(0)
    let credit = row.at(1)
    let ects = row.at(2)
    
    return ([#name], [#credit], [#ects])
  }).flatten()
  
  // 渲染表格
  set text(weight: "semibold", size: 12pt)
  
  table(
    columns: (1fr, auto, auto),
    rows: (auto),
    align: center + horizon,
    
    // 表头
    [*Course Title*], [*Credits*], [*ECTS*],
    
    // 课程数据
    ..table-rows,
    
    // 总计行
    table.cell(
      colspan: 3,
      align: center,
      text(style: "italic", weight: "bold")[
        Total Credits: #calc.round(total-credits, digits: 2) 
        #h(2em) 
        Total ECTS: #calc.round(total-ects, digits: 2) 
      ]
    )
  )
  
  v(1em)
}
