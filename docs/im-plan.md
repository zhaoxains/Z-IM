# Z-IM 个人端 IM 规划

## 1. 项目目标

打造一套面向个人用户的即时通讯产品，交互体验参考微信，首期聚焦移动端使用场景，只做 `H5 + Android + iOS` 三端同源，不做 PC 客户端。

本阶段先明确个人端产品路线、跨端技术方案、服务端能力与后台管理边界，再进入首轮开发。

## 2. 产品定位

- 参考对象：微信个人端的消息、联系人、群聊、通讯录、我的页面等核心使用路径
- 目标用户：普通个人用户、群主/群管理员、平台运营人员、内容审核人员
- 核心价值：
  - 低门槛沟通：单聊、群聊、消息同步、好友关系
  - 移动优先：围绕手机使用习惯设计，兼容 H5
  - 运营可控：账号管理、封禁、举报审核、群管理
  - 可持续演进：为后续朋友圈、音视频、支付、小游戏等能力预留空间

## 3. 功能边界

### 3.1 首期建议实现范围（MVP）

建议先做“个人用户可以完整完成注册登录、加好友、聊天、建群”的最小闭环：

1. 账号体系
   - 手机号验证码登录
   - 密码登录（可选）
   - 用户昵称、头像、个性签名
   - 账号状态：正常、冻结、封禁

2. 好友体系
   - 搜索用户
   - 发送好友申请
   - 同意/拒绝好友申请
   - 好友列表
   - 黑名单

3. 会话能力
   - 会话列表
   - 单聊
   - 群聊
   - 会话置顶
   - 未读数
   - 草稿占位能力

4. 消息能力
   - 文本消息
   - 图片消息
   - 文件消息
   - 表情占位能力
   - 消息撤回
   - 已送达/已读状态
   - 历史消息分页加载

5. 群组能力
   - 创建群聊
   - 邀请好友入群
   - 群名称/群头像
   - 群公告
   - 群成员管理

6. 我的页面
   - 个人资料编辑
   - 设置
   - 账号安全
   - 退出登录

7. 运营后台
   - 用户管理
   - 群组管理
   - 举报管理
   - 内容审核基础列表

### 3.2 二期能力

- 语音消息
- 消息引用、转发、收藏
- 全局搜索
- 在线状态
- 多设备登录管理
- 消息推送策略
- 举报与风控规则

### 3.3 三期能力

- 音视频通话
- 朋友圈/动态
- 小程序/开放平台
- 钱包/支付
- AI 聊天助手

## 4. 参考微信的产品结构

建议首版页面结构接近微信移动端：

- `消息`
  - 会话列表
  - 未读徽标
  - 最近消息预览

- `通讯录`
  - 新的朋友
  - 群聊
  - 好友列表

- `发现`
  - 首版可先留空或隐藏

- `我的`
  - 个人信息
  - 设置
  - 安全

这样可以降低用户学习成本，同时便于后续扩展。

## 5. 跨端技术方案建议

你要求前端使用“一套语言编译 `H5 + Android + iOS`”，结合 IM 场景，推荐两套可行方案：

### 方案 A：`Flutter + Dart`（推荐）

优点：

- 原生感更强，聊天列表、长列表、动画、输入框体验更稳定
- Android 和 iOS 体验一致性更高
- Web/H5 也可覆盖
- 更适合后续扩展音视频、复杂互动与高频实时 UI

注意点：

- H5 包体和首屏性能需要额外优化
- 团队需要接受 `Dart`

### 方案 B：`uni-app + Vue`（适合国内移动业务快速交付）

优点：

- H5 与 App 多端支持成熟
- 上手门槛较低
- 国内生态、插件、云打包链路更方便

注意点：

- 复杂聊天交互与大型项目治理通常不如 Flutter 稳定
- 后续高性能场景可能需要更多兼容处理

如果以“先做 IM 核心体验、后续继续做移动产品”为目标，优先建议 `Flutter`。

## 6. 服务端与后台建议

你要求后端具备可视化管理能力，因此建议后端拆成两部分：

1. IM 后端服务
   - 负责登录、好友、会话、消息、群组、推送、上传

2. 运营管理后台
   - 负责用户管理、封禁、举报审核、群管理、内容审核

### 6.1 推荐后端架构

- 服务端语言：优先建议 `Go`
- HTTP 框架：`Gin` 或 `Fiber`
- 实时通信：`WebSocket`
- 数据库：`MySQL`
- 缓存：`Redis`
- 文件存储：`MinIO`
- 搜索：二期可接 `Elasticsearch`

推荐 Go 的原因：

- IM 场景下并发连接、长连接、异步处理更合适
- 部署简单，性能稳定
- 后续拆分网关、消息服务、推送服务更方便

### 6.2 后台可视化管理

后台管理建议独立为 Web 管理端：

- 管理端前端：`Vue 3 + Element Plus`
- 核心页面：
  - 用户管理
  - 封禁管理
  - 群组管理
  - 举报审核
  - 内容审核
  - 系统配置

这部分是“后端可视化管理”的核心交付，不属于 PC 客户端产品。

## 7. 系统架构分层

1. Mobile Client
   - Flutter / uni-app 客户端
   - H5 版本

2. API Gateway
   - 登录鉴权
   - 客户端聚合接口

3. User Service
   - 用户资料
   - 好友关系
   - 黑名单

4. Conversation Service
   - 单聊/群聊
   - 会话排序
   - 未读计数

5. Message Service
   - 消息写入
   - 历史查询
   - 撤回
   - 已读状态

6. Admin Service
   - 用户运营
   - 举报审核
   - 群组管理

7. Infra
   - MySQL
   - Redis
   - MinIO

## 8. 核心数据模型

首版建议至少包含以下实体：

- `users`
  - id
  - mobile
  - nickname
  - avatar
  - bio
  - status
  - last_active_at

- `friend_requests`
  - id
  - from_user_id
  - to_user_id
  - message
  - status

- `friendships`
  - id
  - user_id
  - friend_id
  - remark
  - created_at

- `conversations`
  - id
  - type（single/group）
  - owner_id
  - name
  - avatar
  - last_message_id
  - last_message_at

- `conversation_members`
  - id
  - conversation_id
  - user_id
  - role
  - unread_count
  - last_read_message_id

- `messages`
  - id
  - conversation_id
  - sender_id
  - message_type
  - content
  - file_url
  - recalled_at
  - created_at

- `reports`
  - id
  - reporter_id
  - target_type
  - target_id
  - reason
  - status
  - created_at

## 9. 核心接口规划

### 9.1 鉴权与用户

- `POST /api/auth/send-code`
- `POST /api/auth/login`
- `GET /api/me`
- `PATCH /api/me/profile`
- `POST /api/me/logout`

### 9.2 好友

- `GET /api/friends`
- `GET /api/users/search`
- `POST /api/friends/apply`
- `POST /api/friends/:id/accept`
- `POST /api/friends/:id/reject`
- `POST /api/friends/:id/block`

### 9.3 会话与群组

- `GET /api/conversations`
- `POST /api/conversations/single`
- `POST /api/conversations/group`
- `GET /api/conversations/:id`
- `POST /api/conversations/:id/members`
- `PATCH /api/conversations/:id/pin`

### 9.4 消息

- `GET /api/conversations/:id/messages`
- `POST /api/messages/text`
- `POST /api/messages/image`
- `POST /api/messages/file`
- `POST /api/messages/:id/read`
- `POST /api/messages/:id/recall`

### 9.5 后台管理

- `GET /api/admin/users`
- `POST /api/admin/users/:id/ban`
- `GET /api/admin/groups`
- `GET /api/admin/reports`
- `POST /api/admin/reports/:id/resolve`

### 9.6 WebSocket 事件

- `message.new`
- `message.read`
- `message.recalled`
- `conversation.updated`
- `friend.request`

## 10. 页面规划

### 10.1 用户端

- 启动页
- 登录页
- 首页 Tab
  - 消息页
  - 通讯录页
  - 我的页
- 聊天详情页
- 创建群聊页
- 新的朋友页
- 设置页

### 10.2 运营后台

- 登录页
- 用户管理页
- 封禁管理页
- 群组管理页
- 举报审核页
- 内容审核页

## 11. 非功能要求

- 安全：登录风控、频率限制、Token 鉴权、基础审核能力
- 性能：消息分页、长列表虚拟化、图片压缩上传、会话列表增量更新
- 可靠性：消息先入库再分发、断线重连、发送失败重试
- 可扩展性：消息类型可扩展、推送模块解耦、后台与业务服务解耦

## 12. 开发分期建议

### Phase 1：移动端原型 MVP

目标：跑通“登录 -> 搜索用户 -> 添加好友 -> 发起单聊/群聊 -> 发送文本消息”的最小闭环。

交付内容：

- 跨端客户端骨架
- 登录页
- Tab 主框架
- 会话列表
- 聊天窗口
- 通讯录
- 好友申请
- 创建群聊
- Mock 数据闭环

### Phase 2：服务端接入

- 用户、好友、会话、消息真实接口
- WebSocket 实时收发
- 文件上传
- 后台管理基础页

### Phase 3：运营与增强

- 举报审核
- 封禁系统
- 图片/文件消息
- 已读状态
- 群公告

## 13. 本仓库首轮建议

当前仓库为空，建议本轮先落地：

1. 初始化跨端客户端项目骨架
2. 搭建参考微信的移动端 UI 原型
3. 用 Mock 数据跑通以下页面：
   - 登录页
   - 消息页
   - 聊天详情页
   - 通讯录页
   - 新的朋友页
   - 我的页
   - 创建群聊页
4. 同时沉淀后续真实接口需要的数据结构

## 14. 待确认事项

进入开发前，建议确认以下关键决策：

1. 客户端采用 `Flutter` 还是 `uni-app`
2. 首轮是否只做客户端原型，不立即接服务端
3. 后台管理本轮是否同步搭建基础页面
4. 首批消息类型是否只做文本，还是同时加入图片/文件
