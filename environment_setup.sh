#!/bin/sh

function packageInstall(){
    if ! [ -x "$(command -v $1)" ];then
        echo "找不到$1"
        read -p "是否安装$1(y|n}):" -n 1 OK
        if [ ${OK} = "y" ] || [ ${OK} = "Y" ];then
            echo
            echo"开始安装$1"
            brew install $1 || brew install --cask $1
            if [ -x "$(command -v $1)" ];then
                echo "安装$1成功"
            else
                echo "安装$1失败"
            fi
        else
            echo "不安装$1"
        fi
    else
        echo "$1已安装"
    fi
}

if [ $(uname) == "Darwin" ];then
    echo 'Mac';
    # Git
    if ! [ -x "$(command -v brew)" ];then
        echo 'Error: homebrew is not installed'
        read -p "是否安装homebrew(y|n):" -n 1 OK
        if [ ${OK}="y" ] || [ ${OK} = "Y" ];then
            echo
            echo"开始安装homebrew......"
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            if [ -x "$(command -v brew)" ];then
                echo "安装homebrew成功"
            else
                echo "安装homebrew失败"
            fi
        fi
    else
        echo "homebrew已安装"
    fi
    # Git
    packageInstall postman
    packageInstall docker
    packageInstall go
    packageInstall git
    packageInstall visual-studio-code
fi

