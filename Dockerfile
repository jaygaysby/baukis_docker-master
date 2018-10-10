FROM ruby:2.4.1-alpine

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev postgresql-dev mysql-dev" \
    RUBY_PACKAGES="ruby-json yaml nodejs" \
    LANG=ja_JP.UTF-8 \
    APP_ROOT=/usr/src/app

RUN apk update && \
    apk upgrade && \
    apk add --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/* && \
    mkdir -p $APP_ROOT

WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN bundle config build.nokogiri --use-system-libraries && \
    bundle install --jobs 4 && \
    bundle clean

WORKDIR $APP_ROOT
COPY . $APP_ROOT

EXPOSE 3000
