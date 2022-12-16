sleep 1 # Don't go back to screensaver immediately to avoid race conditions
lipc-send-event com.lab126.powerd.debug dbg_power_button_pressed # Toggle screensaver back on
