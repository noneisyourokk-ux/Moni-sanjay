FROM python:3.10-slim-bookworm

RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc \
    libffi-dev \
    ffmpeg \
    aria2 \
    && rm -rf /var/lib/apt/lists/*

COPY . /app
WORKDIR /app

RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --no-cache-dir pytube yt-dlp selenium cloudscraper gunicorn

ENV COOKIES_FILE_PATH=/app/youtube_cookies.txt

CMD sh -c "gunicorn app:app & python3 main.py"
