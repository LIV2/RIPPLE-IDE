# RIPPLE IDE

Zorro 2 IDE Interface for Amiga 2000/3000/4000

![PCB](Docs/RIPPLE.jpg?raw=True)

## Table of contents
1. [Status](#status)
2. [Features](#features)
3. [Ordering PCBs](#ordering-pcbs)
4. [Programming](#programming)
5. [Parts list & Links](#parts-list--links)
6. [Revision history](#revision-history)
7. [Special Thanks and Shoutouts](#special-thanks-and-shoutouts)
8. [License](#license)

## Status
Tested and working.

## Features
* Autoboot
* ROM can be updated simply by booting the update disk
* Works with Kickstart 1.3 and up
* [Supports up to 2TB drives](https://github.com/LIV2/lide.device/#large-drive-4gb-support)
* Supports ATAPI Devices (CD/DVD-ROM, Zip disk etc)
* Boot from ZIP/LS-120 etc
* [Boot from CD-ROM](https://github.com/LIV2/lide.device/#boot-from-cdrom)
* SCSI Direct, NSD, TD64 support
* Uses [lide.device](https://github.com/LIV2/lide.device)

For more information on these features please see the [lide.device readme](https://github.com/LIV2/lide.device/blob/master/README.md)

## Ordering PCBs
You can find the latest Gerbers attached to the [latest Release](https://github.com/LIV2/RIPPLE-IDE/releases)

I recommend ordering from JLCPCB as this board was designed within their 2-layer specifications  

BOM and Placement files for JLCPCBs assembly service are provided and can be found inside the Gerbers folder and the Gerbers.zip file found under [Releases](https://github.com/LIV2/RIPPLE-IDE/releases)

Recommended options when ordering:
* Thickness: 1.6mm
* Surface Finish: ENIG-RoHS
* Gold Fingers: Yes
* 45°finger chamfered: Yes

## Programming
To program the Flash, simply boot the latest [lide-update.adf](https://github.com/LIV2/lide.device/releases/latest) boot disk

The CPLD can be programmed using a Raspberry Pi [as described by LinuxJedi](https://linuxjedi.co.uk/2020/12/01/programming-xilinx-jtag-from-a-raspberry-pi/)

## Parts list & links
### Rev A4
* [HTML BOM](https://html-preview.github.io/?url=https://github.com/LIV2/RIPPLE-IDE/blob/Rev_A4/Docs/RIPPLE_bom.html)
* [Interactive HTML BOM](https://html-preview.github.io/?url=https://github.com/LIV2/RIPPLE-IDE/blob/Rev_A4/Docs/RIPPLE-ibom.html)

### Rev A3
* [HTML BOM](https://html-preview.github.io/?url=https://github.com/LIV2/RIPPLE-IDE/blob/Rev_A3/Docs/RIPPLE_bom.html)
* [Interactive HTML BOM](https://html-preview.github.io/?url=https://github.com/LIV2/RIPPLE-IDE/blob/Rev_A3/Docs/RIPPLE-ibom.html)

### Rev A2 & A1
* [BOM](Docs/Rev_A2-bom.md)
* [Interactive HTML BOM](https://html-preview.github.io/?url=https://github.com/LIV2/RIPPLE-IDE/blob/Rev_A2/Docs/RIPPLE-ibom.html)

## Revision history
* A4 - Change flash footprint from TSOP to PLCC because the TSOP version is no longer manufactured.
* A3 - Add protection for reverse installation
* A2 - Add bank selection, support loading CDFS from flash
* A1 - Initial release

## Special Thanks and Shoutouts
Thanks to:
* GadgetUK164, Screemo, Sparx, Mafitzee, Pillock for Beta testing the board
* Stefan Reinauer and Chris Hooper for creating the Open-Source A4091 driver which was the inspiration to create lide.device used by RIPPLE

## License
RIPPLE IDE is covered by a GPL 2.0 Only license  
[![License: GPL v2](https://img.shields.io/badge/License-GPL_v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

