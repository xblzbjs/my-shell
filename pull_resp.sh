#!/bin/bash

directory_path = ""

function get_directory_path() {
    echo "==========================="
    read -p "Enter directory path: " directory_path
    if test -z "directory_path"; then
        get_directory_path
    else
        read_dir ${directory_path}
    fi
}

function read_dir() {
    for file in `ls $1`
    do
        if [ -d $1"/"$file ]  #注意此处之间一定要加上空格，否则会报错
        then
            #在此处处理目录即可
            echo "-----------------------------\n"
            echo "check directory:《" $file "》"
            echo "message:"
            cd $1"/"$file
            git pull
            echo "\n"
        fi
    done
}


get_directory_path

echo "\n--------- finish processing ---------"
