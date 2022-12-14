# Kindle E-ink Photo Frame 📚️🖼️

## Table of Contents

1. [Introduction](#introduction)
2. [Bill of Materials](#bom)
3. [Jailbreaking Your Kindle](#jailbreak)
4. [Installing Other Hacks](#hacks)
5. [Upload Custom Images to Your Kindle](#upload)
6. [Obtaining SSH Access Using USBNetwork](#ssh)


## 🏁 Introduction <a name="introduction"/> 🏁

Have you got an old spare Kindle floating around that never gets used? Why not turn it into an automatically rotating e-ink based photo frame! Unlike traditional photo frames, an e-ink photo frame is able to automatically rotate the image at a pre-determined interval, allowing for a dynamic and stylish decor item with a monochromatic vibe. Unlike most electronic devices, Kindles use an e-ink based display which is able to create an image by passing electricity through e-ink capsules. This allows it to retain the last image placed on it without needing to consistently power the screen, leading to the remarkably long battery life that Kindle's are known for. Here's a photo of the end product made on an old Kindle 2 International I picked up on Facebook Marketplace:

## 📜 Bill of Materials <a name="bom"/> 📜

To get started you'll need the following things:

1. A Kindle that is jailbreakable. Jailbreaking our Kindle gives us access to the internal custom Linux Kindle OS and can only be done on certain models - the highest firmware with a known jailbreak as of writing is [<=5.14.2](https://www.mobileread.com/forums/showthread.php?t=346037). For reference, my Kindle was running firmware 2.X. Your Kindle should also not be ad-supported model, that is, it should not show ads for Amazon on the lock screen.
2. A microUSB cable
3. A computer (preferably Linux)
4. A photo frame
5. Miscellaneous power tools

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

## 🖼️ Uploading Custom Images to Your Kindle <a name="upload"/> 🖼️

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

```[bash]
;debugOn
```

and pressing the enter key. Then, bring up the search bar again and activate USB Networking by typing either:

```[bash]
# Use this on firmware 2.X
`usbNetwork

# Use this on other firmwares
~usbNetwork
```

This activates USB Network and your Kindle can now be connected to using ssh:

1. First identify the attached USB device using the following command:

```
ifconfig
```

2. If network manager is used on your computer, disable the automatic management of the USB device. This is needed as network manager will automatically reassign the ip address given to the Kindle. This can be done using:

```
nmcli dev disconnect <usb device id from #1>
```

3. Configure the host ip address for the USB device, setting it to `192.168.2.1` for most devices (`192.168.15.201` for K4 due to the defaults)

```
sudo ifconfig <usb device id from #> 192.168.2.1
```

4. Ssh into the Kindle using the Kindle's ip address which is `192.168.2.2` for most devices (`192.168.15.244` if the other ip was used)

```
ssh root@192.168.2.2
```

5. Enter the default password `mario` to login to the device and use the command to mount the device in read-write mode:

```
mntroot rw
```

You should now be logged into the Kindle through ssh and can look around the filesystem!
