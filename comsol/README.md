# 原 COMSOL 模型说明

V9 网站运行时不调用 COMSOL 软件。

原 COMSOL Java 模型作为科研模型定义来源保存在：

```text
backend/app/model_source/BigDataFixed_120d_AutoInit.java
```

后端会解析其中的参数、变量公式、几何和求解设置，并通过 FastAPI 提供给前端。

网站中的在线仿真由 `backend/app/service/simulation_service.py` 中的降阶计算引擎完成。
该结果用于数字孪生交互与系统联调，不应视为原 COMSOL 三维 PDE 数值解的替代。
