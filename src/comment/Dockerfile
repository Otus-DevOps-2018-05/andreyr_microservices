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

ENV COMMENT_DATABASE_HOST comment_db
ENV COMMENT_DATABASE comments

CMD ["puma"]
