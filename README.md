# fan_control.sh
Simple and easy fan control for Raspberry Pi.
Start, stop and check CPU's temperature to decide start or stop.
Written with bash, so you need nothing to prepare.

## Install
Place anywhere you want.

## How To Start
`$ sudo fan_control.sh start`
## How To Stop
`$ sudo fan_control.sh stop`
## How To See CPU's temperature
`$ sudo fan_control.sh check`

## Run at the startup
Edit `/etc/rc.local` and write `fan_control.sh start` or `fan_control.sh stop`
Or edit crontab.
``` shell
$ sudo su
$ crontab -e
* * * * * for i in `seq 0 10 59`;do (sleep $i;/usr/local/bin/app/fan_control.sh check) & done;
```
