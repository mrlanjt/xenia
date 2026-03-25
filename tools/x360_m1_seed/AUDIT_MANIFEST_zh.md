# x360-m1-runner 初始代码审计清单（面向 macOS M1 目标）

## 审计目标
围绕“在 mac M1 上运行 Xbox 360 游戏”目标，保留可直接形成运行链路的代码；去除明显与当前目标无关或耦合过重内容（如 Win 专属实现、测试资产）。

## 保留范围（候选初始代码）
- `src/xenia/base`（已过滤 Win/Android/测试/生成工程文件）
- `src/xenia/vfs`（已过滤测试和 premake）
- `src/xenia/cpu_hir`
- `src/xenia/cpu_ppc`（已过滤测试资产）
- `src/xenia/kernel_util`
- `src/xenia/memory.*`、`src/xenia/xbox.h`

## 过滤范围（被移除）
- Win/Android 明显平台专属实现（如 `*_win.*`、`*_android.*`）
- base/cpu/vfs 下测试资产与旧 premake 文件
- 显然非 M1 初始必需的附加调试/工程文件

## 审计平衡原则
- 不替你决定“导入顺序”；
- 仅做“有用性 + 风险”的筛选与打包；
- 保留足够上下文，避免过度精简导致二次回填成本过高。
