@echo off
setlocal

set TOOLS=../../Tools

set PATH=%TOOLS%\tasm32;%TOOLS%\zxcc;%TOOLS%\win32;%PATH%

set TASMTABS=%TOOLS%\tasm32

set CPMDIR80=%TOOLS%/cpm/

echo "Application SHOW"
ASM80 x0100.asm
PLM80 show.plm nolist debug
LINK show.obj,x0100.obj,plm80.lib TO show1.mod
LOCATE show1.mod TO show1.obj code(0100H) stacksize(100)
OBJHEX show1.obj TO show1.hex
ASM80 x0200.asm
LINK show.obj,x0200.obj,plm80.lib TO show2.mod
LOCATE show2.mod TO show2.obj code(0200H) stacksize(100)
OBJHEX show2.obj to show2.hex
ZXCC PIP show.hex=show1.hex,show2.hex
ZXCC GENMOD show.hex show.prl
PAUSE
erase *.obj
erase *.hex
erase *.mod
erase *.lst