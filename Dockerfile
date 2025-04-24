FROM debian:latest

# 安装必要工具
RUN apt-get update && apt-get install -y \
    wget \
    tar \
    aria2 \
    && rm -rf /var/lib/apt/lists/*

# 创建工作目录
WORKDIR /app

# 下载并安装 Alist
RUN wget https://github.com/alist-org/alist/releases/latest/download/alist-linux-amd64.tar.gz \
    && tar -zxvf alist-linux-amd64.tar.gz \
    && rm alist-linux-amd64.tar.gz \
    && chmod +x alist

# 创建数据目录
RUN mkdir -p /data && chmod 777 /data

# 复制配置文件
COPY aria2.conf /app/aria2.conf

# 暴露端口 (Alist 默认使用 5244)
EXPOSE 5244

# 启动脚本
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

CMD ["/app/start.sh"]
