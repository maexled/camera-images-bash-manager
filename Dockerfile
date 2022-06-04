FROM python:3.9-slim-buster

WORKDIR /camera

COPY requirements.txt ./

RUN apt update && \
    apt upgrade -y && \
    apt install ffmpeg zip curl -y && \
    pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -rf /var/lib/apt/lists/*


COPY . .
RUN mkdir files

RUN chmod a+x docker-entrypoint.sh
CMD ["./docker-entrypoint.sh"]