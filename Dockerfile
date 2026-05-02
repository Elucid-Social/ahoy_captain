FROM ruby:3.3-slim

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libsqlite3-dev && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ahoy_captain.gemspec ./
COPY lib/ahoy_captain/version.rb lib/ahoy_captain/version.rb

RUN gem install bundler -v 4.0.9 && \
    bundle install

COPY . .

ENV RAILS_ENV=test

CMD ["bundle", "exec", "rspec"]
