@echo off
setlocal

set TOOLS=../../Tools

set PATH=%TOOLS%\tasm32;%TOOLS%\zxcc;%TOOLS%\intel;%PATH%

set TASMTABS=%TOOLS%\tasm32

set CPMDIR80=%TOOLS%/cpm/

echo "Application SDIR"
ASM80 x0100.asm
PLM80 dm.plm debug nolist
PLM80 sn.plm debug nolist
PLM80 dse.plm debug nolist
PLM80 dsh.plm debug nolist
PLM80 dso.plm debug nolist
PLM80 dp.plm debug nolist
PLM80 da.plm debug nolist
PLM80 dts.plm debug nolist
LINK x0100.obj,dm.obj,sn.obj,dse.obj,dso.obj,dsh.obj,dp.obj,da.obj,dts.obj,plm80.lib TO d1.mod
LOCATE d1.mod TO d1.obj code(0100H) stacksize(50)
OBJHEX d1.obj TO d1.hex
ASM80 x0200.asm
LINK x0200.obj,dm.obj,sn.obj,dse.obj,dso.obj,dsh.obj,dp.obj,da.obj,dts.obj,plm80.lib TO d2.mod
LOCATE d2.mod TO d2.obj code(0200H) stacksize(50)
OBJHEX d2.obj to d2.hex
ZXCC PIP d.hex=d1.hex,d2.hex
ZXCC GENMOD d.hex sdir.prl
PAUSE
erase *.obj
erase *.hex
erase *.mod
erase *.lst