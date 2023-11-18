# RIPPLE IDE

Zorro 2 IDE Interface for Amiga 2000/3000/4000

![PCB](Docs/PCB.png?raw=True)

## Table of contents
1. [Status](#status)
2. [Features](#features)
3. [Ordering PCBs](#ordering-pcbs)
4. [Bill of Materials](#bill-of-materials)
6. [Special Thanks and Shoutouts](#special-thanks-and-shoutouts)
7. [License](#license)

## Status
Tested and working.

## Features
* Autoboot
* Works with Kickstart 1.3 and up
* Supports up to 127GB drives
* Supports ATAPI Devices (CD/DVD-ROM, Zip disk etc)
* Boot from ZIP/LS-120 etc
* SCSI Direct, NSD, TD64 support
* Uses [lide.device](https://github.com/LIV2/lide.device)


## Ordering PCBs
I recommend ordering from JLCPCB as this board was designed within their 2-layer specifications  
Recommended options when ordering:
* Thickness: 1.6mm
* Surface Finish: ENIG-RoHS
* Gold Fingers: Yes
* 45°finger chamfered: Yes


## Bill of Materials
|References|Qty|Value|Footprint|Link|
|----------|---|-----|---------|----|
|C1,C12|2|47uF 16V|CP_Radial_D5.0mm_P2.50mm|[Mouser](https://www.mouser.com/ProductDetail/667-ECE-A1CKA101)|
|C3,C2|2|10uF Tantalum|1206|[Mouser](https://www.mouser.com/ProductDetail/581-TAJA106K016R)|
|C9,C4,C5,C7,C11,C8,C6,C10|8|0.1uF Ceramic|0603|[Mouser](https://www.mouser.com/ProductDetail/187-CL10B104KA8NFNC)|
|D1|1|BAT54A|SOT-23|[Mouser](https://www.mouser.com/ProductDetail/621-BAT54A-F)|
|D2|1|SMD LED|0603|[Mouser](https://www.mouser.com/ProductDetail/710-150060VS75003)|
|F1|1|2A Polyfuse|1812|[Mouser](https://www.mouser.com/ProductDetail/652-MF-MSMF110/16-2)|
|J1|1|JTAG Header|1x06 2.54mm Pin Header||
|J4,J3|2|IDE Cennector, Right-angle|2x20 2.54mm Right-angle IDC|[Mouser](https://www.mouser.com/ProductDetail/517-30340-5002)|
|J5|1|Disable Jumper|1x02 2.54mm Pin Header||
|J6|1|LED Header|1x04 2.54mm Pin Header||
|J7,J2|2|KEY_PWR|1x02 2.54mm Pin Header||
|Q1|1|BC857BS|SOT-363|[Mouser](https://www.mouser.com/ProductDetail/621-BC857BS-13-F)|
|R10|1|150 Ohm|0603|[Mouser](https://www.mouser.com/ProductDetail/603-RC0603FR-10150RL)|
|R12,R1,R8,R13,R11,R9|6|10K Ohm|0603|[Mouser](https://www.mouser.com/ProductDetail/279-CRGH0603J10K)|
|R14,R5,R2,R3|4|68 Ohm|0603|[Mouser](https://www.mouser.com/ProductDetail/71-CRCW060368R0FKEB)|
|R17|1|330 Ohm|0603|[Mouser](https://www.mouser.com/ProductDetail/603-RT0603DRE07330RL)|
|R6,R4,R15,R16,R7|5|1K Ohm|0603|[Mouser](https://www.mouser.com/ProductDetail/603-RC0603JR-131KL)|
|U1|1|LM1117-3.3|SOT-223-3|[Mouser](https://www.mouser.com/ProductDetail/926-LM1117MP-3.3NOPB)|
|U2|1|SST39SF010|TSOP-32|[Mouser](https://www.mouser.com/ProductDetail/579-SST39010A554CWHE)|
|U3|1|XC9572XL-VQ64|VQFP-64|[Mouser](https://www.mouser.com/ProductDetail/217-C9572XL-10VQG64C)|
|U6,U5,U4|3|74HCT245|TSSOP-20|[Mouser](https://www.mouser.com/ProductDetail/595-SN74HCT245PWR)|

## Special Thanks and Shoutouts
Thanks to:
* GadgetUK164, Screemo, Sparx, Mafitzee, Pillock for Beta testing the board
* Stefan Reinauer and Chris Hooper for creating the Open-Source A4091 driver which was the inspiration to create lide.device used by RIPPLE

## License
RIPPLE IDE is covered by a GPL 2.0 Only license  
[![License: GPL v2](https://img.shields.io/badge/License-GPL_v2-blue.svg)](https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html)

