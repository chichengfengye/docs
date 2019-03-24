#!/bin/bash
echo 'PID list of java:'
PROCESS=`ps -ef | grep java | grep -v 'grep' | awk '{ print $2}'`
for i in $PROCESS
do
  echo 'kill java PID' [ $i ]
  kill -9 $i
done