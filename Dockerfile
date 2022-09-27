FROM elixir:1.14.0-alpine

RUN apk add git

RUN addgroup -g 1000 elixir \
    && adduser -u 1000 -G elixir -s /bin/bash -D elixir

USER elixir

RUN mix local.hex --force && \
    mix archive.install hex phx_new 1.6.12 --force && \
    mix local.rebar --force

WORKDIR /home/elixir/backend