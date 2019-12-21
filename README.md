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
    |    \_ $CONFIG
     \_ ...
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
|\_ pip@python3
|    \_ pipx
|       |\_ jupyter
|        \_ awscli
|\_ curl
|    \_ poetry
 \_ pyenv
    |\_ Python3.7.5
    |   |\_ $modules
    |    \_ ...
     \_ Python3.8.0
```

# Caution
- path: pipx > usr/local/bin

# Idea
- Python Interpreter のバージョン管理は行わない．pyenv を用いることで可能だが，シンプルさにかけるため．最新の 3 系のみ保持する．（3.8 別バージョン使いたくなったら docker とか使う）
- venv で仮想環境を管理する．公式で外部アプリケーションとの連携が容易なため．
