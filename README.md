# Kindle E-ink Photo Frame 📚️🖼️

## Table of Contents

1. [Introduction](#introduction)
2. [Bill of Materials & Goals](#bom)
3. [Jailbreaking Your Kindle](#jailbreak)
4. [Installing Other Hacks](#hacks)
5. [Upload Custom Images](#upload)
6. [Obtaining SSH Access Using USBNetwork](#ssh)
7. [Scripting & Programming](#scripting)
8. [Conclusions & Improvements](#conclusion)

## 🏁 Introduction <a name="introduction"/> 🏁

Have you got an old spare Kindle floating around that never gets used? Why not turn it into an automatically rotating e-ink based photo frame! Unlike traditional photo frames, an e-ink photo frame is able to automatically rotate the image at a pre-determined interval, allowing for a dynamic and stylish decor item with a monochromatic vibe. Unlike most electronic devices, Kindles use an e-ink based display which is able to create an image by passing electricity through e-ink capsules. This allows it to retain the last image placed on it without needing to consistently power the screen, leading to the remarkably long battery life that Kindle's are known for. Here's a photo of the end product made on an old Kindle 2 International I picked up on Facebook Marketplace:
<p align="center">
 <img src="https://user-images.githubusercontent.com/59858450/208094817-b0c18577-c4cf-47a7-95f3-b65116f76740.jpg" alt="kindle"/>
    <br>
    <em>The end product - a Kindle transformed into an e-ink photo frame</em>
</p>

## 📜 Bill of Materials & Goals <a name="bom"/> 📜

To get started you'll need the following things:

1. A Kindle that is jailbreakable. Jailbreaking our Kindle gives us access to the internal custom Linux Kindle OS and can only be done on certain models - the highest firmware with a known jailbreak as of writing is [<=5.14.2](https://www.mobileread.com/forums/showthread.php?t=346037). For reference, my Kindle was running firmware 2.X. Your Kindle should also not be ad-supported model, that is, it should not show ads for Amazon on the lock screen.
2. A microUSB cable
3. A computer (preferably Linux)
4. A photo frame
5. Miscellaneous power tools

With our design, we wanted to keep a few things in our mind:

1. This was intended as a secret santa present - it should prioritise reliability as its number one goal as the recipient should not have to go and debug our product!
2. The charging conditions were unknown; it could be continuously plugged in and powered or charged only when it's out of battery. Thus, it should work regardless of either and should have long battery life if possible. It should also be able to recover if it ever ran out of battery and was fully restarted as a result.
3. The particular model I had does not have a WiFi connection so all images need to be stored locally and preset ahead of time.

## 🔓️ Jailbreaking Your Kindle <a name="jailbreak"/> 🔓️

**🚨 Use a Kindle you don't mind breaking - attempting to jailbreak your Kindle can unintentionally brick it! 🚨**

To get started we'll first need to jailbreak your Kindle in order to get access to the command line through an ssh connection. You can find your firmware version under 'Device Info' in the Kindle settings - there are different approaches depending on the version number:

- For versions 2.X, 3.X and 4.X follow [this tutorial](https://www.mobileread.com/forums/showthread.php?t=88004)
- For versions <= 5.14.2 follow [this tutorial](https://www.mobileread.com/forums/showthread.php?t=346037)

I used the first approach and will focus on that in this writeup. Unzip the given folder and locate your Kindle model using the [serial number](https://wiki.mobileread.com/wiki/Kindle_Serial_Numbers). In the zip folder, find the corresponding update file and upload it to the Kindle over USB connection. Update your Kindle under Menu > Settings > Menu > Update Your Kindle and you're good to go.

## 👾 Installing Other Hacks <a name="hacks"/> 👾

Now that we've got our Kindle jailbroken, we can install some other hacks that will make life 10x easier for us. We'll need 2 for this exercise - USBNetwork and the screensaver hack.

### USB Network

The USB Network allows us to gain ssh access to the Kindle, allowing us to execute arbitrary bash code, create scripts and interact with the internal software running on the Kindle. Similar to the process of jailbreaking, unzip the [USB Network zip folder](https://www.mobileread.com/forums/showthread.php?t=88004) and identify the update file corresponding to your model number. Update your Kindle and that completes the installation.

### Screensaver Hack

The screensaver hack allows us to upload arbitrary images and use them as screensavers. Note that if you have an ad-supported Kindle, this **will not** work! Again the process is identical - [identify your version](https://www.mobileread.com/forums/showthread.php?t=88004) and update your kindle by copying the file over to the root of the Kindle. After the update has been completed successfully, you should see a custom screensaver being displayed whenever you turn your screen off. There are also more detailed instructions for firmwares [2.X, 3.X, 4.X](https://wiki.mobileread.com/wiki/Kindle_Screen_Saver_Hack_for_all_2.x%2C_3.x_&_4.x_Kindles) and firmwares [5.X](https://www.mobileread.com/forums/showthread.php?t=195474) available walking through it step by step.

## 🖼️ Uploading Custom Images <a name="upload"/> 🖼️

Now that the screensaver hack is installed, we'll upload a set of custom images that your Kindle will rotate through automatically:

1. Plug your Kindle into your computer
2. Ensure your set of image files align with the needed resolution for screensaver image for your Kindle version. Generally images should be one of the following sizes and the image format should be PNG (5.X hack) or PNG/JPEG (2.X-4.X hack):

- **600x800** for touch/KT2/KT3 (5.X hack) and most earlier models including the K2I (2.X-4.X hack) 
- **758x1024** for PW/PW2 (5.X hack)
- **824x1200** for DX models (2.X-4.X hack)
- **1072x1448** for KV/PW3/KOA (5.X hack)

3. Copy the images to the `linkss/screensavers` folder
4. If you want the images to be randomised everytime the Kindle reboots, add an empty file with the name `random` in the `linkss` folder.
5. Reboot the Kindle for the images to be applied
6. After your Kindle reboots, if you continuously toggle the screensaver you should see the images change

Now we have a Kindle loaded with images, but in order to change them you have to interact manually with the Kindle to toggle the screensaver. To overcome this, we'll need some custom scripts!

## 📶 Obtaining SSH Access Using USBNetwork <a name="ssh"/> 📶

In order to execute arbitrary code on our Kindle, we'll need to obtain ssh access into the Kindle which runs a custom Linux OS. First, plug your Kindle into your computer before unmounting and ejecting it. This should render your Kindle usable whilst remaining plugged in. On the Kindle, bring up the search bar by pressing either `DEL` or the keyboard key before typing:

```bash
;debugOn
```

and pressing the enter key. Then, bring up the search bar again and activate USB Networking by typing either:

```bash
# Use this on firmware 2.X
`usbNetwork

# Use this on other firmwares
~usbNetwork
```

This activates USB Network and your Kindle can now be connected to using ssh:

1. First identify the attached USB device using the following command:

```bash
ifconfig
```

2. If network manager is used on your computer, disable the automatic management of the USB device. This is needed as network manager will automatically reassign the ip address given to the Kindle. This can be done using:

```
nmcli dev disconnect <usb device id from #1>
```

3. Configure the host ip address for the USB device, setting it to `192.168.2.1` for most devices (`192.168.15.201` for K4 due to the defaults)

```
sudo ifconfig <usb device id from #1> 192.168.2.1
```

4. Ssh into the Kindle using the Kindle's ip address which is `192.168.2.2` for most devices (`192.168.15.244` if the other ip was used)

```bash
ssh root@192.168.2.2
```

5. Enter the default password `mario` to login to the device and use the command to mount the device in read-write mode:

```bash
mntroot rw
```

You should now be logged into the Kindle through ssh and can look around the filesystem!

## 💻️ Scripting & Programming <a name="scripting"/> 💻️


### Setting up the Cron Job

Considering that reliability was one of the key focuses and that our photo frame should be able to recover from a full restart state in the event of battery loss, a cron job was the most intuitive way of doing 2 things:

1. If the Kindle was ever restarted, the cron job could trigger the background screensaver script to rerun
2. If for some reason the background script stopped running, the cron job could recover by restarting the background screensaver script

For our Kindle, cron jobs were available under the `/etc/crontab/root` file. Add the following line to run the `assess_screensaver.sh` script:

```bash
*/5 * * * * /mnt/us/assess_screensaver.sh &
```

Ensure that there is a newline terminating the cron file in order for it to be considered valid! Restart cron using `/etc/init.d/cron restart`. The above line will continuously run the `assess_screensaver.sh` script in the background (i.e. as a child process of the cron process) every 5 minutes. The actual contents of the assessment script are shown below and is included in this repo:

```bash
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
```

The `rJobs` variable first uses the `ps` command to list the processes currently running on the Kindle, filtering them to see which ones are running the `screensaver.sh` script and returning an integer count. If `rJobs` is equal to 0, then we start up the screensaver script as a background process. We then retrieve the state of the device using [lipc](https://wiki.mobileread.com/wiki/Lipc).

`lipc` is a proprietary inter-process communications library present on Kindles which is responsible for controlling a myriad of functions such as power, audio, WiFi and much more. You can find greater details about different modules that can be interacted with under lipc by using the `lipc-probe` command. Here, we use the `lipc-get-prop` command to retrieve the state of the Kindle. There are 4 possible states the Kindle can be in:

- active
- screensaver
- readyToSuspend
- sleep

Particularly important to note is that when plugged in, the Kindle will never reach the readyToSuspend or sleep state, making testing tricky. A typical Kindle's state progression when left idle and unplugged is active (10m) > screensaver (1m) > readyToSuspend (5s) > sleep (indefinite). The sleep state is disruptive as it suspends the Kindles CPU, pausing things like background scripts from running making it something to be aware of. This is important, so keep it in mind for later!

After determining the current state of the kindle, we toggle it - if it is currently active we move it to the screensaver state by simulating a power button press using `lipc-send-event`, otherwise we wake it up using the `lipc-set-prop` command. Thus, our cron job is able to monitor whether the background screensaver script is running, start it if it isn't and toggle the state to enter the needed cycle of the background screensaver script.

### Setting up the Background Script

The background screensaver script runs continuously on the Kindle and is responsible for using the event listener `lipc-wait-event` to react to changes in the state of the Kindle. It's main responsibility is ensuring that if we are currently showing a photo in screensaver mode, that the Kindle wakes up after a set period of time before going back to the screensaver state, essentially allowing for the rotation of the image. Under `/mnt/us` create the file `screensaver.sh` with the following contents:

```bash
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
```

The above script continuously waits for one of the following events to occur from the `powerd` module:

- goingToScreenSaver
- outOfScreenSaver
- readyToSuspend

It then pipes this to a while loop which contains a case statement which does one of the following depending on what event was received:

- **readyToSuspend**: If we're moving into this state, the Kindle must be in the screensaver state and is about to enter sleep. This is undesirable for our application as when it enters the sleep state, background scripts stop running making it difficult to both set a wakeup and monitor for changes to the state of the Kindle. Here we defer the suspension of the kindle for an arbitrary amount of time. Note this prop can only be set when the Kindle is in the readyToSuspend state. Other possible solutions include using `rtcWakeup` property which allows the Kindle to automatically wake up after a duration of time using the onboard real-time clock but this still has issues as the event listener will be suspended meaning it will not be triggered on wakeup.
- **outOfScreenSaver**: This state occurs when the Kindle has moved to the active state from the screensaver. All we want to do in this state is go back to the screensaver so we call the `/mnt/us/set_sleep.sh` script in the background and reap the previous child process whilst we're here to avoid zombie processes. The `set_sleep.sh` script simply waits a second and then calls `lipc-send-event com.lab126.powerd.debug dbg_power_button_pressed` to toggle the state back to the screensaver.
- **goingToScreenSaver**: This state happens when the Kindle moves into the screensaver state. Here, we call the `mnt/us/set_wakeup.sh` script in the background which sleeps for the desired rotation time of the picture before calling setting the `wakeUp` property to change into the active state. Note this must be called as a background process otherwise the sleep will block the event listener from triggering.

<p align="center">
 <img src="https://user-images.githubusercontent.com/59858450/208090638-78c262cc-8480-4f08-902f-94d1fcf800c8.png" alt="state-diagram"/>
    <br>
    <em>State diagram showing the transition of the Kindle as the script runs</em>
</p>

## 🔚 Conclusions & Improvements <a name="conclusion"/> 🔚

All that's now left to do is mount the Kindle into a frame! A wooden one complements the aesthetic of e-ink and can be found at any local shop. Mounting it into the frame can require a bit of fiddling, I utilise some double-sided tape and drilled a hole in the wood on the side for the charging cable to come out of. Give it a try and see what works best.

After that, your Kindle is all set up and ready to go as an e-ink photo frame which automatically rotates through a series of images. There are some improvements you can look into as well if you want to extend the behaviour of your Kindle:

- Look into using `rtcWakeup` rather than using a sleep would allow for longer battery life - especially for frames which rotate photos at a much less frequent interval.
- Utilise WiFi to fetch an image from a remote server for a dynamic photo frame which changes regularly. This can be extended to functions like a weather or calendar display! Unfortunately my model did not come with WiFi capability so I couldn't explore this option.
- Use the onboard `eips` module to write your own custom messages to the Kindle's e-ink screen.

Enjoy repurposing your old Kindle and hope you enjoyed the tutorial!
