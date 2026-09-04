#!/usr/bin/env bash

set -e

echo "=========================================="
echo " High-Performance Network Library Setup"
echo "=========================================="

sudo apt-get update

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    build-essential \
    cmake \
    git \
    gdb \
    valgrind \
    clang-format \
    clang-tidy \
    cppcheck \
    iperf3 \
    iproute2 \
    iputils-ping \
    net-tools \
    tcpdump \
    python3 \
    python3-pip \
    curl \
    llvm \
    libboost-all-dev \
    libmysqlcppconn-dev

echo "=========================================="
echo " Environment setup completed successfully"
echo "=========================================="