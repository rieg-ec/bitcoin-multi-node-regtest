FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt-get upgrade -y
RUN apt install gcc gdb make git curl wget vim cmake -y

RUN mkdir /app
WORKDIR /app
