FROM crystallang/crystal:0.17.4

MAINTAINER Kepler Sticka-Jones

RUN useradd -u 9000 -r -s /bin/false app

WORKDIR /usr/src/app
COPY . /usr/src/app
RUN mkdir -p bin
RUN crystal build src/codeclimate-crystal-format.cr -o /usr/src/app/bin/crystal-format

WORKDIR /code

USER app
VOLUME /code

CMD ["/usr/src/app/bin/crystal-format"]
