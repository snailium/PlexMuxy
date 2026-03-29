# 使用轻量级 Python 镜像作为我们的秘密基地
FROM python:3.11-slim

# 1. 先装好基础工具：下载工具 wget 和 MKVToolNix
RUN apt-get update && apt-get install -y \
    wget \
    mkvtoolnix \
    && rm -rf /var/lib/apt/lists/*

# 2. 直球突击！无视系统的限制，直接从 RAR 官网下载官方核心程序！🎯
RUN wget https://www.rarlab.com/rar/rarlinux-x64-701.tar.gz \
    && tar -zxvf rarlinux-x64-701.tar.gz \
    && cp rar/unrar /usr/bin/ \
    && rm -rf rar rarlinux-x64-701.tar.gz

# 3. 把 PlexMuxy 的代码搬进秘密基地
WORKDIR /app
COPY . /app

# 4. 照着我们刚刚洗得干干净净的 requirements.txt 安装依赖！
RUN pip install -r requirements.txt

# 5. 空间转移魔法！告诉 Python 代码在哪，然后把工作重心转移到 /media 🌟
ENV PYTHONPATH="/app"
WORKDIR /media

# 6. 出击命令！无论身在何处，精准引爆主程序！
CMD ["python", "/app/main.py"]

