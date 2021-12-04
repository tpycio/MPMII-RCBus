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
DEL BNKXIOS.SPR
ZX ZSM XIOS,XIOS=XIOS.Z80
ZX LINK BNKXIOS=XIOS[NR,OS]
PAUSE
