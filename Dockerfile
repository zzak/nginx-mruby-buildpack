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

# Download TerenceRuby
RUN mkdir -p /opt/rubies/2.2.2
RUN curl https://s3-external-1.amazonaws.com/heroku-buildpack-ruby/cedar-14/ruby-2.2.2.tgz --silent -L | tar -xzC /opt/rubies/2.2.2
# Prepend TerenceRuby to PATH
ENV PATH /opt/rubies/2.2.2/bin:$PATH

ONBUILD COPY . /app
#ONBUILD EXPOSE 3000
