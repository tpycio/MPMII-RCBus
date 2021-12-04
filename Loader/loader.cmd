@echo off
setlocal

set TOOLS=../Tools

set PATH=%TOOLS%\tasm32;%TOOLS%\zx;%PATH%

set TASMTABS=%TOOLS%\tasm32

set ZXBINDIR=%TOOLS%/cpm/bin/
set ZXLIBDIR=%TOOLS%/cpm/lib/
set ZXINCDIR=%TOOLS%/cpm/include/

DEL *.REL
DEL *.PRN

ZX ZSM LDRBIOS,LDRBIOS=LDRBIOS.Z80
ZX LINK LDRBIOS.BIN=LDRBIOS[NR,L1700]
copy /b mpmldr.bin + ldrbios.bin mpm.com
PAUSE