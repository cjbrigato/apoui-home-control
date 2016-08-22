#!/bin/bash
CDIR=`dirname $0`
cd $CDIR

LOGFILE="../logs/doorlock.log"
SECURITY=""

function getsecstatus {
               SECURITY=`curl -m 1.5 "http://control.maison.apoui.net/rfid/security/status"`
}


getsecstatus
if [ "$SECURITY" == "OFF" ];then
  echo "-SECURITY- Security is OFF : Nothing to do" >> $LOGFILE
elif [ "$SECURITY" == "ON" ]; then
  echo "-SECURITY- SECURITY IS ON : PROCEDURE ENGAGED !" >> $LOGFILE
  echo "-SECURITY- Waiting 15 SEC FOR DEAC..." >> $LOGFILE
  sleep 15
  getsecstatus
  if [ "$SECURITY" == "OFF" ]; then
    echo "-SECURITY- Security DISENGAGED : Return to Normal" >> $LOGFILE
  elif [ "$SECURITY" == "ON" ]; then
    echo "-SECURITY- SECURITY BREACH CONFIRMED. PROCEED NOW !" >> $LOGFILE
  fi
fi

