# dockersh
SSHログイン先の環境をDockerコンテナに隔離する

## 使い方
```
git clone https://github.com/mi2428/dockersh /usr/local/src/dockersh
cd /usr/local/src/dockersh
make build
ln -sf /usr/local/src/dockersh/dockersh /usr/local/bin/dockersh
chsh [username] /usr/local/bin/dockersh
gpasswd -a [username] docker
```
