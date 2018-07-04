# It will get the ubuntu image from docker hub
FROM ubuntu:16.04

# Use nano as env editor
ENV EDITOR nano

# Update the ubuntu os and install all dependency
RUN apt-get update && apt-get install -y \
    net-tools \
    iputils-ping \
    wget \
    curl \
    nano \
    build-essential \
    software-properties-common \
    git \
    openssl \
    libssl-dev \
    libffi6 \
    libffi-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    mysql-client \
    libmysqlclient-dev

# Add ruby repository
RUN add-apt-repository ppa:brightbox/ruby-ng

# Update os and Install ruby
RUN apt-get update && apt-get install -y ruby2.4 ruby2.4-dev git

# Install the bundler
RUN gem install bundler pkg-config

# Ask to use system's libraries for nokogiri
RUN bundle config build.nokogiri --use-system-libraries

# Add current directory to app directory
ADD . /home/app

# Mention work directory
WORKDIR /home/app

# Run the bundler
RUN bundle

# Mention the entry point and ask to use puma in the port of 80
ENTRYPOINT bundle exec puma -p 3031