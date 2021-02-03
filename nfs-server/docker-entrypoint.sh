#!/bin/sh
set -e
# if started without args, exec nfs services
if [ "$#" = "0" ]; then
    ls -la /nfsroot/
    ls -la /etc/exports
    ls -la /var/lib/nfs/
    printf "\nexportfs -a\n"
    exportfs -a
    printf "\nrpcbind\n"
    rpcbind
    printf "\nrpc.statd\n"
    rpc.statd
    printf "\nrpc.nfsd\n"
    rpc.nfsd
    printf "\nrpc.mountd\n"
    rpc.mountd

    rpcinfo -p
    showmount -e

    tail -f /dev/null
#    gosu "${UID}":"${GID}" ls -la /nfsroot/
#    gosu "${UID}":"${GID}" ls -la /etc/exports
#    gosu "${UID}":"${GID}" ls -la /var/lib/nfs/
#    # start the nfs service
#    printf "\nexportfs -a\n"
#    gosu "${UID}":"${GID}" exportfs -a
#    printf "\nrpcbind\n"
#    gosu "${UID}":"${GID}" rpcbind
#    printf "\nrpc.statd\n"
#    gosu "${UID}":"${GID}" rpc.statd
#    printf "\nrpc.nfsd\n"
#    gosu "${UID}":"${GID}" rpc.nfsd
#    printf "\nrpc.mountd\n"
#    gosu "${UID}":"${GID}" rpc.mountd
else
    # if an arg is given
    printf "\nINFO: $@\n\n"
    exec $@
fi
