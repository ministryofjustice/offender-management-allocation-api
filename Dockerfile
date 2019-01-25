FROM ruby:2.5.3-stretch

ENV \
  LANG=en_GB.UTF-8 \
  TZ=Europe/London

ARG VERSION_NUMBER
ARG COMMIT_ID
ARG BUILD_DATE
ARG BUILD_TAG

ENV APPVERSION=${VERSION_NUMBER}
ENV APP_GIT_COMMIT=${COMMIT_ID}
ENV APP_BUILD_DATE=${BUILD_DATE}
ENV APP_BUILD_TAG=${BUILD_TAG}

WORKDIR /app

RUN \
  set -ex \
  && apt-get update \
  && apt-get install \
    -y \
    --no-install-recommends \
    build-essential \
    libpq-dev \
    netcat \
  && gem update bundler --no-document

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install --without development test --jobs 2 --retry 3
COPY . /app

ENTRYPOINT ["./run.sh"]
