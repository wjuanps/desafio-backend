FROM ruby:2.7.5

RUN apt-get update
RUN apt-get install -y \
    bash \
    build-essential \
    g++ \
    git \
    less \
    libffi-dev \
    libsodium-dev \
    libssl-dev \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    make \
    nodejs \
    rsync \
    unixodbc \
    unixodbc-dev

RUN echo 'alias console="rails console"' >> ~/.bashrc && \
    echo 'alias be="bundle exec"' >> ~/.bashrc

ARG RAILS_ENV
ENV RAILS_ENV ${RAILS_ENV}

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN gem install bundler -v 2.1.4

ADD Gemfile* $APP_HOME/
RUN bundle install

COPY . .
