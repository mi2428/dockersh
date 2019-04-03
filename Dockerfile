FROM ubuntu:latest
LABEL maintainer "mi2428 <mi2428782020@gmail.com>"

ARG USER=deleteme
ARG HOME=/home/deleteme

ENV LANG=ja_JP.UTF-8

RUN sed -i -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
        coreutils moreutils curl wget git openssh-client rdesktop telnet \
        language-pack-ja-base language-pack-ja \
        bash zsh csh fish tmux screen vim neovim gosu && \
    apt-get clean && \
    rm -rf /var/lib/apt/list/*
RUN locale-gen ja_JP.UTF-8
RUN useradd -m -d $HOME -s /usr/bin/fish $USER

USER $USER
WORKDIR $HOME

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git .oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN sed -i -e 's/^plugins=(.*)$/plugins=(zsh-syntax-highlighting)/' .zshrc
RUN sed -i -e 's/^ZSH_THEME=".*"$/ZSH_THEME="robbyrussell"/' .zshrc

USER root
WORKDIR /

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/usr/bin/fish"]
