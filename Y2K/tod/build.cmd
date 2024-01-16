@echo off
setlocal

set TOOLS=../../Tools

set PATH=%TOOLS%\tasm32;%TOOLS%\zxcc;%TOOLS%\win32;%PATH%

set TASMTABS=%TOOLS%\tasm32

set CPMDIR80=%TOOLS%/cpm/

echo "Application TOD"
ASM80 x0100.asm
PLM80 tod.plm nolist debug
LINK tod.obj,x0100.obj,plm80.lib TO tod1.mod
LOCATE tod1.mod TO tod1.obj code(0100H) stacksize(100)
OBJHEX tod1.obj TO tod1.hex
ASM80 x0200.asm
LINK tod.obj,x0200.obj,plm80.lib TO tod2.mod
LOCATE tod2.mod TO tod2.obj code(0200H) stacksize(100)
OBJHEX tod2.obj TO tod2.hex
ZXCC PIP tod.hex=tod1.hex,tod2.hex
ZXCC GENMOD tod.hex tod.prl
PAUSE
erase *.obj
erase *.hex
erase *.mod
erase *.lst