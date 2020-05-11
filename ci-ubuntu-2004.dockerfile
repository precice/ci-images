# Dockerfile for building preCICE on ubuntu 20.04

# Using ubuntu 18.04 as basis
FROM ubuntu:20.04

RUN groupadd precice && useradd -m -s /bin/bash precice

# Installing necessary dependecies for preCICE
RUN apt-get -qq update && apt-get -qq install \
    git \
    build-essential \
    cmake \
    libeigen3-dev \
    libxml2-dev \
    libboost-all-dev \
    petsc-dev \
    python3-dev \
    python3-numpy && \
    rm -rf /var/lib/apt/lists/*
