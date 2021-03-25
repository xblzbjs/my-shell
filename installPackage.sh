#!/bin/sh
#文件名：installPackage.sh
#功能：安装软件包

read -p "请输入软件包的名字:" package
if ! [ -x "$(command -v $(package))" ];then
    ehco ''
