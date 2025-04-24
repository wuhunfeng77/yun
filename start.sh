#!/bin/bash

# 启动 aria2
aria2c --conf-path=/app/aria2.conf -D

# 启动 Alist
/app/alist server
