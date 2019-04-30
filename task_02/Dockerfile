FROM ruby:2.6.3

WORKDIR /usr/source/app

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
        apt-get install -qy nodejs

RUN gem install bundler -v '1.17.3'

COPY Gemfile Gemfile.lock .

RUN bundle install

COPY . .

RUN cp config/database.yml.sample config/database.yml

RUN rails db:migrate && rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
