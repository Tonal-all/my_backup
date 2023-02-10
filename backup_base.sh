#!/bin/bash

cd ~/.backup/base_cofigration
cp ~/.vim ~/.vimrc ~/.bashrc ~/.profile .
git add .
git commit -m "update configration"
git push origin
