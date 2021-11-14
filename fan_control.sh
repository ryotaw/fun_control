#!/bin/bash

# Fan Control
# Usage:
# fan_control.sh start -> fun starts
# fan_control.sh stop  -> fun stops
# fan_control.sh check -> check CPU's temerature and do start/stop
#
# To run this script you need a root permission.
# So run with sudo.
# Change the GPIO_PIN to the GPIO pin number which your fan is connected.
# 14 is the pin number which official Raspberry Pi 4 Case Fan is connected.
# TEMP_THRESHOLD is a temperature to decide stop or start in check mode.
# TEMP_THRESHOLD=70000 means 70.000 degrees celsius.

GPIO_PIN=14
GPIO_DIR=/sys/class/gpio
GPIO_TARGET_DIR=${GPIO_DIR}/gpio${GPIO_PIN}
GPIO_VALUE=0
TEMP_THRESHOLD=70000

if [ $# != 1 ]; then
  echo "Bad argument"
  echo "usage: fan_control start|stop"
  exit 1
fi

if [ $1 = 'start' ];then
  GPIO_VALUE=1
elif [ $1 = 'stop' ];then
  GPIO_VALUE=0
elif [ $1 = 'check' ];then
  TEMPERATURE=`cat /sys/class/hwmon/hwmon0/temp1_input`
  echo "CPU temperature is ${TEMPERATURE}"
  if [ ${TEMPERATURE} -gt ${TEMP_THRESHOLD} ];then
    GPIO_VALUE=1
  else
    GPIO_VALUE=0
  fi
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
