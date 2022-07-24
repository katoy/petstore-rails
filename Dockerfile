FROM ruby:3.1.2-alpine3.15

## See https://www.karakaram.com/rails6-and-mysql-with-alpine-linux-based-docker-image/

ARG RAILS_ENV
ARG RAILS_MASTER_KEY

WORKDIR /app
COPY Gemfile* /app/

RUN apk update \
    && apk add --no-cache --virtual=.build-deps \
    build-base \
    && apk add --no-cache gmp-dev \
    sqlite-dev \
    tzdata \
    nodejs~=16 \
    yarn \
    && bundle config set force_ruby_platform true \
    && gem install bundler \
    && bundle install \
    && yarn install \
    && rails assets:precompile \
    && apk del .build-deps

# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]

# EXPOSE 3000

# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
