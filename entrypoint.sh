#!/bin/bash

USER=${LOCAL_USER:-all}
USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}

echoblue(){ echo -e "\033[0;34m$@\033[0m"; }

usermod -l $USER deleteme
groupadd -g $GROUP_ID $USER || groupmod -g $GROUP_ID $USER
usermod -u $USER_ID -g $GROUP_ID $USER
chown -R $USER_ID:$GROUP_ID /home/deleteme
cd /home/deleteme

echoblue "New container: $(hostname)"
echoblue "Starting with local user '$USER' ($USER_ID:$GROUP_ID)"

exec /usr/sbin/gosu $USER "$@"
