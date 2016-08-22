#!/bin/bash
CDIR=`dirname $0`
cd $CDIR

HOST="control.maison.apoui.net"
LOGFILE="../logs/doorlock.log"
SECURITY=""

function getsecstatus {
               SECURITY=`curl -m 1.5 "http://control.maison.apoui.net/rfid/security/status"`
}


getsecstatus
if [ "$SECURITY" == "OFF" ];then
  echo "-SECURITY- Security is OFF : Nothing to do" >> $LOGFILE
elif [ "$SECURITY" == "ON" ]; then
  #curl -m 1.5 "http://$HOST/setrelay/5/on"  # TV ON !!
  curl -m 1.5 "http://$HOST/setrelay/1/off"
  curl -m 1.5 "http://$HOST/setrelay/2/off"
  curl -m 1.5 "http://hd1.freebox.fr/pub/remote_control?code=77460495&key=power" # TV ON !!
  echo "-SECURITY- SECURITY IS ON : PROCEDURE ENGAGED !" >> $LOGFILE
  echo "-SECURITY- Waiting 15 SEC FOR DEAC..." >> $LOGFILE
  sleep 15
  getsecstatus
  if [ "$SECURITY" == "OFF" ]; then
    echo "-SECURITY- Security DISENGAGED : Return to Normal" >> $LOGFILE
  elif [ "$SECURITY" == "ON" ]; then
    echo "-SECURITY- SECURITY BREACH CONFIRMED. PROCEED NOW !" >> $LOGFILE
    ssh root@127.0.0.1 "source /etc/profile && source /root/.bashrc && bash -c '/usr/local/rvm/rubies/ruby-2.2.4/bin/ruby /usr/local/rvm/gems/ruby-2.2.4/bin/airstream //chroot/nginx-static/www/control.maison.apoui.net/rfid/secbreachfull.mp4'"

  fi
fi

