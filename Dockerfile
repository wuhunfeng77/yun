FROM debian:latest

RUN apt-get update && apt-get install -y \
    wget \
    unzip
RUN apt-get update && apt-get install -y aria2
WORKDIR /app

RUN wget https://github.com/cloudreve/Cloudreve/files/14327249/cloudreveplus-linux-amd64v2.zip \
    && unzip cloudreveplus-linux-amd64v2.zip \
    && rm cloudreveplus-linux-amd64v2.zip

RUN chmod 777 /app
COPY aria2.conf /app/aria2.conf
# 复制配置文件模板到容器中
COPY conf.ini /app/conf.ini
# 接收从构建过程传递的 SLAVE_SECRET
ARG SLAVE_SECRET
# 替换配置文件中的占位符
RUN sed -i "s|\${SLAVE_SECRET}|${SLAVE_SECRET}|g" /app/conf.ini

RUN chmod +x ./cloudreveplus-linux-amd64v2

RUN mkdir -p /aria2/data

RUN chmod 777 /aria2/data

EXPOSE 8080

# CMD ["./cloudreve","-c","/app/conf.ini"]
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh
CMD ["/app/start.sh"]
