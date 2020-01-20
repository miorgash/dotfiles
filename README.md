# ツール依存関係

```
brew
|\_ zsh
|\_ git
|    \_ prezto
 \_ python3
    |\_ venv
    |    \_ pip
    |        \_ jupyter
     \_ pip
         \_ pipx
            |\_ jupyter
             \_ awscli
```

# 検討の上忌避した技術
## pyenv
- Docker で済む
- Docker で済むのに生の Python をラップするものの仕様を理解する手間がもったいない

## pipenv
- 開発が止まっている．

## poetry
- よさそうだが分析目的にはオーバースペック．

## pipx
- 仕様上 PATH において常に優先される必要があるが，他の venv への切替時はそちらが優先されてしまう．
- とはいえ notebook の設定を共通化するために必要？
- 壊れてるのをとりあえず直したい 2020.01.21.

# パッケージ管理
## pipx
Python 製非 Python モジュールのアプリケーションを管理．

## brew
非 Python 製アプリケーションを管理．

## git
pipx, brew に無いものを管理．

## curl, wget ほか
pipx, brew, git に無いものを管理．

## pip3@python3
pipx を管理．

## pip@venv
Python モジュールを管理．


# インタプリタ・ipython カーネル
## brew
Python3 系を 1 つだけインストールする．
インタプリタはこの Python3 のみ．
mac 標準の Python2 はシステム利用．  
ほかの Python3 は必要に応じて Docker やクラウドで利用．

## venv
Python3 系の venv で仮想環境をつくる．  
```sh
$ python3 -m venv ~/.venv/${venv_name}
```

## ipython
```sh
$ # venv_name と kernel_name は一緒にしておくとわかりやすい
$ source ~/.venv/${venv_name}/activate
$ ipython kernel install --user --name=${kernel_name} --display-name=${kernel_name}
```


# 開発環境
## neovim
- brew でインストールする．

## jupyter
- jupyter は Python 製非 Python モジュールのアプリケーションだが，全ての venv 環境で pip でインストールする．venv 環境に ipython 系モジュール（matplotlib etc）をインストールすると入ってしまうため．
- `jupyter notebook` 実行時は Python3 または venv の jupyter が実行される．
- 前述 ipython コマンドで追加したカーネルを NoteBook 作成時・作成後に選択できる．


- jupyter のインストール先に関わらず以下の設定が適用される；venv の jupyter 実行時でも以下挙動は変わらない
  - ~/.jupyter/custom/custom.css を参照する．
  - nbextenstion は？

---
bak
# What for
- アプリケーションのインストールとセットアップ

# Rules
- アプリケーションごとにインストールとセットアップをまとめて実行可能な状態にする
- 依存関係はどこかで定義
- パッケージ・環境管理用アプリケーション
  - homebrew
  - git
  - pipx
  - pyenv
  - pip
- 分析・開発用アプリケーション
  - zsh
  - tmux
  - neovim
  - Python
  - jupyter
  - mecab
  - neologd
- 共通シェル
  - install.sh: パッケージ・環境管理用アプリケーションを用いた，パッケージ・インタプリタのインストール
  - configure.sh: 分析・開発用アプリケーションの設定

# Structure
```zsh
.
 \_ $OS_DISTRIB
    |\_ brew
    |    \_ install.sh
    |\_ git
    |   |\_ setup.sh
    |    \_ $CONFIG
    |\_ $APP
    |   |\_ setup.sh
    |    \_ $CONFIG \_ ...
```

# Installation Dependency
1. apps installation
  1. install brew
  2. install apps by brew (including git, curl, pip@python3, pyenv)
  3. install apps by git (including prezto)
  4. install apps by pip@python3 (only pipx)
  5. install apps by pipx(including jupyter, awscli)
  5. install apps by curl (including poetry)
2. shell configuration
  1. install zsh-dotfiles by prezto
  2. configure zsh-dotfiles
3. apps configuration
  1. tmux
  2. neovim
  3. shared python
    1. configure jupyter notebook
  3. project python
    1. install python by pyenv
    2. create virtual-python-environment by venv or poetry
    3. install modules by pip

```
brew
|\_ git
|   |\_ $tools
|    \_ prezto
 \_ pip@python3
     \_ pipx
        |\_ jupyter
         \_ awscli
```

# Caution
- path: pipx > usr/local/bin

# Idea
- Python Interpreter のバージョン管理は行わない．pyenv を用いることで可能だが，シンプルさにかけるため．最新の 3 系のみ保持する．（3.8 別バージョン使いたくなったら docker とか使う）
- venv で仮想環境を管理する．公式で外部アプリケーションとの連携が容易なため．
