# Z-IM 个人社交 IM 总体规划

## 1. 项目目标

打造一套面向个人社交场景的即时通讯产品，交互体验参考微信，终端覆盖 `H5 + Android + iOS`，不做 PC 客户端。

本轮规划在原有 IM 能力基础上，新增以下核心方向：

- 音视频通话
- 红包功能
- 用户余额体系
- 支付渠道接入：支付宝、微信支付
- 后端可视化配置中心
- 免费版 / 商业授权版双版本私有化部署方案
- Flutter 客户端改造为更接近 iOS 原生的 Cupertino 风格

## 2. 产品定位

- 参考对象：微信个人端的消息、联系人、群聊、语音视频、红包、钱包等核心路径
- 产品形态：纯社交 IM，不包含组织架构、审批流、企业通讯录
- 目标用户：个人用户、群主/群管理员、平台运营人员、财务/审核人员、私有化部署客户
- 商业模式：
  - 免费私有化版：可部署、可使用，但能力受授权限制
  - 商业授权版：通过授权密钥解锁高级能力与商用权限

## 3. 功能边界

### 3.1 基础 IM 能力

1. 账号体系
   - 手机号验证码登录
   - 密码登录（可选）
   - 用户昵称、头像、个性签名
   - 账号状态：正常、冻结、封禁

2. 好友体系
   - 搜索用户
   - 好友申请
   - 好友备注
   - 黑名单

3. 会话能力
   - 单聊
   - 群聊
   - 会话置顶
   - 未读数
   - 草稿
   - 会话免打扰

4. 消息能力
   - 文本消息
   - 图片消息
   - 文件消息
   - 表情消息
   - 语音消息
   - 消息撤回
   - 已送达 / 已读
   - 历史消息分页

5. 群组能力
   - 创建群聊
   - 邀请好友入群
   - 群名称 / 群头像
   - 群公告
   - 群成员管理

### 3.2 新增能力规划

1. 音视频能力
   - 单聊语音通话
   - 单聊视频通话
   - 群语音 / 群视频（商业版）
   - 通话时长统计
   - 麦克风 / 摄像头状态控制
   - 通话记录

2. 红包能力
   - 单聊红包
   - 群普通红包
   - 群拼手气红包
   - 红包领取记录
   - 红包过期退回

3. 钱包与余额
   - 用户钱包首页
   - 余额充值
   - 余额支付
   - 余额明细
   - 冻结金额
   - 红包支出 / 收入流水

4. 支付渠道
   - 支付宝 App 支付
   - 支付宝 H5 支付
   - 微信 App 支付
   - 微信 H5 支付
   - 后台可配置启停

5. 后端管理与配置
   - 支付渠道配置
   - 红包规则配置
   - 钱包风控配置
   - 音视频限制配置
   - 授权密钥配置
   - 版本功能开关配置

## 4. 版本与授权策略

### 4.1 核心原则

- 不按用户数收费
- 源码一致，靠授权密钥区分免费版和商业版
- 所有能力限制由服务端强制校验
- 前端仅展示，真正限制逻辑必须在服务端落地
- 私有化部署场景也必须可离线校验授权

### 4.2 免费私有化版

服务端强制拦截以下限制：

- 单个账号好友上限：200
- 单群最大人数：50
- 单次一对一音视频最长 5 分钟
- 禁止多人音视频
- 单文件最大 20MB
- 关闭 E2EE 端到端加密
- 客户端底部显示免费版标识
- 服务端写入免费版部署标识
- 不提供官方运维支持能力入口

### 4.3 商业授权私有化版

- 好友数量无限制
- 群人数无限制
- 一对一音视频无时长限制
- 支持多人音视频
- 开启端到端加密
- 允许多设备自由同步
- 开放语音转文字
- 去除免费版标识
- 可自定义品牌名 / Logo
- 开放商用部署授权
- 提供版本升级与技术支持

## 5. Flutter 客户端规范

### 5.1 UI 风格原则

客户端采用偏 iOS 原生风格设计，IM 前端优先使用 `Cupertino` 系列组件：

- `CupertinoPageScaffold`
- `CupertinoNavigationBar`
- `CupertinoButton`
- `CupertinoListTile`
- `CupertinoTextField`
- `CupertinoTabScaffold`
- `CupertinoTabBar`
- `CupertinoActionSheet`
- `CupertinoIcons`

图标风格统一采用线性简约风，避免复杂填充图标。

### 5.2 主题实现说明

Flutter 官方并不存在 `ThemeData.useCupertino = true` 这样的标准开关，建议采用以下方式实现：

1. 应用入口优先使用 `CupertinoApp`
2. 统一配置 `CupertinoThemeData`
3. 必要时局部桥接 `Material` 组件能力
4. 字体、色板、分割线、导航栏、弹窗均按 iOS 视觉统一

### 5.3 页面结构建议

- `消息`
- `通讯录`
- `发现`
  - 钱包
  - 红包记录
  - 支付方式
- `我的`

### 5.4 IM 前端新增页面

- 音视频呼叫页
- 来电弹窗
- 通话中页面
- 钱包页
- 余额明细页
- 充值页
- 红包发送页
- 红包详情页
- 支付方式管理页

## 6. 服务端与后台建议

### 6.1 服务端架构

- 服务端语言：`Go`
- HTTP 框架：`Gin`
- 实时通信：`WebSocket`
- 音视频：`WebRTC`
- 信令层：`WebSocket + Redis Pub/Sub`
- 数据库：`MySQL`
- 缓存：`Redis`
- 文件存储：`MinIO`
- 后台管理端：`Vue 3 + Element Plus`

### 6.2 服务拆分建议

1. Gateway
   - 鉴权
   - 路由聚合
   - 限流

2. User Service
   - 用户资料
   - 好友关系
   - 黑名单

3. IM Service
   - 会话
   - 消息
   - 已读
   - 红包消息

4. RTC Service
   - 呼叫信令
   - 通话状态
   - WebRTC 房间控制
   - 免费版 / 商业版通话限制

5. Wallet Service
   - 钱包账户
   - 余额流水
   - 红包订单
   - 冻结 / 解冻

6. Payment Service
   - 支付宝下单
   - 微信下单
   - 回调验签
   - 充值单 / 红包单状态同步

7. Admin Service
   - 用户运营
   - 群管理
   - 举报审核
   - 支付配置
   - 授权配置

## 7. 音视频规划

### 7.1 功能设计

- 单聊语音
- 单聊视频
- 群视频 / 群语音
- 通话记录
- 来电提醒
- 通话中切后台恢复
- 网络差弱网提示

### 7.2 技术实现

- 终端：Flutter WebRTC 插件封装
- 传输协议：WebRTC
- 信令：WebSocket
- 穿透：STUN / TURN
- 服务端限制逻辑：
  - 免费版单聊音视频 5 分钟自动挂断
  - 免费版多人通话接口直接拒绝
  - 商业版放开多人通话和时长限制

### 7.3 数据模型

- `call_sessions`
  - id
  - room_id
  - call_type（audio/video）
  - call_mode（single/group）
  - initiator_id
  - status
  - started_at
  - ended_at
  - duration_seconds

- `call_participants`
  - id
  - session_id
  - user_id
  - join_at
  - leave_at
  - device_type

## 8. 红包与余额规划

### 8.1 红包规则

- 单聊红包：直接给指定对象
- 群普通红包：固定份数、固定金额
- 群拼手气红包：固定总金额、随机分配
- 红包过期自动退回
- 红包金额不足时不可发送

### 8.2 余额体系

- 余额账户
- 可用余额
- 冻结余额
- 总收入
- 总支出
- 账单流水

### 8.3 红包与余额关系

- 发红包时先冻结金额
- 领取后从冻结转实际支出
- 红包过期后退回余额
- 支持优先余额支付，不足时拉起第三方充值

### 8.4 数据模型

- `wallet_accounts`
  - id
  - user_id
  - balance
  - frozen_balance
  - status

- `wallet_transactions`
  - id
  - user_id
  - biz_type（recharge/red_packet_send/red_packet_receive/refund）
  - direction（income/expense/freeze/unfreeze）
  - amount
  - balance_after
  - related_order_id
  - created_at

- `red_packets`
  - id
  - sender_id
  - conversation_id
  - packet_type（single/group_random/group_fixed）
  - total_amount
  - total_count
  - claimed_amount
  - claimed_count
  - status
  - expired_at

- `red_packet_claims`
  - id
  - red_packet_id
  - user_id
  - amount
  - claimed_at

## 9. 支付接入规划

### 9.1 支付能力边界

支付只服务于钱包充值、红包补足、后续会员或增值服务，不直接参与 IM 消息链路。

### 9.2 支付宝接入方案

根据支付宝官方文档，当前项目建议这样接入：

- Android / iOS App：使用 `App 支付`
- H5：使用 `手机网站支付`
- 服务端负责签名与下单
- 客户端仅接收下单结果参数并拉起支付
- 支付结果必须以异步通知或主动查询为准

支付宝接入安全要求：

- 私钥只允许保存在服务端
- 推荐 `RSA2`
- 异步通知先验签，再校验 `out_trade_no`、`app_id`、`total_amount`
- 前端同步回调不可作为成功依据

### 9.3 微信支付接入方案

当前建议：

- Android / iOS App：使用微信 `APP支付`
- H5：使用微信 `H5支付`
- 使用微信支付 `API v3`
- 服务端负责签名、下单、回调验签、订单查询

参考微信支付开发者中心，`APP支付` 适用于商户 App 跳转微信付款，`H5支付` 适用于浏览器场景，[微信支付开发者中心](https://pay.weixin.qq.com/doc/global/v3/zh)。

### 9.4 后台支付配置项

后台管理端需要支持：

- 支付宝开关
- 微信支付开关
- 支付环境：沙箱 / 正式
- 应用 / 商户编号
- 私钥 / 证书文件上传
- 回调地址
- 钱包充值最小金额
- 红包单笔限额
- 单日支付限额

### 9.5 支付订单模型

- `payment_channels`
  - id
  - channel_code（alipay/wechatpay）
  - enabled
  - env
  - config_json
  - updated_at

- `payment_orders`
  - id
  - user_id
  - biz_type（wallet_recharge/red_packet_topup）
  - channel_code
  - out_trade_no
  - amount
  - status
  - paid_at

## 10. 后端管理中心规划

### 10.1 核心页面

- 登录页
- 用户管理页
- 封禁管理页
- 群组管理页
- 举报审核页
- 内容审核页
- 钱包管理页
- 红包订单页
- 支付配置页
- 音视频配置页
- 授权中心页
- 系统配置页

### 10.2 支付配置页

- 支付宝 App / H5 配置
- 微信 App / H5 配置
- 通知地址管理
- 支付证书上传
- 渠道启停
- 充值规则

### 10.3 授权中心页

- 当前版本类型
- 授权密钥导入
- 授权到期时间
- 功能开关展示
- 免费版限制提示
- 商业版已解锁能力列表

## 11. 授权校验设计

### 11.1 校验机制

- 服务端启动时读取授权文件 / 环境变量密钥
- 使用内置公钥验签授权内容
- 将授权信息加载到内存
- 所有受限能力统一走 `LicenseGuard`
- 私有化场景支持完全离线校验

### 11.2 建议授权载荷

- `license_id`
- `edition`（free/commercial）
- `customer_name`
- `expire_at`
- `feature_flags`
- `signature`

### 11.3 服务端强校验点

- 创建好友关系
- 拉群入群
- 上传文件
- 发起音视频
- 发起多人音视频
- 开启 E2EE
- 去除免费版标识
- 设置品牌名称

## 12. 核心接口规划

### 12.1 鉴权与用户

- `POST /api/auth/send-code`
- `POST /api/auth/login`
- `GET /api/me`
- `PATCH /api/me/profile`
- `POST /api/me/logout`

### 12.2 好友

- `GET /api/friends`
- `GET /api/users/search`
- `POST /api/friends/apply`
- `POST /api/friends/:id/accept`
- `POST /api/friends/:id/block`

### 12.3 会话与消息

- `GET /api/conversations`
- `POST /api/conversations/single`
- `POST /api/conversations/group`
- `GET /api/conversations/:id/messages`
- `POST /api/messages/text`
- `POST /api/messages/image`
- `POST /api/messages/file`
- `POST /api/messages/red-packet`

### 12.4 音视频

- `POST /api/calls/initiate`
- `POST /api/calls/:id/accept`
- `POST /api/calls/:id/reject`
- `POST /api/calls/:id/hangup`
- `GET /api/calls/history`

### 12.5 钱包与红包

- `GET /api/wallet/account`
- `GET /api/wallet/transactions`
- `POST /api/wallet/recharge`
- `GET /api/red-packets/:id`
- `POST /api/red-packets/:id/claim`

### 12.6 支付

- `POST /api/payments/alipay/app/create`
- `POST /api/payments/alipay/h5/create`
- `POST /api/payments/wechat/app/create`
- `POST /api/payments/wechat/h5/create`
- `POST /api/payments/alipay/notify`
- `POST /api/payments/wechat/notify`

### 12.7 后台管理

- `GET /api/admin/users`
- `GET /api/admin/wallet/orders`
- `GET /api/admin/red-packets`
- `GET /api/admin/payment/channels`
- `PUT /api/admin/payment/channels/:id`
- `POST /api/admin/license/import`
- `GET /api/admin/license/current`

## 13. 非功能要求

- 安全：支付签名服务端化、回调验签、余额幂等处理、红包防重领
- 性能：长列表虚拟化、消息增量同步、钱包流水分页
- 可靠性：支付回调重试、红包领取幂等、通话异常断线恢复
- 可维护性：支付通道、授权模块、音视频模块全部解耦
- 可扩展性：后续可接会员、订阅、虚拟礼物

## 14. 分期建议

### Phase 1：Flutter 原型升级

- 将现有界面改造成 `Cupertino` 风格
- 增加钱包页、红包页、通话页原型
- 保持 Mock 数据闭环

### Phase 2：后端基础能力

- Go 服务骨架
- MySQL / Redis / MinIO 接入
- IM 核心接口
- 后台管理基础页
- 支付配置页
- 授权中心页

### Phase 3：支付与钱包

- 钱包账户
- 余额流水
- 红包发送 / 领取
- 支付宝接入
- 微信支付接入

### Phase 4：音视频与商业版能力

- WebRTC 音视频
- 免费版时长限制
- 商业版多人通话
- E2EE 开关
- 品牌化配置

## 15. 当前建议执行顺序

1. 先重构 Flutter 原型到 `Cupertino` 风格
2. 同步补齐钱包、红包、通话原型页面
3. 再搭 Go 后端与后台配置中心
4. 后接支付渠道
5. 最后接入音视频与授权锁
