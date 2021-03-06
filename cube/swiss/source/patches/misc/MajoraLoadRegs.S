/*
MajoraLoadRegs.S for Nintendont (Kernel)

Copyright (C) 2015 FIX94

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation version 2.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*/

#include "../asm.h"
#define _LANGUAGE_ASSEMBLY
#include "../../../../reservedarea.h"

.set	AI_ADP_LOC,		VAR_STREAM_BUFLOC

.set	tmp,			28
.set	buf,			27
.set	loc,			26
.set	glob,			25
.set	cmpstrm,		5	#unused

#little ugly to save instruction
.globl MajoraLoadRegs
MajoraLoadRegs:
	beq		cmpstrm,end
	stw		loc,	AI_ADP_LOC(glob)
end:
	lwz		%r27,	0xC(%r1)
	lwz		%r26,	0x8(%r1)
	lwz		%r25,	0x4(%r1)
	addi	%r1,	%r1,	0x20
	blr

.globl MajoraLoadRegs_length
MajoraLoadRegs_length:
.long (MajoraLoadRegs_length - MajoraLoadRegs)
