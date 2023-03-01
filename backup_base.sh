#!/bin/bash

cd ~/.backup/base_cofigration
cp ~/.vim ~/.vimrc ~/.bashrc ~/.profile ~/.config/nvim .
git add .
git commit -m "update configration"
git push origin
