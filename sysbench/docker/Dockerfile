FROM ubuntu:bionic
RUN cat /etc/resolv.conf
RUN apt-get update
RUN apt-get -y install sysbench
WORKDIR /src
ENV COUNT=20
COPY testrun.sh /src
VOLUME /experiment
CMD ./testrun.sh "${COUNT}" sysbench --test=cpu --num-threads=2 --max-requests=10  --cpu-max-prime=2000000 run
