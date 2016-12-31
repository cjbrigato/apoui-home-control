#!/bin/bash

CURMOV=$1
TAG="A6C1C032"
HOST="control.maison.apoui.net"
MOVFILE="$TAG.lastmov"
SECSTATF="../security.status"

CDIR=`dirname $0`
cd $CDIR
LASTMOV=`cat $MOVFILE`

if [ $LASTMOV == "IN" ]; then
  CURMOV="OUT"
fi
if [ $LASTMOV == "OUT" ]; then
  CURMOV="IN"
fi

if [ $CURMOV == 'IN' ]; then
  # Relay canap1
  curl -m 1.5 http://$HOST/setrelay/1/on
  # Relay canap2
  curl -m 1.5 http://$HOST/setrelay/2/on
  # Relay meuble tv
  curl -m 1.5 http://$HOST/setrelay/5/on
  echo "OFF" > $SECSTATF
fi
if [ $CURMOV == 'OUT' ]; then
  # Relay canap1
  curl -m 1.5 http://$HOST/setrelay/1/off
  # Relay canap2
  curl -m 1.5 http://$HOST/setrelay/2/off
  # Relay chambre1
  curl -m 1.5 http://$HOST/setrelay/3/off
  # Relay chambre2
  curl -m 1.5 http://$HOST/setrelay/4/off
  # Relay meuble tv
  curl -m 1.5 http://$HOST/setrelay/5/off
  # Relay studio
  curl -m 1.5 http://$HOST/setrelay/6/off
  echo "OFF" > $SECSTATF
fi

echo $CURMOV > $MOVFILE
