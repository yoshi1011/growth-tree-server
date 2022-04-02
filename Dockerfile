FROM ruby:3.1.1

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN mkdir /app
WORKDIR /app

RUN apt update -qq \
    && apt install -y \
      sudo \
      git \
      build-essential \
      libpq-dev \
      postgresql-client

RUN gem install bundler -v '2.2.19'

COPY . /app/

RUN bundle install
