FROM python:3.13-bookworm

WORKDIR /app

COPY . .

RUN pip install -r requirements.txt

ENTRYPOINT ["python", "app.py"]

