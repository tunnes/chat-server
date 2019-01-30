FROM ruby:2.5.1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /chat_server
WORKDIR /chat_server
COPY Gemfile /chat_server/Gemfile
COPY Gemfile.lock /chat_server/Gemfile.lock
RUN bundle install
COPY . /chat_server
