#include "../asm.h"
#define _LANGUAGE_ASSEMBLY
#include "../../../../reservedarea.h"

.globl VIConfigureHook1
VIConfigureHook1:
	lis			%r4, VAR_AREA
	lhz			%r5, VAR_SAR_WIDTH (%r4)
	lbz			%r6, VAR_SAR_HEIGHT (%r4)
	lhz			%r7, 4 (%r3)
	lhz			%r8, 14 (%r3)
	mullw.		%r9, %r7, %r5
	bne			1f
	mr			%r7, %r8
1:	divwuo.		%r9, %r9, %r6
	bns			2f
	mr			%r9, %r5
2:	cmpw		%r9, %r7
	bgt			3f
	mr			%r9, %r7
3:	addi		%r9, %r9, 2
	clrrwi		%r9, %r9, 2
	bne			4f
	sth			%r9, 4 (%r3)
4:	sth			%r9, 20 (%r3)
	lha			%r7, 10 (%r3)
	subf		%r9, %r9, %r8
	srawi		%r9, %r9, 1
	adde		%r9, %r9, %r7
	clrrwi		%r9, %r9, 1
	sth			%r9, 18 (%r3)
	stw			%r3, VAR_RMODE (%r4)
	mfmsr		%r3
	rlwinm		%r4, %r3, 0, 17, 15
	extrwi		%r3, %r3, 1, 16
	mtmsr		%r4
	blr

.globl VIConfigureHook1_length
VIConfigureHook1_length:
.long (VIConfigureHook1_length - VIConfigureHook1)