# XIOS building

Folder contains the XIOS sources used to build BNKXIOS.SPR for Z80.
XIOS requires the appropriate switches to be set up depending on the target hardware configuration

- RC2014 - true|false (RC2014 | Zilog SIO address scheme)

- MMU612 - true|false (MMU 74HCT612|MMU Zeta2 )

CTC channels 1 and 2 are combined, for other combinations the 'setup' procedure and the interrupt table must be modified.