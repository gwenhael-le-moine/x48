;
; $Id: ROMDump.s,v 1.4 1995/01/11 18:21:36 ecd Exp ecd $
;
;  This file is part of ROMDump, a ROM dump utility for the HP48 Calculator.
;  Copyright (C) 1994  Eddie C. Dost  (ecd@dressler.de)
;
;  This program is free software; you can redistribute it and/or modify
;  it under the terms of the GNU General Public License as published by
;  the Free Software Foundation; either version 2 of the License, or
;  (at your option) any later version.
;
;  This program is distributed in the hope that it will be useful,
;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;  GNU General Public License for more details.
;
;  You should have received a copy of the GNU General Public License
;  along with this program; if not, write to the Free Software
;  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;
; Usage:
;
; (2: hxs, 1: hxs --> ) pop start address from level 2,
;                       pop end address from level 1, and dump
;                       ROM to the serial at 9600 baud using
;                       lines of form "aaaaa:hhhhhhhhhhhhhhhh\n\r"
;                       with 16 nibbles ROM data hhhhhhhhhhhhhhhh
;                       at address aaaaa.
;
; machine independent addresses (supported by HP)
;
AllowIntr	equ	$010e5
DisableIntr	equ	$01115
DOBINT		equ	$02911
DOCOL		equ	$02d9d
DOCODE		equ	$02dcc
SEMI		equ	$0312b
GETPTRLOOP	equ	$05143
SAVPTR		equ	$0679b
GETPTR		equ	$067d2
CK2NOLASTWD	equ	$18a8d
CKandDISPATCH1	equ	$18fb2
VERSTRING	equ	$30794
PopASavptr	equ	$3251c
;
; machine independent addresses (NOT supported by HP)
;
POPHXS		equ	$53f8d

;
; machine dependent addresses
;
sx_GosubHidC	equ	$026bf
sx_prog_low	equ	$700f1	; IRAMBUFF
sx_prog_high	equ	$f00f1	; IRAMBUFF when RAM configured high

gx_GosubHidC	equ	$026ca
gx_prog_low	equ	$800f5	; IRAMBUFF
gx_prog_high	equ	$c00f5	; IRAMBUFF when RAM configured high
gx_LINECOUNT	equ	$8069a

;
; flags used
;
sGX		equ	0
sHIGH		equ	1

;
; begin off assembler code
;
	textr	"HPHP48-R"

	dcr.5	DOCOL
	dcr.5	CK2NOLASTWD
	dcr.5	CKandDISPATCH1
	dcr.5	DOBINT
	dcr.5	$000bb

	;
	; only executed when (2: hxs, 1: hxs)
	;
	dcr.5	DOCOL
	dcr.5	VERSTRING

	dcr.5	DOCODE
code_start
	dcr.5	code_end-code_start

	jsr	DisableIntr

	;
	; figure out version
	;
	jsr	PopASavptr
	move.1	#0, p
	move.5	#24, c.p
	add.a	c, a
	move.a	a, d1
	move.b	(d1), a
	move.2	#$4a, c.p	; 'J' == last version for S/SX
	bclr	#sGX, st
	ble.b	a, c, got_version
	bset	#sGX, st
got_version
	bclr	#sHIGH, st

	;
	; get arguments
	;
	jsr	GETPTR
	jsr	POPHXS
	move.1	#0, p
	move.5	#$ffff0, c.p
	and.a	c, a
	move.a	a, r4

	jsr	GETPTR
	jsr	POPHXS
	move.1	#0, p
	move.5	#$ffff0, c.p
	and.a	c, a
	move.a	a, r3
	
	;
	; open IO
	;
	move.5	#$00110, d1
	move.1	#8, a.p
	move.1	a, (d1)

	;
	; set speed to 9600 baud
	;
	move.2	#$0d, d1
	move.1	#6, a.p
	move.1	a, (d1)

	;
	; dump ROM $00000 - $6ffff
	;
dump_rom_0
	move.a	r3, a
	move.5	#$6fff0, c.p
	bgt.a	a, c, dump_rom_7
	move.a	a, r1

	move.a	r4, c
	move.a	c, b
	move.5	#$6fff0, c.p
	ble.a	b, c, end_addr_0
	move.a	c, b
end_addr_0
	subr.a	b, a
	bcc	continue_0
	bra.3	dump_done
continue_0
	move.a	a, r2

	bsr.3	prog_start

	move.5	#$70000, a.p
	move.a	a, r3

	;
	; dump ROM $70000 - $7ffff
	;
dump_rom_7
	move.a	r3, a
	move.5	#$7fff0, c.p
	bgt.a	a, c, dump_done_7
	bra.3	continue_7
dump_done_7
	bbs	#sGX, st, continue_8
	bra.3	dump_done
continue_8
	bra.3	dump_rom_8
continue_7
	move.a	a, r1

	move.a	r4, c
	move.a	c, b
	move.5	#$7fff0, c.p
	ble.a	b, c, end_addr_7
	move.a	c, b
end_addr_7
	subr.a	b, a
	bcc	continue_7_2
	bra.3	dump_done
continue_7_2
	move.a	a, r2

	bbs	#sGX, st, gx_dump_rom_7
	bsr.3	copy_prog
	move.5	#sx_prog_high, c.p
	jsr	sx_GosubHidC
	bsr.3	copy_prog
	bra.3	dump_done

gx_dump_rom_7
	;
	; unconfigure devices at 7e000 - 7ffff
	;
	move.5	#$7f000, c.p
	uncnfg
	move.5	#$7e000, c.p
	uncnfg

	bsr.3	prog_start

	;
	; reconfigure devices at 7e000 - 7ffff
	;
	move.5	#$ff000, c.p
	config
	move.5	#$7f000, c.p
	config
	move.5	#$ff000, c.p
	config
	move.5	#$7e000, c.p
	config

	move.5	#$80000, a.p
	move.a	a, r3

	;
	; dump ROM $80000 - $bffff
	;
dump_rom_8
	move.a	r3, a
	move.5	#$bfff0, c.p
	bgt.a	a, c, dump_rom_c
	move.a	a, r1

	move.a	r4, c
	move.a	c, b
	move.5	#$bfff0, c.p
	ble.a	b, c, end_addr_8
	move.a	c, b
end_addr_8
	subr.a	b, a
	bcc	continue_8_2
	bra.3	dump_done
continue_8_2
	move.a	a, r2

	bsr.3	copy_prog
	move.5	#gx_prog_high, c.p
	jsr	gx_GosubHidC
	bsr.3	copy_prog

	move.5	#$c0000, a.p
	move.a	a, r3

	;
	; dump ROM $c0000 - $fffff
	;
dump_rom_c
	move.a	r3, a
	move.a	a, r1

	move.a	r4, c
	move.a	c, b
	move.5	#$ffff0, c.p
	ble.a	b, c, end_addr_c
	move.a	c, b
end_addr_c
	subr.a	b, a
	bcs	dump_done
	move.a	a, r2

	bsr.3	copy_prog
	bset	#sHIGH, st
	jsr	gx_prog_low
	bsr.3	copy_prog

dump_done
	;
	; close IO
	;
	bsr.3	send_crnl
	move.5	#$00110, d1
	move.1	#0, a.p
	move.1	a, (d1)

	;
	; back to RPL
	;
	jsr	AllowIntr
	jmp	GETPTRLOOP

;
; exchange program with memory at address prog_low
;
copy_prog
	move.a	pc, c
prog_offset
	move.5	#prog_start-prog_offset, a.p
	add.a	a, c
	move.a	c, d0
	bbs	#sGX, st, gx_addr
	move.5	#sx_prog_low, d1
	bra.3	sx_addr
gx_addr
	move.5	#gx_prog_low, d1
sx_addr
	move.5	#prog_end-prog_start, a.p
	lsr.a	#4, a
	move.a	a, b

copy_word
	move.w	(d0), a
	move.w	(d1), c
	move.w	c, (d0)
	move.w	a, (d1)
	add.a	#16, d0
	add.a	#16, d1
	dec.a	b
	bcc	copy_word
	rtn

;
; this is the start of the actual dump routine
;
prog_start
	bbc	#sHIGH, st, skip_uncover_c
	;
	; uncover ROM at c0000 - fffff
	;
	move.5	#$7f000, d0
	move.b	(d0), c
	move.5	#gx_LINECOUNT, d0
	move.b	(d0), c
	bset	#7, c
	move.b	c, (d0)
	move.5	#$00128, d0
	move.b	c, (d0)
	move.5	#$c0000, c.p
	uncnfg
	uncnfg

skip_uncover_c
	;
	; get start address and number of words
	;
	move.a	r1, a
	move.a	a, d0
	move.a	r2, a

	;
	; dump the ROM
	;
loop
	move.a	a, r0
	bsr.3	send_addr
	move.2	#$3a, c.p
	bsr.3	send_char
        move.w	(d0), c
	bsr.3	send_data
	bsr.3	send_crnl

	add.a	#16, d0
	move.a	r0, a
	sub.a	#16, a
	bcc	loop

	bbc	#sHIGH, st, skip_cover_c
	;
	; reconfigure memory ports at c0000
	;
	move.5	#$c0000, c.p
	config
	config
	config
	config
	move.5	#gx_LINECOUNT, d0
	move.b	(d0), c
	bclr	#7, c
	move.b	c, (d0)
	move.5	#$00128, d0
	move.b	c, (d0)
	move.5	#$7f040, d0
	move.b	(d0), c

skip_cover_c
	rtn

;
; send data in C.W as hex characters
;
send_data
	move.w	c, b
	move.2	#$0f, c.p
	move.b	c, d
	bra.3	send_all
	
;
; send addr in D0 as hex characters
;
send_addr
	exg.a	a, d0
	move.a	a, c
	exg.a	a, d0
	exg.1	p, c.4
	exg.1	p, c.0
	exg.1	p, c.4
	exg.1	p, c.3
	exg.1	p, c.1
	exg.1	p, c.3
	move.a	c, b
	move.2	#$04, c.p
	move.b	c, d

;
; send D.B many nibbles from B.W
;
send_all
	clr.b	c
	move.p	b, c
	bsr.3	send_hex_nib
	lsr.w	#4, b
	dec.b	d
	bcc	send_all
	rtn

;
; send "\n\r"
;
send_crnl
	move.2	#$0d, c.p
	bsr.3	send_char
	move.2	#$0a, c.p
	bsr.3	send_char
	rtn

;
; send nibble in C.B as hex character
;
send_hex_nib
	move.2	#$30, a.p
	add.b	a, c
	move.2	#$39, a.p
	ble.b	c, a, send_char
	move.2	#$07, a.p
	add.b	a, c
;
; send character in C.B
;
send_char
	move.5	#$00112, d1
xmtrdy
	move.1	(d1), a
	bbs	#0, a, xmtrdy
	move.2	#$16, d1
	move.b	c, (d1)
	rtn

prog_end
	dcr.8	$00000000
	dcr.8	$00000000

code_end

	dcr.5	SEMI	; end of DISPATCH
	dcr.5	SEMI	; end of program object
