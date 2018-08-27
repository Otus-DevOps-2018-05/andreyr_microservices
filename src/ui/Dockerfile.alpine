FROM alpine:3.7

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/

RUN apk update \
    && apk add --update --no-cache ruby ruby-dev build-base \
    && gem install bundler --no-ri --no-rdoc \
    && rm -rf /var/cache/apk/* \
    && bundle install \
    && apk del build-base ruby-dev

COPY . $APP_HOME/

ENV POST_SERVICE_HOST post
ENV POST_SERVICE_PORT 5000
ENV COMMENT_SERVICE_HOST comment
ENV COMMENT_SERVICE_PORT 9292

CMD ["puma"]
