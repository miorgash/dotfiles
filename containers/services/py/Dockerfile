FROM ubuntu:18.04
RUN : "essential" && \
    apt update -y && \
    apt upgrade -y && \
    apt install sudo apt-utils vim git -y && \
    : "python" && \
    apt install python3.7 python3.7-dev python3-pip python3.7-venv -y && \
    python3.7 -m pip install -U pip && \
    : "required by mecab-python3, Tensorflow etc." && \
    apt install swig -y && \
    python3.7 -m pip install wheel && \
    python3.7 -m pip install -U setuptools && \
    python3.7 -m pip install -U six
RUN : "image peculiar settings" && \
    : "MeCab and dictionaries": && \
    apt install mecab libmecab-dev mecab-ipadic-utf8 -y && \
    apt install unidic-mecab -y && \
    : "update-alternatives --config mecab-dictionary # interactive check command" && \
    apt install git make curl xz-utils file unzip -y && \
    git clone --depth 1 https://github.com/neologd/mecab-unidic-neologd /tmp/mecab-unidic-neologd
WORKDIR /tmp/mecab-unidic-neologd
RUN ./bin/install-mecab-unidic-neologd -n -y
COPY ./requirements.txt /var/requirements.txt
RUN : "Default kernel" && \
    pip install -U pip && \
    pip install -r /var/requirements.txt
COPY ./TensorFlow-2.2.0/requirements.txt /var/kernels/TensorFlow-2.2.0/requirements.txt
RUN : "Kernel for TensorFlow 2.2.0" && \
    python3.7 -m venv /var/kernels/TensorFlow-2.2.0/venv && \
    . /var/kernels/TensorFlow-2.2.0/venv/bin/activate && \
    pip install -U pip && \
    pip install -r /var/kernels/TensorFlow-2.2.0/requirements.txt && \
    ipython kernel install --user --name=TensorFlow-2.2.0 --display-name=TensorFlow-2.2.0 && \
    deactivate
RUN : "jupyter setting" && \
    python3.7 -m jupyter notebook --generate-config && \
    mkdir -p ~/.jupyter/custom
COPY ./custom.css /root/.jupyter/custom/custom.css
WORKDIR /var/assets
ENTRYPOINT ["jupyter", "notebook"]
CMD ["--no-browser", "--port", "8888", "--ip", "0.0.0.0", "--allow-root"]
