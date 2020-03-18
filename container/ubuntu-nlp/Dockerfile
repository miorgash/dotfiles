FROM ubuntu:18.04
RUN : "essential" && \
    apt update -y && \
    apt upgrade -y && \
    apt install sudo -y && \
    : "python" && \
    apt install python3.7 python3.7-dev python3-pip python3.7-venv -y && \
    python3.7 -m pip install -U pip && \
    python3.7 -m venv ~/.venv/nlp && \
    : "MeCab": && \
    apt install mecab libmecab-dev mecab-ipadic-utf8 -y && \
    apt install unidic-mecab -y && \
    : "# interactive check method" && \
    : "update-alternatives --config mecab-dictionary" && \
    apt install git make curl xz-utils file unzip -y && \
    git clone --depth 1 https://github.com/neologd/mecab-unidic-neologd /tmp/mecab-unidic-neologd
WORKDIR /tmp/mecab-unidic-neologd
RUN ./bin/install-mecab-unidic-neologd -n -y
WORKDIR ~
RUN : "required by mecab-python3, Tensorflow etc." && \
    apt install swig -y && \
    pip install wheel && \
    pip install -U setuptools && \
    : "install all packages" && \
    git clone https://github.com/miorgash/env.git ~/env && \
    pip install -r ~/env/ubuntu/requirements.txt && \
    ############### ここから >>>
    pip install jupyter ipython mecab-python3 && \
    : "visual setting" && \
    mkdir -p ~/.jupyter/custom && \
    ln -s /home/ubuntu/env/dotfiles/custom.css /home/ubuntu/.jupyter/custom/custom.css
CMD ["jupyter", "notebook", "--no-browser", "-p", "8888"]
