#!/bin/sh
if["$(uname)"=="Darwin"];
    echo 'Mac'
    # Mac OS X 操作系统
elif["$(expr substr $(uname -s) 1 5)"=="Linux"];
    # GNU/Linux操作系统
    echo 'Linux'
elif["$(expr substr $(uname -s) 1 10)"=="MINGW32_NT"];
    # Windows NT操作系统
    echo 'Ming32_NT'
