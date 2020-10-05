# How to setup Mac OS X

## 1. Package management

Homebrew

```
ln -sf $HOME/assets/env/hosts/dotfiles/.Brewfile $HOME/.Brewfile
brew bundle --global
```

## 2. Accessibilities
1. Karabiner

## 3. Clone this repo

```console
git clone https://github.com/miorgash/env.git ~/assets/env
```

## 4. Terminal

iTerm2

```
# some commands for installation
```

## 3. zsh
1. install zsh

    ```console
    brew install zsh
    ```

1. prezto
    1. [README](https://github.com/sorin-ionescu/prezto) にしたがってインストール＆ログインシェルに設定: 
    1. [.zshrc で prompt 設定を保存](https://qiita.com/notakaos/items/89057f2119655ab9f920)（prompt $name だと保存されない）: 

## 4. tmux
```console
ln -sf ${HOME}/env/hosts/dotfiles/.tmux.conf ${HOME}/.tmux.conf
```

## 5. nvim

1. directories etc.

    ```console
    mkdir ~/.config
    ```

1. dotfiles

    ```console
    echo '\n# nvim settings' >> ~/.zshrc
    echo 'export XDG_CONFIG_HOME="${HOME}/.config"' >> ~/.zshrc
    echo '\n# alias' >> ~/.zshrc
    echo 'alias vim=nvim' >> ~/.zshrc
    exit # 設定反映のため再度ログイン
    env # XGD_CONFIG_HOME 設定を確認
    ln -sf ${HOME}/env/hosts/dotfiles/init.vim ${XDG_CONFIG_HOME}/nvim/init.vim
    vim
    # Confirm neovim get started
    ```

1. colorscheme

    ```console
    mkdir -p ${XDG_CONFIG_HOME}/nvim/colors
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

## 8. Docker & docker-compose

- install using Homebrew

# 9. Option
## 9.1. Apps
1. DropBox
1. Coccinellida
1. Slack
1. Mendeley

## 9.2 Settings
1. create ssh key & config setting

---
References


