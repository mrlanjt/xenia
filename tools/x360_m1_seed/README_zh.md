# x360-m1-runner seed 导出说明

你反馈无法下载 `deliverables/x360-m1-runner-seed.tar.gz` 或查看 `deliverables` 目录。
因此改为**脚本即时导出**：

```bash
bash tools/x360_m1_seed/export_seed.sh
```

默认输出：
- 目录：`./x360-m1-runner-seed`
- 压缩包：`./x360-m1-runner-seed.tar.gz`

也可指定自定义输出路径：

```bash
bash tools/x360_m1_seed/export_seed.sh /tmp/x360-m1-runner-seed /tmp/x360-m1-runner-seed.tar.gz
```
