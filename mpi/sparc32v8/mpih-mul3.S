/* SPARC v8 __mpn_submul_1 -- Multiply a limb vector with a limb and
 *                            subtract the result from a second limb vector.
 *
 *      Copyright (C) 1992, 1993, 1994, 1998, 
 *                    2001 Free Software Foundation, Inc.
 *       
 * This file is part of GnuPG.
 *
 * GnuPG is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * GnuPG is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, see <http://www.gnu.org/licenses/>.
 *
 * Note: This code is heavily based on the GNU MP Library.
 *	 Actually it's the same code with only minor changes in the
 *	 way the data is stored; this is to support the abstraction
 *	 of an optional secure memory allocation which may be used
 *	 to avoid revealing of sensitive data due to paging etc.
 *	 The GNU MP Library itself is published under the LGPL;
 *	 however I decided to publish this code under the plain GPL.
 */

        
! INPUT PARAMETERS
! res_ptr	o0
! s1_ptr	o1
! size		o2
! s2_limb	o3

#include "sysdep.h"

.text
	.align 4
	.global C_SYMBOL_NAME(mpihelp_submul_1)
C_SYMBOL_NAME(mpihelp_submul_1):
	sub	%g0,%o2,%o2		! negate ...
	sll	%o2,2,%o2		! ... and scale size
	sub	%o1,%o2,%o1		! o1 is offset s1_ptr
	sub	%o0,%o2,%g1		! g1 is offset res_ptr

	mov	0,%o0			! clear cy_limb

Loop:	ld	[%o1+%o2],%o4
	ld	[%g1+%o2],%g2
	umul	%o4,%o3,%o5
	rd	%y,%g3
	addcc	%o5,%o0,%o5
	addx	%g3,0,%o0
	subcc	%g2,%o5,%g2
	addx	%o0,0,%o0
	st	%g2,[%g1+%o2]

	addcc	%o2,4,%o2
	bne	Loop
	 nop

	retl
	 nop


