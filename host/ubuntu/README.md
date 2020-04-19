# How to setup Ubuntu 18.04

```bash
$ # setpassword
$ sudo su
# passwd ubuntu
# exit
$ 
$ # create ssh key
$ ssh-keygen
$ 
$ sudo apt update & sudo apt upgrade
$ 
$ # zsh
$ sudo apt install zsh -y
$ 
$ # prezto
$ # 1. オフィシャル README にしたがってインストール＆ログインシェルに設定: https://github.com/sorin-ionescu/prezto
$ # 2. .zshrc で prompt 設定を保存（prompt $name だと保存されない）: https://qiita.com/notakaos/items/89057f2119655ab9f920
$ 
$ # Personal settings
$ # repository
$ git clone https://github.com/miorgash/env.git
$ 
$ # tmux
$ ln -sf ${HOME}/env/dotfiles/.tmux.conf ${HOME}/.tmux.conf
$ 
$ # nvim
$ sudo apt install neovim -y
$ mkdir ~/.config
$ sh env/ubuntu/add-neovim-setting-to-zshrc.sh # zshrc を設定
$ exit # 設定反映のため；再度ログイン
$ env # XGD_CONFIG_HOME 設定を確認
$ sh env/ubuntu/setup-neovim.sh # colorscheme, vim-plug を設定
$ # :PlugInstall
$ 
$ 
$ # Docker & docker-compose
$ # 公式 Docs にしたがってインストール
$ # - Docker: https://docs.docker.com/install/linux/docker-ce/ubuntu/#prerequisites
$ # - docker-compose: https://docs.docker.com/compose/install/#install-compose
$ 
$ # Samba
$ sudo apt install cifs-utils -y
$ 
$ # GPU
$ # Deep Learning Base AMI (Ubuntu 18.04) Version 22.0 (ami-0cc60358212c0cc7e) を利用想定
$ # GPU が必要ない場合は適宜インスタンスタイプを変更する（別途インスタンスを用意する必要は無い）
$ # https://qiita.com/ttsubo/items/c97173e1f04db3cbaeda
$ 
$ # /etc/modprobe.d/blacklost-nouveau.conf
$ # blacklist nouveau
$ # options nouveau modeset=0
$ sudo update-initramfs -u # initramfs 再構築
$ sudo reboot
$ # install nvidia driver
$ sudo apt update && sudo apt install nvidia-driver-430 -y && sudo apt install nvidia-cuda-toolkit -y
$ # nvidia driver インストール確認
$ lspci -vv|grep -i nvidia
$ # nvidia-smi コマンド動作確認
$ nvidia-smi
$ # python からの利用確認；container 立ち上げ後，notebool/python で以下コードを実行
$ # https://thr3a.hatenablog.com/entry/20180113/1515820265
$ # from tensorflow.python.client import device_lib
$ # device_lib.list_local_devices()
$ 
$ # 以下不要
$ # # python
$ # sudo apt update -y && sudo apt upgrade -y && sudo apt install python3.7 -y && sudo apt install python3.7-dev -y && sudo apt install python3-pip -y && sudo apt install python3.7-venv -y
$ # python3.7 -m pip install -U pip
$ # # python3.7 -m venv ~/.venv/${VENV_NAME}
$ # sh env/ubuntu/add-python-setting-to-zshrc.sh # エイリアス等を設定
$ # 
$ # # MeCab
$ # sudo apt install mecab libmecab-dev mecab-ipadic-utf8 -y
$ # sudo apt install unidic-mecab -y
$ # sudo update-alternatives --config mecab-dictionary
$ # sudo apt install git make curl xz-utils file unzip -y
$ # git clone --depth 1 https://github.com/neologd/mecab-unidic-neologd /tmp/mecab-unidic-neologd
$ # cd /tmp/mecab-unidic-neologd
$ # ./bin/install-mecab-unidic-neologd -n -y
```

## Setup

```bash
$ # container
$ sudo docker run -itd -p 8888:8888 -v /mnt/pynlp:/var/assets --name pynlp miorgash/pynlp:latest
$ sudo docker run --gpus all,driver=nvidia,capabilities=compute -itd -p 8888:8888 -v /mnt/pynlp:/var/assets --name pynlp miorgash/pynlp:latest
$ 
$ # jupyter setup
$ python3.7 -c 'from notebook.auth import passwd;print(passwd())'
$ # $home/.jupyter/jupyter_notebook_config.py
$ # c.NotebookApp.password = '$hashed_password'
$ # c.NotebookApp.notebook_dir = '/var/assets'
$
$ # ssh tunnel
$ ssh -f -NL 9999:localhost:8888 ubuntu@ubuntu
$ # vim through ssh
$ vim scp://${username}@${hostname}/${path_relative_from_home}
$ vim scp://${username}@${hostname}//${path_abs}
```

