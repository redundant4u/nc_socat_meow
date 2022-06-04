FROM python:3.6

ARG PORT
ARG PROBLEM
ARG USER

ENV PROBLEM $PROBLEM
ENV PORT $PORT
ENV USER $USER

RUN apt-get update && apt-get install -y \
	socat

RUN pip3 install \
	gmpy2 \
	pycryptodome

WORKDIR /home/$PROBLEM

RUN echo "#\!/bin/bash\npython3 $PROBLEM.py" > py.sh
RUN chmod +x /home/$PROBLEM/py.sh

COPY ./problem/$PROBLEM /home/$PROBLEM

COPY entrypoint.py.sh /entrypoint.sh

ENTRYPOINT /entrypoint.sh

