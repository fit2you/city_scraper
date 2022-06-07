FROM ruby:2.7-slim-bullseye

# Common dependencies
RUN apt-get update -qq \
  && DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends \
  build-essential \
  curl \
  git \
  gnupg2 \
  ssh \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && truncate -s 0 /var/log/*log

RUN mkdir -p /srv/www/app

WORKDIR /srv/www/app

COPY Gemfile Gemfile.lock /srv/www/app/

RUN bundle install

COPY . /srv/www/app