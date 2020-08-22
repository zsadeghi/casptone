# Dockerfile that runs the conversion command for bonnie++ to CSV output
FROM ubuntu:bionic
RUN apt-get update
RUN apt-get install -y bonnie++
ENTRYPOINT bon_csv2html
