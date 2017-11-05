#!/bin/sh
echo "show me what you got"

alsaplayer -s china -q china-breach.mp3 &
sleep 1
alsaplayer -s seabear -q sea-bear.mp3 &
sleep 2
alsaplayer -n 0 --pause
alsaplayer -n 1 --pause


PREVIOUS_TRACK_NUMBER=-1
TRACK_NUMBER=-1

cu -l /dev/ttyACM0 -s 57600 | while read LINE
do
  echo "tune $LINE"
  if [ "$LINE" -ge 100 ] && [ "$LINE" -lt 1000 ]; then
    TRACK_NUMBER=0 
  elif [ "$LINE" -ge 1000 ] && [ "$LINE" -lt 2000 ]; then
    TRACK_NUMBER=1
  else 
    TRACK_NUMBER=-1
  fi

  if [ "$PREVIOUS_TRACK_NUMBER" -ne "$TRACK_NUMBER" ]; then 
    if [ "$PREVIOUS_TRACK_NUMBER" -ne -1 ]; then 
      echo "pausing track $PREVIOUS_TRACK_NUMBER"
      alsaplayer -n $PREVIOUS_TRACK_NUMBER --pause
    fi 
    if [ "$TRACK_NUMBER" -ne -1 ]; then
      echo "starting track $TRACK_NUMBER"
      alsaplayer -n $TRACK_NUMBER --start
    fi
    PREVIOUS_TRACK_NUMBER=$TRACK_NUMBER
  fi
done