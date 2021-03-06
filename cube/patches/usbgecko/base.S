#***************************************************************************
# USBGecko Patch launch pad
#
# We have 0x1800 bytes to play with at 0x80001800 (code+data)
#**************************************************************************
#define _LANGUAGE_ASSEMBLY
#include "../../reservedarea.h"

.section .text
	.globl _start, __main
_start:
	b		patched_memcpy			# void patched_memcpy(dst,src,size)
	b		patched_memcpy_dbg
	b		perform_read
	
	.globl dcache_flush_icache_inv
dcache_flush_icache_inv:
	clrlwi. 	5, 3, 27  # check for lower bits set in address
	beq 1f
	addi 		r4, r4, 0x20 
1:
	addi 		r4, r4, 0x1f
	srwi 		r4, r4, 5
	mtctr 		r4
2:
	dcbf 		r0, r3
	icbi		r0, r3		#todo kill this off
	addi 		r3, r3, 0x20
	bdnz 		2b
	sc
	sync
	isync
	blr
	
.globl patched_memcpy
patched_memcpy:
	mr		r4, r24
	cmpwi	r3, 0xF00
	bgt		redirecthandler
	blr
redirecthandler:
	li		r3, 0xF00
	blr
	
.globl patched_memcpy_dbg
patched_memcpy_dbg:
	mr		r4, r24
	rlwinm	r3, r3, 0, 16, 31
	cmpwi	r3, 0xF00
	addis	r3, r3, 0x8000
	bgt		redirecthandlerdbg
	blr
redirecthandlerdbg:
	li		r3, 0xF00
	blr

