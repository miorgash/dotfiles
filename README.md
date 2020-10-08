# Design
```
- dotfiles
    - docs
    - scripts
    - dotfiles
```

# 2. Use cases, requirements, motivations
## 2.1. Host machine

- zsh, nvim, tmux をインストールする（コンテナにはこれらを載せない）
- dotfiles 配下の共通設定を各ホストで用いる

### 2.1.1. Ubuntu

- 基本的にクラウドの Ubuntu を使う

### 2.1.2. OSX

- オフラインの時に使う（キャンプの時とか）

## 2.2. Container

- Python 環境を管理する

### 2.2.1. py

- jupyter でのレポート作成（深層学習関連以外の汎用的なライブラリを汎用化するため＆見た目の設定を汎用化するため）
- Python パッケージはカーネルで管理する．（コンテナを作るのはオーバーヘッドが大きいので忌避）
- コンテナ化する理由
    - 可搬性

### 2.2.2. tf*

- GPU を用いた TensorFlow コード実行用のイメージ
- ホストに GPU が載っていれば利用可能
- py と独立でコンテナ化する理由
    - 前処理をする環境で GPU を動かす必要が無い，かつ動かしてたら無駄
    - GPU 環境まわりのトレンドは流動的なため
    - 深層学習系のライブラリはライブラリごとに動作要件が異なることが考えられるため

    ```console
    sudo docker run --rm -v $PWD:/tmp --gpus all -it miorgash/tf${n} python3.7 ./${script}
    ```

# 3. How to set-up
## 3.1. Host machine

Look `hosts > $os > README.md`

## 3.2. Container

Look `container > $image > README.md

---
# 考え方

- 次の作業にはそれぞれ適当なコンテナを用いる

# Initialize procedure

- ホストマシンは適宜最新の手順を参照する
- dotfiles でアプリケーションごとの設定ファイルを管理する．ホストマシン／コンテナ問わず同ディレクトリ配下の設定ファイルを適宜利用する．

## Hosting machine

`docs` 以下各 OS の手順を参照．

## Docker applications
### py
#### build image

```
$ sudo docker build -t miorgash/py:latest .
```

#### Run

Using `docker run` command:

```
$ # for ubuntu, osx and other linux
$ sudo docker run -itd -p 8888:8888 -v ~/assets:/var/assets --restart=always --name py miorgash/py:latest
$ # With data container
$ sudo docker run -itd -p 8888:8888 -v ~/assets:/var/assets --volumes-from fever-common --restart=always --name py miorgash/py:latest
```
! Using GPUs via docker-compose is not stable.

#### Initialize

Login to container:

```
$ sudo docker exec -it py /bin/bash
```

Get hashed password:

```
# python3.7 -c 'from notebook.auth import passwd;print(passwd())'
```

Set config:

```~/.jupyter/jupyter_notebook_config.py
c.NotebookApp.password = '$hashed_password'
c.NotebookApp.notebook_dir = '/var/assets'
```

Logout:

```
# exit
```

Restart

```
sudo docker restart py
```


#### How to use notebook
(Client operation)
1. setup ssh tunnel.

    ```console
    ssh -i ~/.ssh/${YOUR_KEY} -f -NL ${YOUR_PORT}:localhost:8888 ${USER_NAME}@${INSTANCE_IP}
    ```

1. open browser and access `http://localhost:${YOUR_PORT}`, type the password.

### tf1/2


## vim through ssh

```
vim scp://${username}@${hostname}/${path_relative_from_home}
vim scp://${username}@${hostname}//${path_abs}
```

### mecab dict location
```
$ # container 内のものは改めて確認．
$ ls /usr/lib/x86_64-linux-gnu/mecab/dic/mecab-unidic-neologd
```

# References
- jupyter in ec2
  - https://qiita.com/t12968yy/items/b6c14f48638060916824
- ssh tunnel
  - https://www.datasciencebytes.com/bytes/2015/12/18/using-jupyter-notebooks-securely-on-remote-linux-machines/
  - https://qiita.com/mechamogera/items/b1bb9130273deb9426f5
- execute tmux as a daemon
  - coming soon

- MeCab on Ubuntu 18.04
  - https://qiita.com/SUZUKI_Masaya/items/685000d569452585210c

---
# bak

## 1. 概観
分析開発のエコシステムは下記構成要素からなる：

- クラウド環境
- ローカル環境
- Python 仮想環境（クラウド・ローカル）
- コンテナ環境

クラウド環境・ローカル環境それぞれで，Python 仮想環境・コンテナ環境を利用する．

## 2. クラウド・ローカル共通の基本方針
### １ホストにつき１つの Python インタプリタ
一つのホストマシンの責務は一つであるべきであり，それゆえ Python のバージョンは責務に最適なもの一つであればよい．よって pyenv/conda 等を用いて，１ホストで複数のインタプリタを切替えることはしない．

### １ホストにつき複数の仮想環境
環境構築に関わる試行錯誤を効率よく行い，かつ環境をクリーンに保つため，venv, virtualenv などで仮想環境を構築し用いる．

## 3. ローカル環境
ローカルの環境の用途は３つ

1. 小規模データの処理
1. Python モジュールの試験利用
1. サービスの開発

### 小規模データの処理
virtualenv/venv により構築した仮想環境で，小規模なデータの処理を行う．

### Python モジュールの試験利用
virtualenv/venv により仮想環境を作成し，利用を試す．

### サービスの開発
Docker コンテナ上に必要なモジュールを梱包し開発する．完了後クラウドにてテスト・運用開始する．

## 4. クラウド環境の利用方針
クラウド環境の用途は３つ

1. 大規模データの処理
1. Python 新バージョンの試験利用
1. サービスの運用

### 大規模データの処理
virtualenv/venv により構築した仮想環境で，ローカルでは扱えない大規模データの処理を行う．

### Python 新バージョンの試験利用
クラウド等の環境で試しに利用してみる．
支障がなければ brew/apt/yum などを用いてローカル環境に導入する．

### サービスの運用
ローカルで開発した Docker コンテナをデプロイし，テスト・運用する．
