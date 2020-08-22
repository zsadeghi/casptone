FROM ubuntu:bionic
RUN apt-get update
RUN apt-get install -y bonnie++
RUN mkdir /src
COPY testrun.sh /src
WORKDIR /src
VOLUME /experiment
ENV COUNT=100
ENV SIZE=1
CMD ./testrun.sh "${COUNT}" bonnie++ -d /tmp -r "${SIZE}G" -s "$((SIZE * 2))G" -n 0 -m test -f -b -u root
#CMD bash
