FROM python:3.10.6-slim-buster
LABEL maintainer="khodanmarko@gmail.com"

ENV PYTHONUNBUFFERED=1

WORKDIR app/

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt

RUN apt-get update  \
    && apt-get -y install libpq-dev gcc

COPY . .

RUN mkdir -p /vol/web/media

RUN adduser \
    --disabled-password \
    --no-create-home \
    django-user

RUN chown -R django-user:django-user /vol/
RUN chmod -R 755 /vol/web

USER django-user