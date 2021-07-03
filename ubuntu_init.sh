#!/bin/bash

function log() {
    echo $(date -u '+%Y-%m-%dT%H:%M:%S')" INFO:  "$@
}

returnCode=`which zsh`
user=`whoami`


if [[ returnCode != "0" ]]; then
    log "install zsh start" && sudo apt-get install -y zsh && log "install zsh end"
    # 将zsh设置为默认shell
    sudo chsh -s $(which zsh)
    if [[ `echo $SHELL` != "/usr/bin/zsh" ]]; then
        log "zsh not your default shell"
    else
        log "zsh is your default shell"
    fi
else
    log "zsh installed"
fi


# 升级包
log "system softeware update and upgrade" && sudo apt-get update && apt-get upgrade -y
log "install oh-my-zsh" && cd /home/$user && sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" && log "install oh-my-zsh end"
log "install zsh-syntax-highlighting" && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git /home/$user/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting && log "install zsh-syntax-highlighting end"
# 安装zsh-autosuggestions，记录经常用的一些命令并进行提示
log "install zsh-autosuggestions" && git clone https://github.com/zsh-users/zsh-autosuggestions.git /home/$user/.oh-my-zsh/custom/plugins/zsh-autosuggestions && log "install zsh-autosuggestions end"
# 添加插件到 .zshrc 中
log "add plugs in .zshrc" && sed -i 's/^plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' /home/$user/.zshrc && log "add plugs in .zshrc end"
log "source zshcr" && source ~/.zshrc
log "init end"
