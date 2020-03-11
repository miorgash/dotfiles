## How to setup Ubuntu 18.04

- GPU
- Docker
- nvim
- tmux

### GPU
https://qiita.com/hoto17296/items/80ba9c23416991757ab7

```bash
$ sudo apt update
$ sudo apt install -y nvidia-384
$ sudo reboot
```

---
bak
```bash
$ # python
$ sudo apt update && sudo apt upgrade && sudo apt install python3.7 && sudo apt install python3.7-dev && sudo apt install python3-pip && sudo apt install python3.7-venv
$ python3.7 -m pip install -U pip
$ python3.7 -m venv ~/.venv/${VENV_NAME}
$ 
$ # MeCab
$ sudo apt install mecab libmecab-dev mecab-ipadic-utf8
$ sudo apt install unidic-mecab
$ sudo update-alternatives --config mecab-dictionary
$ sudo apt install git make curl xz-utils file unzip
$ cd /tmp
$ git clone --depth 1 https://github.com/neologd/mecab-unidic-neologd
$ cd mecab-unidic-neologd
$ ./bin/install-mecab-unidic-neologd -n
$ 
$ # venv
$ source ~/.venv/${VENV_NAME}/bin/activate
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

## How to use
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
