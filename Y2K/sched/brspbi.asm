$title	('Banked Resident System Process  BDOS Interface')
	name	brspbi
;
;/*
;  Copyright (C) 1979,1980,1981
;  Digital Research
;  P.O. Box 579
;  Pacific Grove, CA 93950
;
;  Revised:
;    14 Sept 81 by Thomas Rolander
;*/
	cseg
;
	extrn	os
;
	public	mon1,mon2,mon2a
mon1:
mon2:
mon2a:
	lhld	os
	mov	a,m
	inx	h
	mov	h,m
	mov	l,a
	pchl
;
	end
