FROM ubuntu:bionic
RUN apt update
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt install -y wget gnupg2
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt update
ENV TZ 'America/Los_Angeles'
RUN echo $TZ > /etc/timezone && \
  apt update && apt install -y tzdata && \
  rm -rf /etc/localtime && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  dpkg-reconfigure -f noninteractive tzdata && \
  apt-get clean
RUN apt install -y postgresql-contrib
RUN pg_ctlcluster 12 main start
RUN echo local all postgres trust > /etc/postgresql/12/main/pg_hba.conf
RUN service postgresql start && pgbench -i -U postgres
RUN mkdir /src
COPY testrun.sh /src/testrun.sh
VOLUME /experiment
WORKDIR /src
RUN echo "#!/bin/bash" > startup.sh
RUN echo "mkdir /experiment/testing-shit" >> /src/startup.sh
RUN chmod +x /src/startup.sh
CMD ./testrun.sh 100 pgbench.sh --client=10 --jobs=10 --time=60 -U postgres
