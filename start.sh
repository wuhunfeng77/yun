#!/bin/bash

aria2c --conf-path=/app/aria2.conf & 

./cloudreveplus-linux-amd64v2 -c /app/conf.ini
