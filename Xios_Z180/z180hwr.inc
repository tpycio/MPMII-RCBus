;
;========== Z180 Internal Interrupt Vectors ========

; The following vectors are offsets from the value 
; loaded in IL, the Interrupt Vector Low register.

VINT1        equ   0		;External INT-1 pin
VINT2        equ   2		;External INT-2 pin
VPRT0        equ   4		;Timer 0
VPRT1        equ   6		;Timer 1
VDMA0        equ   8		;DMA Ch-0
VDMA1        equ   0Ah		;DMA Ch-1
VCSIO        equ   0Ch		;Clocked serial I/O
VASC0        equ   0Eh		;Asynch. comms. Ch-0
VASC1        equ   10h		;Asynch. comms. Ch-1

;========== Z180 System Control Registers ==========
;NB These registers may be relocated to multiples of
; 40H, by setting the IO Control Register (ICR = 3FH)
; The addresses below are valid with ICR=0 (else they
; are offsets from the ICR base value).

BASEIO       equ   0C0h		; Base address Z180 

; ASCI Registers

CNTLA0       equ   BASEIO+00H	; ASCI Control Reg A Ch0
CNTLA1       equ   BASEIO+01H	; ASCI Control Reg A Ch1
CNTLB0       equ   BASEIO+02H	; ASCI Control Reg B Ch0
CNTLB1       equ   BASEIO+03H	; ASCI Control Reg B Ch1
STAT0        equ   BASEIO+04H	; ASCI Status Reg Ch0
STAT1        equ   BASEIO+05H	; ASCI Status Reg Ch1
TDR0         equ   BASEIO+06H	; ASCI TX Data Reg Ch0
TDR1         equ   BASEIO+07H	; ASCI TX Data Reg Ch1
RDR0         equ   BASEIO+08H	; ASCI RX Data Reg Ch0
RDR1         equ   BASEIO+09H	; ASCI RX Data Reg Ch1
BRK0         equ   BASEIO+12H	; Break Control Reg Ch0
BRK1         equ   BASEIO+13H	; Break Control reg Ch1

; CSI/O Registers

CNTR         equ   BASEIO+0AH	; CSI/O Control Reg
TRDR         equ   BASEIO+0BH	; CSI/O TX/RX Data Reg

; Timer Registers

TMDR0L       equ   BASEIO+0Ch	; Timer Data Reg Ch0-Low
TMDR0H       equ   BASEIO+0Dh	; Timer Data Reg Ch0-High
RLDR0L       equ   BASEIO+0Eh	; Timer Reload Reg Ch0-Low
RLDR0H       equ   BASEIO+0Fh	; Timer Reload Reg Ch0-High
TCR          equ   BASEIO+10h	; Timer Control Reg
TMDR1L       equ   BASEIO+14h	; Timer Data Reg Ch1-Low
TMDR1H       equ   BASEIO+15h	; Timer Data Reg Ch1-High
RLDR1L       equ   BASEIO+16h	; Timer Reload Reg Ch1-Low
RLDR1H       equ   BASEIO+17h	; Timer Reload Reg Ch1-High
FRC          equ   BASEIO+18h	; Free-Running Counter

; DMA Registers

SAR0L        equ   BASEIO+20h	; DMA Source Addr Reg Ch0-Low
SAR0H        equ   BASEIO+21h	; DMA Source Addr Reg Ch0-High
SAR0B        equ   BASEIO+22h	; DMA Source Addr Reg Ch0-B
DAR0L        equ   BASEIO+23h	; DMA Destn  Addr Reg Ch0-Low
DAR0H        equ   BASEIO+24h	; DMA Destn  Addr Reg Ch0-High
DAR0B        equ   BASEIO+25h	; DMA Destn  Addr Reg Ch0-B
BCR0L        equ   BASEIO+26h	; DMA Byte Count Reg Ch0-Low
BCR0H        equ   BASEIO+27h	; DMA Byte Count Reg Ch0-High
MAR1L        equ   BASEIO+28h	; DMA Memory Addr Reg Ch1-Low
MAR1H        equ   BASEIO+29h	; DMA Memory Addr Reg Ch1-High
MAR1B        equ   BASEIO+2Ah	; DMA Memory Addr Reg Ch1-B
IAR1L        equ   BASEIO+2Bh	; DMA I/O Addr Reg Ch1-Low
IAR1H        equ   BASEIO+2Ch	; DMA I/O Addr Reg Ch1-High
BCR1L        equ   BASEIO+2Eh	; DMA Byte Count Reg Ch1-Low
BCR1H        equ   BASEIO+2Fh	; DMA Byte Count Reg Ch1-High
DSTAT        equ   BASEIO+30h	; DMA Status Reg
DMODE        equ   BASEIO+31h	; DMA Mode Reg
DCNTL        equ   BASEIO+32h	; DMA/WAIT Control Reg

; System Control Registers

CCR          equ  BASEIO+1Fh	; CPU control reg.
IL           equ  BASEIO+33h	; INT Vector Low Reg
ITC          equ  BASEIO+34h	; INT/TRAP Control Reg
RCR          equ  BASEIO+36h	; Refresh Control Reg
CBR          equ  BASEIO+38h	; MMU Common Base Reg
BBR          equ  BASEIO+39h	; MMU Bank Base Reg
CBAR         equ  BASEIO+3Ah	; MMU Common/Bank Area Reg
OMCR         equ  BASEIO+3Eh	; Operation Mode Control Reg
ICR          equ  BASEIO+3Fh	; I/O Control Reg

; **********************************************************************
; Serial status register bits

ST_RDRF      equ   7              ;Receive data register Full
ST_TDRE      equ   1              ;Transmit data register empty

; **********************************************************************
; CF registers
CF_DATA      equ   10h
CF_FEATURES  equ   11h
CF_ERROR     equ   11h
CF_SECCOUNT  equ   12h
CF_SECTOR    equ   13h
CF_CYL_LOW   equ   14h
CF_CYL_HI    equ   15h
CF_HEAD      equ   16h
CF_STATUS    equ   17h
CF_COMMAND   equ   17h
CF_LBA0      equ   13h
CF_LBA1      equ   14h
CF_LBA2      equ   15h
CF_LBA3      equ   16h

;CF Features
CF_8BIT      equ   1
CF_NOCACHE   equ   082h
;CF Commands
CF_READ_SEC  equ   020h
CF_WRITE_SEC equ   030h
CF_SET_FEAT  equ   0EFh

; **********************************************************************
; PIO I/O Addresses

PIOAD        equ   4Ch              ; Data port A
PIOBD        equ   4Dh              ; Data port B
PIOAC        equ   4Eh              ; Control port A
PIOBC        equ   4Fh              ; Control port B

