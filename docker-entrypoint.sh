DIR="$(cd "$(dirname "$0")" && pwd)"

source $DIR/config.cfg

if [ "$samba_user" != "" ] && [ "$samba_uid" != "" ];
then
    useradd $samba_user -u $samba_uid
fi