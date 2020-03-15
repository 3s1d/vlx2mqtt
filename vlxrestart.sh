#!/bin/bash
#if [[ $(ps up `cat /tmp/vlx.pid 2>/dev/null` 2>/dev/null) == 0 ]]; then
	#rm -f /tmp/vlx.pid
	#echo "$(date +"%b %_d %T") $(hostname) $0: VLX restart" >> /var/log/messages
	#systemctl restart vlx
#	echo restart
#fi

PIDFILE=/tmp/vlx.pid
RUNNING=0

if [ -f "$PIDFILE" ]
then
	RUNNINGPID=`cat "$PIDFILE"`
	PROGRAMPID=`ps -aux | grep "vlx2mqtt.py" | grep -v grep | awk '{print $2;}'`
	for PIDEL in $PROGRAMPID
	do
		if [ "$PIDEL" == "$RUNNINGPID" ]
		then
			RUNNING=1
			break
		fi
	done
fi

if [ "$RUNNING" == "0" ]
then
	rm -f /tmp/vlx.pid
	echo "$(date +"%b %_d %T") $(hostname) $0: VLX restart" >> /var/log/messages
	/bin/systemctl restart vlx
fi

