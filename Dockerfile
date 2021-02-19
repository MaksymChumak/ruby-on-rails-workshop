FROM ruby:2.7.2

WORKDIR /home/workshop

# install dependencies
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install nodejs
RUN gem install bundler --version="2.2.0"

# copy project
COPY Gemfile* ./
RUN bundle install

COPY . .

# expose application port
EXPOSE 3000

# start the main process
RUN chmod +x /home/workshop/docker-entrypoint.sh
CMD ["/bin/bash", "/home/workshop/docker-entrypoint.sh"]
