FROM nvidia/cuda:10.0-base-ubuntu18.04
RUN : "essential" && \
    apt update -y && \
    apt upgrade -y && \
    apt install sudo apt-utils vim git -y && \
    : "python" && \
    apt install python3.7 python3.7-dev python3-pip python3.7-venv -y && \
    python3.7 -m pip install -U pip && \
    : "requirements for mecab-python3, Tensorflow etc." && \
    apt install swig -y && \
    python3.7 -m pip install wheel && \
    python3.7 -m pip install -U setuptools && \
    python3.7 -m pip install -U six
COPY ./requirements.txt /tmp/requirements.txt
RUN : "image peculiar settings" && \
    python3.7 -m pip install -r /tmp/requirements.txt
WORKDIR /tmp/
