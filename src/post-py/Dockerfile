FROM alpine:3.7

WORKDIR /app
COPY . /app

RUN apk add --update --no-cache python3 \
    && find / -type d -name __pycache__ -exec rm -r {} + \
    && rm -r /usr/lib/python*/ensurepip \
    && rm -r /usr/lib/python*/lib2to3 \
    && rm -r /usr/lib/python*/turtledemo \
    && rm /usr/lib/python*/turtle.py \
    && rm /usr/lib/python*/webbrowser.py \
    && rm /usr/lib/python*/doctest.py \
    && rm /usr/lib/python*/pydoc.py \
    && rm -rf /root/.cache /var/cache /usr/share/terminfo \
    && pip3 --no-cache-dir install -r /app/requirements.txt \
    && rm -rf /tmp/pip-build* ~/.cache/pip* \
    && rm -rf /var/cache/apk/*

ENV POST_DATABASE_HOST post_db
ENV POST_DATABASE posts

ENTRYPOINT ["python3", "post_app.py"]
