@echo off
setlocal

set TOOLS=../Tools

set PATH=%TOOLS%\tasm32;%TOOLS%\zxcc;%TOOLS%\intel;%PATH%

set TASMTABS=%TOOLS%\tasm32

set CPMDIR80=%TOOLS%/cpm/

DEL *.REL
DEL *.PRN

ZXCC ZSM LDRBIOS,LDRBIOS=LDRBIOS.Z80
ZXCC LINK LDRBIOS.BIN=LDRBIOS[NR,L1700]
copy /b mpmldr.bin + ldrbios.bin mpm.com
PAUSE