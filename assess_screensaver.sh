# Is the screensaver script running already?
rJobs=$(ps -ef | grep /mnt/us/screensaver.sh | grep -v grep | wc -l)

if [ $rJobs -eq 0 ]
then
	# Start background screensaver script
	/mnt/us/screensaver.sh &
  
	# Get the current state, and toggle it to trigger the screensaver cycle
	state=$(lipc-get-prop -s com.lab126.powerd state)
	if [ $state = "active" ]
	then
		lipc-send-event com.lab126.powerd.debug dbg_power_button_pressed # sleep
	else
		lipc-set-prop -i com.lab126.powerd wakeUp 1 # wake up
	fi
fi
