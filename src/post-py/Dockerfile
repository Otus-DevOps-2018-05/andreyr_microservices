FROM python:3.6.0-alpine

WORKDIR /app
COPY . /app

RUN pip --no-cache-dir install -r /app/requirements.txt \
    && rm -rf /tmp/pip-build* ~/.cache/pip*

ENV POST_DATABASE_HOST post_db1
ENV POST_DATABASE posts

ENTRYPOINT ["python3", "post_app.py"]
