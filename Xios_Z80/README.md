# XIOS building

Folder contains the XIOS sources used to build BNKXIOS.SPR for Z180.
XIOS requires the appropriate switches to be set up depending on the target hardware configuration

- RC2014 - true|false (RC2014 | Zilog SIO address scheme)

- MEM512 - true|false [512k ROM 512k RAM Module RC2014](https://rc2014.co.uk/modules/512k-rom-512k-ram-module/) | [Z80-512K: Z80 CPU and Memory Module](https://github.com/skiselev/Z80-512K)

CTC channels 1 and 2 are combined, for other combinations the 'setup' procedure and the interrupt table must be modified.