@echo off
setlocal

set TOOLS=../../Tools

set PATH=%TOOLS%\tasm32;%TOOLS%\zxcc;%TOOLS%\intel;%PATH%

set TASMTABS=%TOOLS%\tasm32

set CPMDIR80=%TOOLS%/cpm/

echo "Application SDIR"
ASM80 x0100.asm
PLM80 set.plm nolist debug
LINK set.obj,x0100.obj,plm80.lib TO set1.mod
LOCATE set1.mod TO set1.obj code(0100H) stacksize(100)
OBJHEX set1.obj TO set1.hex
ASM80 x0200.asm
LINK set.obj,x0200.obj,plm80.lib TO set2.mod
LOCATE set2.mod TO set2.obj code(0200H) stacksize(100)
OBJHEX set2.obj to set2.hex
ZXCC PIP set.hex=set1.hex,set2.hex
ZXCC GENMOD set.hex set.prl
PAUSE
erase *.obj
erase *.hex
erase *.mod
erase *.lst