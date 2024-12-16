FROM python:3.12-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONPATH=/app

RUN apt-get update && apt-get install -y \
    netcat-traditional \
    sqlite3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*



COPY requirements.txt .
COPY requirements-test.txt .

RUN pip install --upgrade pip && pip install -r requirements.txt -r requirements-test.txt

COPY . /app/

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

CMD ["python", "run.py"]