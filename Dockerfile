FROM postgres:11.6-alpine

RUN apk add --no-cache git build-base ruby ruby-full ruby-dev

RUN gem install -q --no-ri --no-rdoc -v '~> 1' bundler

RUN mkdir /gem
WORKDIR /gem

COPY ./ ./
RUN bundle install --no-cache

ENV DATABASE_URL=postgresql://postgres@localhost/postgres?pool=5

ENTRYPOINT []

CMD ["sh", "-c", "(nohup /docker-entrypoint.sh postgres > /dev/null &) && sleep 3 && bundle install && bundle exec rake"]
