@echo off
setlocal

set TOOLS=../../Tools

set PATH=%TOOLS%\tasm32;%TOOLS%\zxcc;%TOOLS%\intel;%PATH%

set TASMTABS=%TOOLS%\tasm32

set CPMDIR80=%TOOLS%/cpm/

echo "Application Sched"
ASM80 x0100.asm
PLM80 mschd.plm nolist debug
LINK mschd.obj,x0100.obj,plm80.lib to mschd1.mod
LOCATE mschd1.mod TO mschd1.obj code(0100H) stacksize(100)
OBJHEX mschd1.obj to mschd1.hex
ASM80 x0200.asm
LINK mschd.obj,x0200.obj,plm80.lib to mschd2.mod
LOCATE mschd2.mod TO mschd2.obj code(0200H) stacksize(100)
OBJHEX mschd2.obj to mschd2.hex
ZXCC PIP mschd.hex=mschd1.hex,mschd2.hex
ZXCC GENMOD mschd.hex sched.prl
PAUSE
echo "Kernel module"
PLM80 scrsp.plm nolist debug
LINK scrsp.obj to scrsp.mod
LOCATE scrsp.mod TO scrsp1.obj code(0000H) stacksize(0)
LOCATE scrsp.mod TO scrsp2.obj code(0100H) stacksize(0)
OBJHEX scrsp1.obj to scrsp1.hex
OBJHEX scrsp2.obj to scrsp2.hex
ZXCC PIP scrsp.hex=scrsp1.hex,scrsp2.hex
ZXCC GENMOD scrsp.hex sched.rsp
ASM80 brspbi.asm
PLM80 scbrs.plm nolist debug
LINK scbrs.obj,brspbi.obj,plm80.lib to scbrs.mod
LOCATE scbrs.mod TO scbrs1.obj code(0000H) stacksize(0)
LOCATE scbrs.mod TO scbrs2.obj code(0100H) stacksize(0)
OBJHEX scbrs1.obj to scbrs1.hex
OBJHEX scbrs2.obj to scbrs2.hex
ZXCC PIP scbrs.hex=scbrs1.hex,scbrs2.hex
ZXCC GENMOD scbrs.hex sched.brs
PAUSE
erase *.obj
erase *.hex
erase *.mod
erase *.lst