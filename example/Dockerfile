FROM zzak/nginx-mruby-buildpack

COPY Procfile /app/Procfile
COPY public/* /app/public/
COPY *.rb /app/

USER root
RUN chown -R app:app /app

USER app
