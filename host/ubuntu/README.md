# How to setup Ubuntu 18.04

## os
1. setpassword

    ```console
    sudo su
    passwd ubuntu
    exit
    ```

1. create ssh key

    ```console
    ssh-keygen
    ```

1. apt

    ```console
    sudo apt update & sudo apt upgrade
    ```

1. clone this repo

    ```console
    git clone https://github.com/miorgash/env.git ~/env
    ```

## zsh
1. install zsh

    ```console
    sudo apt install zsh -y
    ```

1. prezto
    1. [README](https://github.com/sorin-ionescu/prezto) にしたがってインストール＆ログインシェルに設定: 
    1. [.zshrc で prompt 設定を保存](https://qiita.com/notakaos/items/89057f2119655ab9f920)（prompt $name だと保存されない）: 


## tmux
```console
ln -sf ${HOME}/env/dotfiles/.tmux.conf ${HOME}/.tmux.conf
```

## nvim

1. install

    ```console
    mkdir ~/.config
    sudo apt install neovim -y
    ```

1. dotfiles

    ```console
    echo '\n# nvim settings' >> ~/.zshrc
    echo 'export XDG_CONFIG_HOME="${HOME}/.config"' >> ~/.zshrc
    echo '\n# alias' >> ~/.zshrc
    echo 'alias vim=nvim' >> ~/.zshrc
    exit # 設定反映のため再度ログイン
    env # XGD_CONFIG_HOME 設定を確認
    ```

1. colorscheme

    ```console
    mkdir -p ${XDG_CONFIG_HOME}/nvim/colors
    ln -s ${HOME}/env/dotfiles/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
    git clone https://github.com/cocopon/iceberg.vim/ ${HOME}/iceberg.vim
    cp ${HOME}/iceberg.vim/colors/iceberg.vim ${XDG_CONFIG_HOME}/nvim/colors/iceberg.vim
    
    ```

1. vim-plug
   ```console
   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   # :PlugInstall
   ```

## Docker & docker-compose
- Docker: https://docs.docker.com/install/linux/docker-ce/ubuntu/#prerequisites
- docker-compose: https://docs.docker.com/compose/install/#install-compose

## for Samba
```console
$ sudo apt install cifs-utils -y
```

## GPU

- [AWS](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/install-nvidia-driver.html)
- [NVIDIA](https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html)

### Essential pkgs

- nvcc
- dotfiles

### Assessment
1. Choose
    - Tensorflow version([Tensorflow - テスト済みのビルド設定](https://www.tensorflow.org/install/source#linux))
        - 2.1.0 -> cuDNN 7.6, CUDA 10.1
        - 1.14.0 -> cuDNN 7.4, CUDA 10.0
    - AWS EC2 instance type([AWS - 推奨 GPU インスタンス](https://docs.aws.amazon.com/ja_jp/dlami/latest/devguide/gpu.html))
        - p3.* -> NVIDIA Tesla V100 GPU
        - p2.* -> NVIDIA Tesla K80 GPU
1. Look up and download proper driver version[NVIDIA ドライバダウンロード](https://www.nvidia.co.jp/Download/index.aspx?lang=jp)
    - Tesla V100, CUDA 10.1 -> 418.126.03
    - Tesla K80, CUDA 10.0 -> 410.129
1. Determine composition
    - Tensorflow: 1.14.0
    - Tesla K80(p2.*)
    - CUDA Toolkit: 10.0
    - NVIDIA Driver: 410.129

### Set up conponents

Check, uninstall current version if exists, and install required version

1. GPU
    1. check

        ```console
        lspci | grep -i nvidia
        # 00:1e.0 3D controller: NVIDIA Corporation GK210GL [Tesla K80] (rev a1)
        ```
    
1. Driver
    1. check([Qiita - Ubuntu 16.04 をインストールして...](https://qiita.com/konzo_/items/3e2d1d7480f7ef632603))

        ```console
        # NVIDIA Drivers
        cat /proc/driver/nvidia/version
        # cat: /proc/driver/nvidia/version: No such file or directory
    
        # nouveau(a community driver)
        lsmod | grep -i nouveau
        # returns nothing; if exists: [Qiita - Ubuntu 16.04 をインストールして...](https://qiita.com/konzo_/items/3e2d1d7480f7ef632603)
        ```

    1. Install([NVIDIA Driver Installation Quickstart Guide - 2.1. Ubuntu LTS](https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html#ubuntu-lts))

        ```console
        sudo apt-get install linux-headers-$(uname -r)
        distribution=$(. /etc/os-release;echo $ID$VERSION_ID | sed -e 's/\.//g')
        wget https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/cuda-$distribution.pin
        sudo mv cuda-$distribution.pin /etc/apt/preferences.d/cuda-repository-pin-600
        sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64/7fa2af80.pub
        echo "deb http://developer.download.nvidia.com/compute/cuda/repos/$distribution/x86_64 /" | sudo tee /etc/apt/sources.list.d/cuda.list
        sudo apt-get update
        sudo apt-get -y install nvidia-driver-410 # doesn't care for minor version
        # sudo apt-get -y install cuda-drivers # newest anyway
        ```
    
1. CUDA (=CUDA Toolkit)

    ```console
    ```
    
1. cuDNN

    ```console
    ```

```
# https://qiita.com/ttsubo/items/c97173e1f04db3cbaeda

# /etc/modprobe.d/blacklost-nouveau.conf
# blacklist nouveau
# options nouveau modeset=0
sudo update-initramfs -u # initramfs 再構築
sudo reboot
# install nvidia driver
sudo apt update && sudo apt install nvidia-driver-430 -y && sudo apt install nvidia-cuda-toolkit -y
# nvidia driver インストール確認
lspci -vv|grep -i nvidia
# nvidia-smi コマンド動作確認
nvidia-smi
# python からの利用確認；container 立ち上げ後，notebool/python で以下コードを実行
# https://thr3a.hatenablog.com/entry/20180113/1515820265
# from tensorflow.python.client import device_lib
# device_lib.list_local_devices()
```

---
Other references

- [GPU 関連でよくやる操作](https://qiita.com/sao_rio/items/4ef5604d685f04669f74)

---
bak
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

