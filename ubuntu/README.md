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
$ sudo apt update
$ sudo apt upgrade
$ 
$ # zsh
$ sudo apt install zsh
$ 
$ # prezto
$ # 1. オフィシャル README にしたがってインストール＆ログインシェルに設定: https://github.com/sorin-ionescu/prezto
$ # 2. .zshrc で prompt 設定を保存（prompt $name だと保存されない）: https://qiita.com/notakaos/items/89057f2119655ab9f920
$ 
$ # tmux
$ ln -sf ${HOME}/env/dotfiles/.tmux.conf ${HOME}/.tmux.conf
$ 
$ # nvim
$ sudo apt install neovim
$ mkdir ~/.config
$ # zshrc を設定（add-neovim-setting-to-zshrc.sh）
$ exit
$ # 再度 login
$ # colorscheme, vim-plug を設定（setup-neovim.sh; make sure that you have set XGD_CONFIG_HOME）
$ # :VimplugInstall
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
$ - AWS 公式イメージを利用
$ - 非 GPU インスタンスとの使い分け方針は検討
$ 
$ # python
$ sudo apt update -y && sudo apt upgrade -y && sudo apt install python3.7 -y && sudo apt install python3.7-dev -y && sudo apt install python3-pip -y && sudo apt install python3.7-venv -y
$ python3.7 -m pip install -U pip
$ python3.7 -m venv ~/.venv/${VENV_NAME}
$ # エイリアス等を設定（ubuntu/add-python-setting-to-zshrc.sh）
$ 
$ # MeCab
$ sudo apt install mecab libmecab-dev mecab-ipadic-utf8 -y
$ sudo apt install unidic-mecab -y
$ sudo update-alternatives --config mecab-dictionary
$ sudo apt install git make curl xz-utils file unzip -y
$ git clone --depth 1 https://github.com/neologd/mecab-unidic-neologd /tmp/mecab-unidic-neologd
$ cd /tmp/mecab-unidic-neologd
$ ./bin/install-mecab-unidic-neologd -n -y
$ 
$ # venv
$ source ~/.venv/${VENV_NAME}/bin/activate
${VENV_NAME} $ # required by mecab-python3
${VENV_NAME} $ sudo apt install swig
${VENV_NAME} $ # required by some packages
${VENV_NAME} $ pip install wheel
${VENV_NAME} $ pip install -U setuptools
${VENV_NAME} $ # install all packages
${VENV_NAME} $ pip install -r requirements.txt
${VENV_NAME} $ 
${VENV_NAME} $ # nessesary packages
${VENV_NAME} $ pip install jupyter ipython mecab-python3
${VENV_NAME} $ 
${VENV_NAME} $ # security setting
${VENV_NAME} $ python3.7 -c 'from notebook.auth import passwd;print(passwd())'
${VENV_NAME} $ ### get ${YOUR_ENCRYPTED_PASSWORD}
${VENV_NAME} $ jupyter notebook --generate config
${VENV_NAME} $ vim ~/.jupyter/jupyter_notebook_config.py
${VENV_NAME} $ ### c.NotebookApp.notebook_dir = '/home/ubuntu/'
${VENV_NAME} $ ### c.NotebookApp.password = '${YOUR_ENCRYPTED_PASSWORD}'
${VENV_NAME} $ 
${VENV_NAME} $ # jupyter kernel setting
${VENV_NAME} $ ipython kernel install --user --name=${NAME} --display-name=${DISPLAY_NAME}
${VENV_NAME} $ 
${VENV_NAME} $ # visual setting
${VENV_NAME} $ mkdir ~/.jupyter/custom
${VENV_NAME} $ ln -s /home/ubuntu/env/dotfiles/custom.css /home/ubuntu/.jupyter/custom/custom.css
${VENV_NAME} $ 
${VENV_NAME} $ deactivate
```

## Setup

```bash
$ # jupyter setup
$ python3.7 -c 'from notebook.auth import passwd;print(passwd())'
$ # container
$ sudo docker run -itd -p 9999:8888 -v /home/ubuntu/:/root/ --name pynlp miorgash/pynlp:latest
$ # ssh tunnel
$ ssh -f -NL 9999:localhost:8888 ubuntu@ubuntu
$ # vim through ssh
$ vim scp://${username}@${hostname}/${path_relative_from_home}
$ vim scp://${username}@${hostname}//${path_abs}
```

## mecab dict location
```
$ ls /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-unidic-neologd
```

## How to use notebook
### host
start instance and execute:

```
$ # TODO: move this to @reboot
$ source ~/.venv/${VENV_NAME}/bin/activate
$ tmux new-session -d -s notebook 'jupyter notebook --no-browser'
```

### client
1. setup ssh tunnel.
```bash
$ ssh -i ~/.ssh/${YOUR_KEY} -f -NL ${YOUR_PORT}:localhost:8888 ${USER_NAME}@${INSTANCE_IP}
```
1. open browser and access `http://localhost:${YOUR_PORT}`, type the password.


## References
- jupyter in ec2
  - https://qiita.com/t12968yy/items/b6c14f48638060916824
- ssh tunnel
  - https://www.datasciencebytes.com/bytes/2015/12/18/using-jupyter-notebooks-securely-on-remote-linux-machines/
  - https://qiita.com/mechamogera/items/b1bb9130273deb9426f5
- execute tmux as a daemon
  - coming soon

- MeCab on Ubuntu 18.04
  - https://qiita.com/SUZUKI_Masaya/items/685000d569452585210c
