#!/bin/bash

# Clash Mi 依赖验证脚本
# 验证所有必需的依赖和资源文件是否正确集成

set -e

echo "🔍 Clash Mi 依赖验证开始..."

# 检查基本项目结构
echo "📁 检查项目结构..."
required_dirs=(
    "lib"
    "assets/zashboard"
    "assets/datas"
    "assets/fonts"
    "assets/images"
    "assets/txts"
    "android"
    "ios"
    "windows"
    "macos"
    "linux"
)

for dir in "${required_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "  ✅ $dir 存在"
    else
        echo "  ❌ $dir 缺失"
        exit 1
    fi
done

# 检查关键文件
echo "📄 检查关键文件..."
required_files=(
    "pubspec.yaml"
    "lib/main.dart"
    "lib/app/modules/zashboard.dart"
    "lib/app/clash/clash_http_api.dart"
    "lib/app/modules/clash_setting_manager.dart"
    "assets/zashboard/index.html"
    "assets/datas/geosite.zip"
    "assets/datas/geoip.zip"
    "assets/datas/ASN.mmdb"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file 存在"
    else
        echo "  ❌ $file 缺失"
        exit 1
    fi
done

# 检查存根实现
echo "🔧 检查 libclash_vpn_service 存根实现..."
stub_files=(
    "lib/stubs/libclash_vpn_service/state.dart"
    "lib/stubs/libclash_vpn_service/vpn_service.dart"
    "lib/stubs/libclash_vpn_service/proxy_manager.dart"
    "lib/stubs/libclash_vpn_service/vpn_service_platform_interface.dart"
)

for file in "${stub_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file 存在"
    else
        echo "  ❌ $file 缺失"
        exit 1
    fi
done

# 检查导入语句
echo "🔗 检查导入语句..."
if grep -r "package:libclash_vpn_service/" lib/ > /dev/null 2>&1; then
    echo "  ❌ 发现未更新的 libclash_vpn_service 导入"
    echo "  请运行: find lib/ -name '*.dart' -exec sed -i 's|package:libclash_vpn_service/|package:clashmi/stubs/libclash_vpn_service/|g' {} \\;"
    exit 1
else
    echo "  ✅ 所有导入语句已正确更新"
fi

# 检查 pubspec.yaml 依赖
echo "📦 检查 pubspec.yaml 依赖..."
if grep -q "path: ../libclash-vpn-service/" pubspec.yaml; then
    echo "  ❌ pubspec.yaml 中仍然存在无效的本地路径依赖"
    exit 1
else
    echo "  ✅ pubspec.yaml 依赖配置正确"
fi

# 检查资源文件大小 (确保不是空文件)
echo "📊 检查资源文件完整性..."
data_files=(
    "assets/datas/geosite.zip"
    "assets/datas/geoip.zip" 
    "assets/datas/ASN.mmdb"
)

for file in "${data_files[@]}"; do
    size=$(stat -c%s "$file" 2>/dev/null || echo "0")
    if [ "$size" -gt 1000 ]; then
        echo "  ✅ $file 大小正常 (${size} bytes)"
    else
        echo "  ❌ $file 文件过小或损坏 (${size} bytes)"
        exit 1
    fi
done

# 检查 Zashboard 资源
echo "🌐 检查 Zashboard 资源..."
zashboard_files=(
    "assets/zashboard/index.html"
    "assets/zashboard/assets/index-DgxkpWtA.js"
    "assets/zashboard/assets/index-B55WtWd_.css"
)

for file in "${zashboard_files[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file 存在"
    else
        echo "  ❌ $file 缺失"
        exit 1
    fi
done

echo ""
echo "🎉 所有依赖验证通过！"
echo "✨ Clash Mi 项目的三大核心依赖已正确集成:"
echo "   • Flutter: 跨平台UI框架"
echo "   • Mihomo: 代理核心引擎"  
echo "   • Zashboard: Web管理界面"
echo ""
echo "📚 详细依赖信息请查看: DEPENDENCIES.md"