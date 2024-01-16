@echo off
setlocal

set TOOLS=../Tools

set PATH=%TOOLS%\tasm32;%TOOLS%\zxcc;%TOOLS%\intel;%PATH%

set TASMTABS=%TOOLS%\tasm32

set CPMDIR80=%TOOLS%/cpm/

ZXCC GENSYS

