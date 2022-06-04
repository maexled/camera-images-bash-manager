#!/bin/bash

DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/config.cfg

if [ "$samba_user" != "" ] && [ "$samba_uid" != "" ]; then
    useradd $samba_user -u $samba_uid
    echo "Created $samba_user with uid $samba_uid"
fi

bash move.sh