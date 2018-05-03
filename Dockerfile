FROM ubuntu:latest
MAINTAINER mi2428

ARG USER=all
ARG HOME=/home/all
ENV LANG=ja_JP.UTF-8

RUN apt-get update && \
    apt-get install -y \
        coreutils moreutils curl wget git openssh-client rdesktop \
        language-pack-ja-base language-pack-ja \
        zsh tmux screen vim
RUN locale-gen ja_JP.UTF-8
RUN useradd -m -d $HOME -s /bin/zsh $USER

ADD init.sh /sbin/init.sh
RUN chmod +x /sbin/init.sh

USER $USER
WORKDIR $HOME

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git .oh-my-zsh/custom/plugins/zsh-syntax-highlighting
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="af-magic"/g' .zshrc
RUN sed -i 's/plugins=(/plugins=(zsh-syntax-highlighting/g' .zshrc

ENTRYPOINT ["/sbin/init.sh"]
CMD ["/bin/zsh"]
