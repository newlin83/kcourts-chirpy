FROM ruby:3.3.6

WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
CMD ["bundle", "exec", "jekyll", "build"]
