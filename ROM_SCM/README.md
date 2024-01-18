# SCM 1.31 for Z80 MMU Z2

The folder contains the ROM SCM and the required applications to install CP/M on the CF card. From SCM, upload and run the progams in the order given, following the messages displayed:

- Format CF - SCM_CF_Format_code8000.hex

- Transfer CP/M to CF - CPM22_SIO_xxx_code8000.hex, where xxx is the SIO addressing type (RC2014 or Zilog)

- Install XModem - SCM_Install_Xmodem_code8000.hex

Once this is done, the MP/M loader progam (loader/mpm.com), the operating system kernel (kernel/mpm.sys) and basic applications from the /distrib folder can be uploaded from CP/M using XModem.