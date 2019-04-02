FROM ubuntu:latest
LABEL maintainer "mi2428 <mi2428782020@gmail.com>"

ARG USER=deleteme
ARG HOME=/home/deleteme

ENV LANG=ja_JP.UTF-8

RUN sed -i -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y \
        coreutils moreutils curl wget git openssh-client rdesktop \
        language-pack-ja-base language-pack-ja \
        zsh tmux screen vim neovim gosu
RUN locale-gen ja_JP.UTF-8
RUN useradd -m -d $HOME -s /bin/zsh $USER

USER $USER
WORKDIR $HOME

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git .oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN sed -i 's/plugins=(/plugins=(zsh-syntax-highlighting/g' .zshrc
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="af-magic"/g' .zshrc

USER root
WORKDIR /

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/zsh"]
