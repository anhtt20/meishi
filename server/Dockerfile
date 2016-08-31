# Use the barebones version of Ruby 2.2.3.
FROM ruby:2.2.3-slim

# Optionally set a maintainer name to let people know who made this image.
MAINTAINER KOJIRO YAMASHIRO <kojiro.yamashiro@glv.co.jp>

# Install dependencies:
# - build-essential: To ensure certain gems can be compiled
# - nodejs: Compile assets
# - libpq-dev: Communicate with postgres through the postgres gem
# - postgresql-client-9.4: In case you want to talk directly to postgres
RUN apt-get update && \
    apt-get install -qq -y build-essential nodejs libpq-dev libmysqlclient-dev libsqlite3-dev --fix-missing --no-install-recommends
RUN gem install bundler

# Set an environment variable to store where the app is installed to inside
# of the Docker image.
ENV INSTALL_PATH /usr/src/hoan2system
RUN mkdir -p $INSTALL_PATH

# This sets the context of where commands will be ran in and is documented
# on Docker's website extensively.
WORKDIR $INSTALL_PATH

# Ensure gems are cached and only get updated when they change. This will
# drastically increase build times when your gems do not change.
COPY ./meishi_api/Gemfile $INSTALL_PATH
COPY ./meishi_api/Gemfile.lock $INSTALL_PATH
RUN bundle install

# Copy in the application code from your work station at the current directory
# over to the working directory.
COPY ./meishi_api $INSTALL_PATH

# The default command that gets ran will be to start the Unicorn server.
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]                                                                                                         1,1          先