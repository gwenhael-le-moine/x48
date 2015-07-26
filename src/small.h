/*
 *  This file is part of x48, an emulator of the HP-48sx Calculator.
 *  Copyright (C) 1994  Eddie C. Dost  (ecd@dressler.de)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/* $Log: small.h,v $
 * Revision 1.5  1995/01/11  18:20:01  ecd
 * major update to support HP48 G/GX
 *
 * Revision 1.4  1994/12/07  20:16:41  ecd
 * completed small font
 *
 * Revision 1.4  1994/12/07  20:16:41  ecd
 * completed small font
 *
 * Revision 1.3  1994/11/02  14:51:27  ecd
 * minor changes
 *
 * Revision 1.2  1994/10/06  16:28:03  ecd
 * changed char to unsigned
 *
 * Revision 1.1  1994/09/13  15:05:11  ecd
 * Initial revision
 *
 *
 * $Id: small.h,v 1.5 1995/01/11 18:20:01 ecd Exp ecd $
 */

#ifndef _SMALL_H
#define _SMALL_H 1

#define small_ascent 8
#define small_descent 4

#include "bitmaps/blank.h"

#include "bitmaps/hash.h"

#include "bitmaps/lbrace.h"

#include "bitmaps/rbrace.h"

#include "bitmaps/comma.h"

#include "bitmaps/slash.h"

#include "bitmaps/two.h"

#include "bitmaps/three.h"

#include "bitmaps/small_colon.h"

#include "bitmaps/A.h"

#include "bitmaps/B.h"

#include "bitmaps/C.h"

#include "bitmaps/D.h"

#include "bitmaps/E.h"

#include "bitmaps/F.h"

#include "bitmaps/G.h"

#include "bitmaps/H.h"

#include "bitmaps/I.h"

#include "bitmaps/J.h"

#include "bitmaps/K.h"

#include "bitmaps/L.h"

#include "bitmaps/M.h"

#include "bitmaps/N.h"

#include "bitmaps/O.h"

#include "bitmaps/P.h"

#include "bitmaps/Q.h"

#include "bitmaps/R.h"

#include "bitmaps/S.h"

#include "bitmaps/T.h"

#include "bitmaps/U.h"

#include "bitmaps/V.h"

#include "bitmaps/W.h"

#include "bitmaps/X.h"

#include "bitmaps/Y.h"

#include "bitmaps/Z.h"

#include "bitmaps/lbracket.h"

#include "bitmaps/rbracket.h"

#include "bitmaps/arrow.h"

#include "bitmaps/diff.h"

#include "bitmaps/integral.h"

#include "bitmaps/sigma.h"

#include "bitmaps/sqr.h"

#include "bitmaps/root.h"

#include "bitmaps/pow10.h"

#include "bitmaps/exp.h"

#include "bitmaps/under.h"

#include "bitmaps/prog.h"

#include "bitmaps/string.h"

#include "bitmaps/equal.h"

#include "bitmaps/nl.h"

#include "bitmaps/pi.h"

#include "bitmaps/angle.h"

#include "bitmaps/lcurly.h"

#include "bitmaps/rcurly.h"

#include "bitmaps/sqr_gx.h"

#include "bitmaps/root_gx.h"

#include "bitmaps/pow10_gx.h"

#include "bitmaps/exp_gx.h"

#include "bitmaps/parens_gx.h"

#include "bitmaps/hash_gx.h"

#include "bitmaps/bracket_gx.h"

#include "bitmaps/under_gx.h"

#include "bitmaps/prog_gx.h"

#include "bitmaps/quote_gx.h"

#include "bitmaps/curly_gx.h"

#include "bitmaps/colon_gx.h"

#include "bitmaps/angle_gx.h"

#include "bitmaps/pi_gx.h"

#include "bitmaps/nl_gx.h"

#include "bitmaps/comma_gx.h"

#include "bitmaps/arrow_gx.h"

#include "bitmaps/equal_gx.h"

typedef struct letter_t {
  unsigned int   w, h;
  unsigned char *bits;
} letter_t;

letter_t small_font[] = {
  { 0, 0, 0 },
  { nl_gx_width, nl_gx_height, nl_gx_bits },		/* \001 == \n gx */
  { comma_gx_width, comma_gx_height, comma_gx_bits },	/* \002 == comma gx */
  { arrow_gx_width, arrow_gx_height, arrow_gx_bits },	/* \003 == \-> gx */
  { equal_gx_width, equal_gx_height, equal_gx_bits },	/* \004 == equal gx */
  { pi_gx_width, pi_gx_height, pi_gx_bits },		/* \005 == pi gx */
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },	/* # 16 */
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { blank_width, blank_height, blank_bits },	/* # 32 */
  { 0, 0, 0 },
  { 0, 0, 0 },
  { hash_width, hash_height, hash_bits },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { lbrace_width, lbrace_height, lbrace_bits },
  { rbrace_width, rbrace_height, rbrace_bits },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { comma_width, comma_height, comma_bits },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { slash_width, slash_height, slash_bits },
  { 0, 0, 0 },	/* # 48 */
  { 0, 0, 0 },
  { two_width, two_height, two_bits },
  { three_width, three_height, three_bits },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { small_colon_width, small_colon_height, small_colon_bits },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { equal_width, equal_height, equal_bits },
  { 0, 0, 0 },
  { 0, 0, 0 },
  { 0, 0, 0 },	/* # 64 */
  { A_width, A_height, A_bits },
  { B_width, B_height, B_bits },
  { C_width, C_height, C_bits },
  { D_width, D_height, D_bits },
  { E_width, E_height, E_bits },
  { F_width, F_height, F_bits },
  { G_width, G_height, G_bits },
  { H_width, H_height, H_bits },
  { I_width, I_height, I_bits },
  { J_width, J_height, J_bits },
  { K_width, K_height, K_bits },
  { L_width, L_height, L_bits },
  { M_width, M_height, M_bits },
  { N_width, N_height, N_bits },
  { O_width, O_height, O_bits },
  { P_width, P_height, P_bits },	/* # 80 */
  { Q_width, Q_height, Q_bits },
  { R_width, R_height, R_bits },
  { S_width, S_height, S_bits },
  { T_width, T_height, T_bits },
  { U_width, U_height, U_bits },
  { V_width, V_height, V_bits },
  { W_width, W_height, W_bits },
  { X_width, X_height, X_bits },
  { Y_width, Y_height, Y_bits },
  { Z_width, Z_height, Z_bits },
  { lbracket_width, lbracket_height, lbracket_bits },
  { 0, 0, 0 },
  { rbracket_width, rbracket_height, rbracket_bits },
  { 0, 0, 0 },
  { under_width, under_height, under_bits },
  { 0, 0, 0 },	/* # 96 */
  { arrow_width, arrow_height, arrow_bits },		/* a == left arrow   */
  { diff_width, diff_height, diff_bits },		/* b == differential */
  { integral_width, integral_height, integral_bits },	/* c == integral */
  { sigma_width, sigma_height, sigma_bits },		/* d == sigma */
  { sqr_width, sqr_height, sqr_bits },			/* e == sqr */
  { root_width, root_height, root_bits },		/* f == root */
  { pow10_width, pow10_height, pow10_bits },		/* g == pow10 */
  { exp_width, exp_height, exp_bits },			/* h == exp */
  { prog_width, prog_height, prog_bits },		/* i == << >> */
  { string_width, string_height, string_bits },		/* j == " " */
  { nl_width, nl_height, nl_bits },			/* k == New Line */
  { pi_width, pi_height, pi_bits },			/* l == pi */
  { angle_width, angle_height, angle_bits },		/* m == angle */
  { sqr_gx_width, sqr_gx_height, sqr_gx_bits },		/* n == sqr gx */
  { root_gx_width, root_gx_height, root_gx_bits },	/* o == root gx */
  { pow10_gx_width, pow10_gx_height, pow10_gx_bits },	/* p == pow10 gx */
  { exp_gx_width, exp_gx_height, exp_gx_bits },		/* q == exp gx */
  { parens_gx_width, parens_gx_height, parens_gx_bits },/* r == ( ) gx */
  { hash_gx_width, hash_gx_height, hash_gx_bits },	/* s == # gx */
  { bracket_gx_width, bracket_gx_height, bracket_gx_bits }, /* t == [] gx */
  { under_gx_width, under_gx_height, under_gx_bits },	/* u == _ gx */
  { prog_gx_width, prog_gx_height, prog_gx_bits },	/* v == << >> gx */
  { quote_gx_width, quote_gx_height, quote_gx_bits },	/* w == " " gx */
  { curly_gx_width, curly_gx_height, curly_gx_bits },	/* x == {} gx */
  { colon_gx_width, colon_gx_height, colon_gx_bits },	/* y == :: gx */
  { angle_gx_width, angle_gx_height, angle_gx_bits },	/* z == angle gx */
  { lcurly_width, lcurly_height, lcurly_bits },
  { 0, 0, 0 },
  { rcurly_width, rcurly_height, rcurly_bits },
  { 0, 0, 0 },
  { 0, 0, 0 }
};

#endif /* !_SMALL_H */
