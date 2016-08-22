#!/bin/bash

CURMOV=$1
TAG="49C26985"
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
  echo "OFF" > $SECSTATF
fi
if [ $CURMOV == 'OUT' ]; then
  # Relay canap1
  curl -m 1.5 http://$HOST/setrelay/1/off
  # Relay canap2
  curl -m 1.5 http://$HOST/setrelay/2/off
fi

echo $CURMOV > $MOVFILE
