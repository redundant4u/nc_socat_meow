FROM php:7.4-apache

ARG PROBLEM
ARG PORT

ENV PORT $PORT
ENV PROBLEM $PROBLEM

RUN sed -i 's/Listen 80/Listen '"$PORT"'/' /etc/apache2/ports.conf
RUN sed -i 's/80/'$PORT'/' /etc/apache2/sites-available/000-default.conf

COPY ./problem/$PROBLEM /var/www/html

