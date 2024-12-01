# Credit for this base at: https://gist.github.com/hsradA23/afae2c598ce954e2a07ac6c368074f54
FROM alpine:3.20.3 AS gleam
RUN apk add gleam
RUN mkdir /app
RUN mkdir -p /.mix/archives/
RUN mkdir /.cache
RUN chmod 777 /.cache
RUN chmod 777 /.mix
WORKDIR /app

FROM gleam
WORKDIR /app
COPY . .
RUN gleam test
ENTRYPOINT [ "gleam", "run" ]
