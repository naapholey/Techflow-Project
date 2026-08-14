FROM python:3.11-slim

LABEL maintainer="Antoinette <naapholei@gmail.com>"
LABEL version="1.0.0"
LABEL description="Simple Flask app for Docker demonstration"

# Prevents Python from writing pyc files to disc
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

ENV APP_ENV=production
ENV PORT=5000

# Set working directory in container
WORKDIR /app

USER root
#install system dependencies (if needed)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \ 
    pip install --no-cache-dir -r requirements.txt

COPY app.py .

#create non-root user for security
RUN useradd -m -u 1005 techflowuser && \
    chown -R techflowuser:techflowuser /app

 #modify user since uid 1000 is already taken in the base image
 

#switch to non-root user
USER techflowuser

#expose port that the app runs on 
EXPOSE 5000

#Health check - Docker will check if container is healthy
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD PYTHONPATH=/app python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

#Command to run the application
CMD ["python", "app.py"]