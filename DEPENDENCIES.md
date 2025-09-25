# Clash Mi 依赖集成文档

本文档详细说明了 Clash Mi 应用的依赖集成情况和各组件的作用。

## 核心依赖

### 1. Flutter 框架
- **包名**: `flutter` (SDK)
- **用途**: 核心UI框架，支持跨平台应用开发
- **状态**: ✅ 已完整集成
- **位置**: 框架层
- **特性**: 
  - 支持 iOS、Android、Windows、macOS、Linux
  - Material Design 和 Cupertino 风格
  - 热重载开发体验

### 2. Mihomo 核心 (Clash Meta)
- **项目**: [MetaCubeX/mihomo](https://github.com/MetaCubeX/mihomo)
- **用途**: 代理核心引擎，处理网络流量转发
- **状态**: ✅ 已完整集成
- **集成方式**: 
  - 通过本地服务 (`lib/app/local_services/vpn_service.dart`)
  - HTTP API 接口 (`lib/app/clash/clash_http_api.dart`)
  - 配置管理 (`lib/app/modules/clash_setting_manager.dart`)
- **特性**:
  - 支持多种代理协议 (VMess, VLESS, Trojan, etc.)
  - 规则路由和策略组
  - DNS 解析和劫持
  - 流量统计和日志

### 3. Zashboard 仪表板
- **项目**: [Zephyruso/zashboard](https://github.com/Zephyruso/zashboard)
- **用途**: Web 管理界面，提供图形化配置和监控
- **状态**: ✅ 已完整集成
- **集成方式**:
  - 静态资源: `assets/zashboard/`
  - 本地服务器: `lib/app/modules/zashboard.dart`
  - 自动配置 API 连接
- **特性**:
  - 实时连接监控
  - 规则和策略组管理
  - 日志查看
  - 代理节点测试

## 自定义依赖

### 4. libclash_vpn_service (VPN 服务)
- **用途**: VPN 服务接口和平台适配
- **状态**: ✅ 已使用本地存根实现
- **位置**: `lib/stubs/libclash_vpn_service/`
- **说明**: 
  - 原包不在公开环境中可用
  - 创建了兼容的存根实现
  - 提供相同的 API 接口
  - 支持服务安装、启动、停止等功能

## Git 依赖

### 5. 定制化包
以下包使用了 KaringX 团队的定制版本:

#### flutter_inappwebview
- **Git**: `https://github.com/KaringX/flutter_inappwebview.git`
- **用途**: 内嵌 WebView 支持
- **特性**: 支持高级 WebView 功能

#### move_to_background
- **Git**: `https://github.com/KaringX/move_to_background.git`
- **用途**: 应用后台运行支持

#### country
- **Git**: `https://github.com/KaringX/country.git`
- **用途**: 国家/地区信息支持

#### window_manager
- **Git**: `https://github.com/KaringX/window_manager.git`
- **用途**: 桌面平台窗口管理

## 资源文件

### 6. 地理数据文件
- **位置**: `assets/datas/`
- **文件**:
  - `geosite.zip`: 网站分类数据
  - `geoip.zip`: IP 地址地理位置数据  
  - `ASN.mmdb`: ASN (自治系统) 数据库
- **用途**: 支持基于地理位置的路由规则
- **更新**: 自动检查并更新 (7天间隔)

### 7. 用户界面资源
- **字体**: `assets/fonts/Emoji.ttf` - Emoji 字体支持
- **图片**: `assets/images/` - 应用图标和界面图片
- **文本**: `assets/txts/` - 用户协议等文本文件

## 平台特定集成

### Android
- **位置**: `android/`
- **特性**: 
  - VPN 服务支持
  - 系统权限管理
  - 后台运行优化

### iOS  
- **位置**: `ios/`
- **特性**:
  - Network Extension
  - 系统集成
  - App Store 合规

### Desktop (Windows/macOS/Linux)
- **位置**: `windows/`, `macos/`, `linux/`
- **特性**:
  - 系统托盘支持
  - 开机启动
  - 系统代理设置

## 构建系统

### CMake 配置
- **Windows**: `windows/CMakeLists.txt`
- **Linux**: `linux/flutter/CMakeLists.txt`
- **macOS**: `macos/Podfile`

### Flutter 配置
- **分析**: `analysis_options.yaml`
- **构建**: `pubspec.yaml`
- **分发**: `distribute_options.yaml`

## 注意事项

1. **依赖版本**: 所有依赖都锁定到特定版本以确保稳定性
2. **平台兼容**: 某些依赖仅在特定平台可用
3. **网络访问**: 构建时需要访问 GitHub 和 pub.dev
4. **存根实现**: libclash_vpn_service 使用本地存根，可能需要平台特定实现

## 维护建议

1. 定期更新 geo 数据文件
2. 跟踪上游项目更新
3. 测试跨平台兼容性
4. 监控依赖安全漏洞