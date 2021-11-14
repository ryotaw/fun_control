#!/bin/bash

# Fan Control
# Usage:
# fan_control.sh start -> fun starts
# fan_control.sh stop  -> fun stops
#
# To run this script you need a root permission.
# So run with sudo.
# Change the GPIO_PIN to the GPIO pin number which your fan is connected.
# 14 is the pin number which official Raspberry Pi 4 Case Fan is connected.

GPIO_PIN=14
GPIO_DIR=/sys/class/gpio
GPIO_TARGET_DIR=${GPIO_DIR}/gpio${GPIO_PIN}
GPIO_VALUE=0

if [ $# != 1 ]; then
  echo "Bad argument"
  echo "usage: fan_control start|stop"
  exit 1
fi

if [ $1 == 'start' ];then
  GPIO_VALUE=1
elif [ $1 == 'stop' ];then
  GPIO_VALUE=0
else
  echo "Bad argument"
  echo "usage: fan_control start|stop"
  exit 1
fi

#SETUP
echo "${GPIO_PIN}" > ${GPIO_DIR}/export
echo "out" > ${GPIO_TARGET_DIR}/direction

#CONTROL
echo ${GPIO_VALUE} > ${GPIO_TARGET_DIR}/value

#UNSET
echo "${GPIO_PIN}" > ${GPIO_DIR}/unexport

exit 0

