FROM ruby:2.5

RUN apt-get update -qq && apt-get install -qqy build-essential nodejs

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock /app/
RUN bundle install --without development test

ENV RAILS_ENV production
ENV RACK_ENV production

COPY . /app

RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD bundle exec rails server
