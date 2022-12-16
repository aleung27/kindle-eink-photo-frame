lipc-wait-event -m com.lab126.powerd goingToScreenSaver,outOfScreenSaver,readyToSuspend | while read event; do
	# echo "$(date): $event" >> /mnt/us/logs.txt
	case "$event" in
		readyToSuspend*)
			lipc-set-prop -i com.lab126.powerd deferSuspend 5000;;
		outOfScreenSaver*)
			wait $!
			/mnt/us/set_sleep.sh &;;
		goingToScreenSaver*)
			wait $!
			/mnt/us/set_wakeup.sh &;;
	esac
done;
