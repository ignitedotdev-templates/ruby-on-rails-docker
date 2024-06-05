FROM ruby:slim-bullseye as base

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

WORKDIR /docker/app

RUN gem install bundler

COPY Gemfile* ./

RUN bundle install

ADD . /docker/app

RUN bundle exec rake assets:precompile 

ARG DEFAULT_PORT 3000

EXPOSE ${DEFAULT_PORT}


# CMD ["rails","server"] # you can also write like this.
# CMD ["build", "exec", "rails", "server", "-b", "0.0.0.0"]
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
