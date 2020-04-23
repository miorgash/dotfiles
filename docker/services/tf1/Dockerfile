FROM nvidia/cuda:10.0-base-ubuntu18.04
RUN : "essential" && \
    apt update -y && \
    apt upgrade -y && \
    apt install sudo apt-utils vim git -y && \
    : "python" && \
    apt install python3.7 python3.7-dev python3-pip -y && \
    python3.7 -m pip install -U pip && \
    : "required by mecab-python3, Tensorflow etc." && \
    apt install swig -y && \
    python3.7 -m pip install wheel && \
    python3.7 -m pip install -U setuptools && \
    : "install all packages" && \
    git clone https://github.com/miorgash/env.git ~/env && \
    python3.7 -m pip install -r ~/env/dotfiles/requirements-tf1.txt
WORKDIR /tmp/
