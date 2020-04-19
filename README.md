# 構成
```
- docs
    - osx.md
    - ubuntu.md
- dotfiles
    - init.vim
    - .tmux.conf
    - requirements.txt
    - custom.css
- apps
    - ana
        - docker-compose.yml
- services
    - py
        - Dockerfile
```

# Initialize procedure

- ホストマシンは適宜最新の手順を参照する
- dotfiles でアプリケーションごとの設定ファイルを管理する．ホストマシン／コンテナ問わず同ディレクトリ配下の設定ファイルを適宜利用する．

## Hosting machine

`docs` 以下各 OS の手順を参照．

## Docker applications
### build image

```
$ sudo docker build -t miorgash/py:latest .
```

### Run

Using `docker run` command:

```
$ # container
$ sudo docker run -itd -p 8888:8888 -v /mnt/py:/var/assets --restart=always --name py miorgash/py:latest
$ sudo docker run -itd -p 8888:8888 -v /mnt/py:/var/assets --restart=always --name py --gpus all,driver=nvidia,capabilities=compute miorgash/py:latest
```
! Using GPUs via docker-compose is not stable.

### Exec

```
$ sudo docker exec -it py /bin/bash
```

### Get hashed passwd:

```
$ python3.7 -c 'from notebook.auth import passwd;print(passwd())'
```

3. Set config:

```~/.jupyter/jupyter_notebook_config.py
c.NotebookApp.password = '$hashed_password'
c.NotebookApp.notebook_dir = '/var/assets'
```



### How to use notebook
(Client operation)
1. setup ssh tunnel.
```bash
$ ssh -i ~/.ssh/${YOUR_KEY} -f -NL ${YOUR_PORT}:localhost:8888 ${USER_NAME}@${INSTANCE_IP}
```
1. open browser and access `http://localhost:${YOUR_PORT}`, type the password.

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
