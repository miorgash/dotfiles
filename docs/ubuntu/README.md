# How to setup Ubuntu 18.04

## 1. os
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
    mkdir ~/assets
    git clone https://github.com/miorgash/env.git ~/assets/env
    ```

## 2. zsh
1. install zsh

    ```console
    sudo apt install zsh -y
    ```

1. prezto
    1. [README](https://github.com/sorin-ionescu/prezto) にしたがってインストール＆ログインシェルに設定: 
    1. [.zshrc で prompt 設定を保存](https://qiita.com/notakaos/items/89057f2119655ab9f920)（prompt $name だと保存されない）: 

## 3. tmux
```console
ln -sf ${PATH_TO}/dotfiles/.tmux.conf $HOME/.tmux.conf
```

## 4. nvim

1. install

    ```console
    mkdir ~/.config
    sudo apt install neovim -y
    ```

1. dotfiles

    ```console
    echo '\n# nvim settings' >> ~/.zshrc
    echo 'export XDG_CONFIG_HOME="${HOME}/.config"' >> ~/.zshrc
    echo 'export NVIM_PYTHON_LOG_FILE="${HOME}/.config/nvim/log"' >> ~/.zshrc
    echo '\n# alias' >> ~/.zshrc
    echo 'alias vim=nvim' >> ~/.zshrc
    exit # 設定反映のため再度ログイン
    env # XGD_CONFIG_HOME 設定を確認
    ```

1. colorscheme

    ```console
    mkdir -p ${XDG_CONFIG_HOME}/nvim/colors
    ln -sf ${HOME}/assets/env/hosts/dotfiles/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
    git clone https://github.com/cocopon/iceberg.vim/ ${HOME}/iceberg.vim
    cp ${HOME}/iceberg.vim/colors/iceberg.vim ${XDG_CONFIG_HOME}/nvim/colors/iceberg.vim
    
    ```

1. vim-plug
   ```console
   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   vim
   # :PlugInstall
   ```

## 5. GPU

Set up for Tensorflow ver.1.14.0.  
(Just in case of a special circumstances; use containers basically)

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
    
1. NVIDIA Driver(including CUDA)
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

        - restart
        - caution
            - 上記手順後に `sudo apt-get -y install cuda-10-0` 実行するとなぜか Driver/CUDA ともにバージョンが上がった．
            - 何らかの事情で `apt-get remove` 実行したあとは `apt-get autoremove` する．

    1. Check

        ```console
        nvidia-smi
        # Check 'Driver Version' and 'CUDA Version' in the header
        cat /proc/driver/nvidia/version
        # NVRM version: NVIDIA UNIX x86_64 Kernel Module  410.129  Sun Jul 21 07:02:47 CDT 2019
        # GCC version:  gcc version 7.5.0 (Ubuntu 7.5.0-3ubuntu1~18.04)
        ```

    1. Post-installation([CUDA Toolkit Documentation - Post-installation Actions](https://docs.nvidia.com/cuda/archive/10.0/cuda-installation-guide-linux/index.html#post-installation-actions))

        ```.zshrc
        export PATH=/usr/local/cuda-10.0/bin${PATH:+:${PATH}}
        export LD_LIBRARY_PATH=/usr/local/cuda-10.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
        ```
    
1. CUDA Toolkit

    1. Pre-check

        ```console
        nvcc -V
        ```

    1. install
        ```console
        sudo apt-get install -y cuda-toolkit-10-0
        ```
    
    1. Check installed version

        ```console
        nvcc -V
        ```

1. cuDNN

    1. Pre-check
    
        ```console
        sudo apt list --installed | grep cudnn
        ```

    1. Download required packages from [NVIDIA Developer - cuDNN Archive](https://developer.nvidia.com/rdp/cudnn-archive#a-collapse742-10) 
        - cuDNN Runtime Library for Ubuntu18.04 (Deb)
        - cuDNN Developer Library for Ubuntu18.04 (Deb)
        - cuDNN Code Samples and User Guide for Ubuntu18.04 (Deb)
    1. Move files to server in arbitrary way
    1. Install([Qiita - Docker で，GPU 対応なコンテナ環境を整備する](https://qiita.com/ttsubo/items/c97173e1f04db3cbaeda#%EF%B8%8E-cudnn%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB))
    
        ```console
        # error occures with other order
        sudo apt install -y ./libcudnn7_7.4.2.24-1+cuda10.0_amd64.deb
        sudo apt install -y ./libcudnn7-dev_7.4.2.24-1+cuda10.0_amd64.deb
        sudo apt install -y ./libcudnn7-doc_7.4.2.24-1+cuda10.0_amd64.deb
        ```

    1. Check installed version
    
        ```console
        sudo apt list --installed | grep cudnn
        # libcudnn7/now 7.4.2.24-1+cuda10.0 amd64 [installed,local]
        # libcudnn7-dev/now 7.4.2.24-1+cuda10.0 amd64 [installed,local]
        # libcudnn7-doc/now 7.4.2.24-1+cuda10.0 amd64 [installed,local]
        ```

## 6. Docker & docker-compose
- Docker: https://docs.docker.com/install/linux/docker-ce/ubuntu/#prerequisites
- docker-compose: https://docs.docker.com/compose/install/#install-compose
- gpu settings
    - [NVIDIA/nvidia-docker](https://github.com/NVIDIA/nvidia-docker/tree/master#quickstart)
    - [blog mahoroi com - Docker コンテナでも GPU が使いたい](https://blog.mahoroi.com/posts/2019/12/docker-gpus-nvidia/)

## 7. for Samba
```console
$ sudo apt install cifs-utils -y
```

---
Other references

- [GPU 関連でよくやる操作](https://qiita.com/sao_rio/items/4ef5604d685f04669f74)
- [AWS](https://docs.aws.amazon.com/ja_jp/AWSEC2/latest/UserGuide/install-nvidia-driver.html)
- [NVIDIA](https://docs.nvidia.com/datacenter/tesla/tesla-installation-notes/index.html)

