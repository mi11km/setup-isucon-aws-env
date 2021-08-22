#!/bin/bash

# カレントディレクトリに　nginx/ mysql/ がない状態で実行する

app_absolute_dir_path=$(pwd)

sudo cp -r /etc/nginx $app_absolute_dir_path
sudo rm -rf /etc/nginx
sudo ln -s $app_absolute_dir_path/nginx /etc
sudo systemctl restart nginx


sudo cp -r /etc/mysql $app_absolute_dir_path
sudo rm -rf /etc/mysql
sudo ln -s $app_absolute_dir_path/mysql /etc
sudo systemctl restart mysql

# アプリコードのディレクトリに変更があれば、適応して
# sudo systemctl restart <app service>　する

# todo mysqlなぜかデータが無くなる