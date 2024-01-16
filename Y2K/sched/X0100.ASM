$title	('MP/M II V2.0  Externals')
	name	x0100

;/*
;  Copyright (C) 1979,1980,1981
;  Digital Research
;  P.O. Box 579
;  Pacific Grove, CA 93950
;
;  Revised:
;    14 Sept 81 by Thomas Rolander
;*/

	CSEG
offset	equ	0000h

mon1	equ	0005h+offset
mon2	equ	0005h+offset
mon2a	equ	0005h+offset
	public	mon1,mon2,mon2a

fcb	equ	005ch+offset
fcb16	equ	006ch+offset
tbuff	equ	0080h+offset
	public	fcb,fcb16,tbuff

bdisk	equ	0004h+offset
maxb	equ	0006h+offset
buff	equ	0080h+offset
boot	equ	0000h+offset
	public	bdisk,maxb,buff,boot

	END
