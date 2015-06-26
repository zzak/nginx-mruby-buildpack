FROM heroku/cedar:14

RUN useradd -d /app -m app
USER app

WORKDIR /buildpack
COPY bin/ /buildpack/bin/
COPY conf/ /buildpack/conf/
RUN /buildpack/bin/compile /app && \
    /buildpack/bin/release /app > /app/.release

ENV HOME /app
ENV PORT 3000
EXPOSE 3000

WORKDIR /app

ENTRYPOINT ["/app/bin/init"]
