FROM ubuntu:18.04

ARG PROBLEM
ARG PORT

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y \
    socat \
    libc6:i386

COPY problem/$PROBLEM /home/$PROBLEM

ENV PROBLEM $PROBLEM
ENV PORT $PORT

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
