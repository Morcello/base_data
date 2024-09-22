ARG RUBY_VERSION=3.1.2

FROM ruby:$RUBY_VERSION

WORKDIR /app

RUN apt-get update && \
    apt-get install -y nodejs apt-utils libpq-dev && \
    apt-get clean && \
    gem install bundler

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile --gemfile app/ lib/
# Precompile assets (optional, if using Rails with assets)
RUN bundle exec rake assets:precompile

EXPOSE 3000

CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
