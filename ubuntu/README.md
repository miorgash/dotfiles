# How to setup Ubuntu 18.04

```bash
$ sudo apt update && sudo apt upgrade && apt install python3.7
$ sudo python3.7 -m pip install -U pip
$ python3.7 -m venv ~/.venv/${venv\_name}
$ source ~/.venv/${venv\_name}/bin/activate
${venv\_name} $ # install all packages
${venv\_name} $ pip install -r requirements.txt
${venv\_name} $ 
${venv\_name} $ # security setting
${venv\_name} $ python3.7 -c 'from notebook.auth import passwd;print(passwd())
${venv\_name} $ jupyter notebook --generate config
${venv\_name} $ vim ~/.jupyter/jupyter_notebook_config.py
${venv\_name} $ ### c.NotebookApp.notebook_dir = '/home/ubuntu/'
${venv\_name} $ ### c.NotebookApp.password = '${YOUR_ENCRYPTED_PASSWORD}'
${venv\_name} $ 
${venv\_name} $ # jupyter kernel setting
${venv\_name} $ ipython kernel install --user --name=${name} --display-name=${display\_name}
${venv\_name} $ 
${venv\_name} $ # visual setting
${venv\_name} $ ln -s /home/ubuntu/dotfiles-ubuntu/custom.css /home/ubuntu/.jupyter/custom.css
${venv\_name} $ 
${venv\_name} $ deactivate
$ # crontab
$ crontab -l
$ crontab -e
$ # @reboot tmux new-session -d -s notebook 'jupyter notebook --no-browser'
$ 
```

# How to use
## ubuntu 
start instance

## local
``bash
$ ssh -i ~/.ssh/${YOUR_KEY} -f -NL ${YOUR_PORT}:localhost:8888 ${USER_NAME}@${INSTANCE_IP}


---
# References
- jupyter in ec2
  - https://qiita.com/t12968yy/items/b6c14f48638060916824
- ssh tunnel
  - https://www.datasciencebytes.com/bytes/2015/12/18/using-jupyter-notebooks-securely-on-remote-linux-machines/
  - https://qiita.com/mechamogera/items/b1bb9130273deb9426f5
- execute tmux as a daemon
  - 
