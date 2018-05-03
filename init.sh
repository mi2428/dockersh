#!/bin/bash

echoblue(){ echo -e "\033[0;34m$@\033[0m"; }

echoblue "New container ID: $(hostname)"

exec $@
