# Kindle E-ink Photo Frame 📚️🖼️

## Table of Contents

1. [Introduction](#introduction)
2. [Bill of Materials](#bom)
3. [Jailbreaking Your Kindle](#jailbreak)
4. [Installing Other Hacks](#hacks)


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

The screensaver hack allows us to upload arbitrary images and use them as screensavers. Note that if you have an ad-supported Kindle, this **will not** work! Again the process is identical - [identify your version](https://www.mobileread.com/forums/showthread.php?t=88004) and update your kindle by copying the file over to the root of the Kindle.
