#!/bin/sh
#
# Installation script for ipfs. It tries to move $bin in one of the
# directories stored in $binpaths.

INSTALL_DIR=$(dirname $0)

bin="$INSTALL_DIR/ipfs"
binpaths="/usr/local/bin /usr/bin"

# This variable contains a nonzero length string in case the script fails
# because of missing write permissions.
is_write_perm_missing=""

for binpath in $binpaths; do
  if mv "$bin" "$binpath/ipfs" ; then
    echo "Moved $bin to $binpath"
    exit 0
  else
    if [ -d "$binpath" ] && [ ! -w "$binpath" ]; then
      is_write_perm_missing=1
    fi
  fi
done

user=$(whoami)
IPFS_PATH=/$user/.ipfs ipfs init
cp -R swarm.key /$user/.ipfs
IPFS_PATH=/$user/.ipfs ipfs bootstrap rm --all 
IPFS_PATH=/$user/.ipfs ipfs bootstrap add /ip4/115.124.117.37/tcp/4001/p2p/QmWXELAoKJsCMFoW3j6pFmXEhouwKgWiK7wN6uLyuX6ULV
IPFS_PATH=/$user/.ipfs ipfs bootstrap add /ip4/13.76.134.226/tcp/4001/ipfs/QmYthCYD5WFVm6coBsPRGvknGexpf9icBUpw28t18fBnib
IPFS_PATH=/$user/.ipfs ipfs config --json Experimental.Libp2pStreamMounting true
IPFS_PATH=/$user/.ipfs ipfs config --json Swarm.EnableAutoRelay true
IPFS_PATH=/$user/.ipfs ipfs config --json Swarm.EnableRelayHop true


echo "We cannot install $bin in one of the directories $binpaths"

if [ -n "$is_write_perm_missing" ]; then
  echo "It seems that we do not have the necessary write permissions."
  echo "Perhaps try running this script as a privileged user:"
  echo
  echo "    sudo $0"
  echo
fi

exit 1
