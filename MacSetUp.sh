#!/bin/sh


function packageInstall(){
    ### brew安装软件包 ###
    if ! [ -x "$(command -v $1)" ];then
        echo "brew list下找不到$1"
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
            echo ''
        fi
    else
        echo "$1已安装"
    fi
}

function goConfigForMac(){
    
    echo "Go 环境配置"
    GO_VERSION=$(go version)
    echo "当前Go的版本为$GO_VERSION"
    # TODO 这里要对Go版本进行判断
    
    # 判断用户当前使用的Shell
    case $SHELL in
    */zsh)
        echo "当前是zsh shell"
        echo "设置GOPRIVATE"
        go env -w GO111MODULE=auto
        go env -w GOPROXY=https://goproxy.io,direct
        # export GOPRIVATE=*.applysquare.* >> ~/.example
        # export "GOPROXY='https://goproxy.cn,direct'" >> ~/example.txt
        # export FLORA_DIR='$HOME/a2/src/eng/flora' >> ~/example.txt
        #alias flora=$FLORA_DIR/scripts/flora.sh >> ~/.example
        #source ~/.zshrc
        ;;
    */bash)
        echo "当前是bash shell"
        export GOPRIVATE=*.applysquare.* >> ~/.bashrc
        export GOPROXY=https://goproxy.cn,direct >> ~/.bashrc
        export FLORA_DIR=$HOME/a2/src/eng/flora >> ~/.bashrc
        source ~/.bashrc
        alias flora=$FLORA_DIR/scripts/flora.sh >> ~/.bashrc
        ;;
    */fish)
        echo "当前是fish shell"
        set -xe FLORA_DIR $HOME/a2/src/eng/flora
        alias flora=$FLORA_DIR/scripts/flora.sh
        # TODO fish脚本判断
    esac
}

if [ $(uname) == "Darwin" ];then
    echo 'Mac';
    # Homebrew
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
        brew update
    fi
    # 安装所需要的软件
    for loop in go git visual-studio-code postman docker vim
    do
        packageInstall $loop
    done
    # Go环境配置
    goConfigForMac
fi




