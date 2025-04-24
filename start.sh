#!/bin/bash

aria2c --conf-path=/app/aria2.conf & 

./cloudreve -c /app/conf.ini
