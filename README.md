# Z-IM

当前仓库已调整为“参考微信的个人端 IM”方向，首轮只做 `H5 + Android + iOS` 三端同源客户端原型，不做 PC 客户端。

## 当前规划

- 客户端：`Flutter`
- 服务端：`Go`
- 数据库：`MySQL`
- 缓存：`Redis`
- 文件存储：`MinIO`
- 运营后台：`Vue 3 + Element Plus`

## 目录说明

- `docs/im-plan.md`：个人端 IM 规划文档
- `docs/im-tasks.md`：开发任务清单
- `docs/license-editions.md`：免费版 / 商业版私有化授权方案
- `apps/mobile`：Flutter 客户端原型

## 当前已完成

- Cupertino 风格应用骨架
- 登录页
- 消息页
- 聊天详情页
- 通讯录页
- 新的朋友页
- 发现页
- 我的页
- 创建群聊页
- Mock 数据状态流

## 本地运行

1. 安装 Flutter SDK
2. 进入 `apps/mobile`
3. 执行 `flutter pub get`
4. 执行 `flutter run`

当前远程环境未安装 Flutter / Dart，因此本次仅完成代码级原型搭建，未执行编译与真机验证。
