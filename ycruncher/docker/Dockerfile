FROM ubuntu:bionic
RUN apt-get update
RUN apt-get install -y curl=7.58.0-2ubuntu3.8 \
	xz-utils=5.2.2-1.3 \
	libnuma-dev=2.0.11-2.1ubuntu0.1 --no-install-recommends
RUN apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /src
RUN curl http://www.numberworld.org/y-cruncher/y-cruncher%20v0.7.8.9506-dynamic.tar.xz -o y-cruncher.tar.xz
RUN tar xf y-cruncher.tar.xz
RUN rm -rf y-cruncher.tar.xz
RUN mv 'y-cruncher v0.7.8.9506-dynamic' y-cruncher-src
RUN mv y-cruncher-src/* .
RUN rm -rf y-cruncher-src
ENV COUNT=100
COPY testrun.sh /src
COPY runonce.sh /src
VOLUME /experiment
CMD ./testrun.sh "${COUNT}" ./runonce.sh
