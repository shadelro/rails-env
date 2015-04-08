# Specify base image
FROM centos

# Install base dependencies
RUN yum update -y
RUN yum install -y git tar
RUN yum install -y make gcc openssl-devel libyaml-devel libffi-devel readline-devel zlib-devel gdbm-devel ncurses-devel ruby-devel zlib-devel patch gcc-c++
RUN yum install -y postgresql postgresql-devel

# Install rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
    cd /tmp/ruby-build && \
    ./install.sh && \
    cd / && \
    rm -rf /tmp/ruby-build

# Install ruby
RUN ruby-build -v 2.2.1 /usr/local

# Install base gems
RUN gem install bundler rubygems-bundler --no-rdoc --no-ri

# Regenerate binstubs
RUN gem regenerate_binstubs

# Create a web user
RUN adduser --home=/web web
