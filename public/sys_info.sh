#!/bin/sh

# 检测系统架构
if command -v arch >/dev/null 2>&1; then
  platform=$(arch)
else
  platform=$(uname -m)
fi

ARCH="未知架构"
if [ "$platform" = "x86_64" ]; then
  ARCH="amd64"
elif [ "$platform" = "aarch64" ]; then
  ARCH="arm64"
else
  ARCH="不支持的架构（$platform）"
fi

# 检测操作系统类型
OS="未知系统"
case "$(uname)" in
  Linux) OS="Linux" ;;
  Darwin) OS="macOS" ;;
  FreeBSD) OS="FreeBSD" ;;
  OpenBSD) OS="OpenBSD" ;;
esac

# 检测内核版本
KERNEL_VERSION=$(uname -r)

# 检测系统发行版
if [ -f /etc/os-release ]; then
  . /etc/os-release
  OS_NAME=$NAME
  OS_VERSION=$VERSION
  OS_PRETTY=$PRETTY_NAME
else
  OS_NAME="未知发行版"
  OS_VERSION="未知版本"
  OS_PRETTY="$OS_NAME $OS_VERSION"
fi

# 输出检测结果
echo "============================="
echo "      系统信息检测结果       "
echo "============================="
echo "操作系统: $OS ($OS_PRETTY)"
echo "内核版本: $KERNEL_VERSION"
echo "平台信息: $platform"
echo "系统架构: $ARCH"
echo "============================="

# 提示最终结果
case "$ARCH" in
  *"不支持"*)
    echo "警告：您的系统架构不被支持，一些工具可能无法正常运行。"
    ;;
  *)
    echo "检测完成：您的系统是 $OS_PRETTY，架构为 $ARCH。"
    ;;
esac
