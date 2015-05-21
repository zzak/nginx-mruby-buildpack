FROM heroku/cedar:14

#RUN useradd -d /app -m app
#USER app
RUN mkdir -p /app
WORKDIR /app

ENV HOME /app
ENV PORT 3000

RUN mkdir -p /app/heroku
RUN mkdir -p /app/src
RUN mkdir -p /app/.profile.d

# root is required for `herokuish build`
USER root

# Download TerenceRuby
RUN mkdir -p /opt/rubies/2.2.2
RUN curl https://s3-external-1.amazonaws.com/heroku-buildpack-ruby/cedar-14/ruby-2.2.2.tgz --silent -L | tar -xzC /opt/rubies/2.2.2
# Prepend TerenceRuby to PATH
ENV PATH /opt/rubies/2.2.2/bin:$PATH

# Download Herokuish
RUN curl https://github.com/gliderlabs/herokuish/releases/download/v0.3.0/herokuish_0.3.0_linux_x86_64.tgz --silent -L | tar -xzC /bin

# Setup herokuish with default buildpacks
RUN herokuish buildpack install \
  && ln -s /bin/herokuish /build
  && ln -s /bin/herokuish /start
  && ln -s /bin/herokuish /exec

# Install ngx_mruby-buildpack using herokuish
RUN /bin/herokuish buildpack install git://github.com/zzak/ngx_mruby-buildpack.git

# Build it
RUN herokuish buildpack build

ONBUILD COPY . /app
#ONBUILD EXPOSE 3000
