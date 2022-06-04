FROM ubuntu:20.04

ARG PROBLEM
ARG PORT
ARG USER

ENV PROBLEM $PROBLEM
ENV PORT $PORT
ENV USER $USER

RUN dpkg --add-architecture i386
RUN apt-get update && apt-get install -y \
	libc6:i386 \
	socat \
	&& rm -rf /var/lib/apt/lists/*

COPY ./problem/$PROBLEM /home/$PROBLEM

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh

