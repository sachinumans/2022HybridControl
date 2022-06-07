/* A Bison parser, made by GNU Bison 2.0.  */

/* Skeleton parser for Yacc-like parsing with Bison,
   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     NUM = 258,
     XIDENT = 259,
     SYSTEM = 260,
     INTERFACE = 261,
     IMPLEMENTATION = 262,
     IF = 263,
     ELSE = 264,
     THEN = 265,
     STATE = 266,
     INPUT = 267,
     OUTPUT = 268,
     PARAMETER = 269,
     MODULE = 270,
     AUX = 271,
     AD = 272,
     DA = 273,
     CONTINUOUS = 274,
     AUTOMATA = 275,
     MUST = 276,
     LOGIC = 277,
     LINEAR = 278,
     REAL = 279,
     BOOL = 280,
     INDEX = 281,
     TRUE = 282,
     FALSE = 283,
     EXP = 284,
     SQRT = 285,
     SIN = 286,
     COS = 287,
     TAN = 288,
     LOG = 289,
     LOG10 = 290,
     LOG2 = 291,
     ABS = 292,
     NORM_1 = 293,
     NORM_INF = 294,
     TRANSPOSE = 295,
     SUM = 296,
     ALL = 297,
     ANY = 298,
     INF = 299,
     FOR = 300,
     FLOOR = 301,
     CEIL = 302,
     ROUND = 303,
     LE = 304,
     leq = 305,
     GE = 306,
     geq = 307,
     NE = 308,
     neq = 309,
     EQ = 310,
     eq = 311,
     AR_FI = 312,
     AR_IF = 313,
     AR_IFF = 314,
     E_PROD = 315,
     E_DIV = 316,
     E_POW = 317,
     OR = 318,
     or = 319,
     AND = 320,
     and = 321,
     UNARY = 322,
     SCAL = 328
   };
#endif
#define NUM 258
#define XIDENT 259
#define SYSTEM 260
#define INTERFACE 261
#define IMPLEMENTATION 262
#define IF 263
#define ELSE 264
#define THEN 265
#define STATE 266
#define INPUT 267
#define OUTPUT 268
#define PARAMETER 269
#define MODULE 270
#define AUX 271
#define AD 272
#define DA 273
#define CONTINUOUS 274
#define AUTOMATA 275
#define MUST 276
#define LOGIC 277
#define LINEAR 278
#define REAL 279
#define BOOL 280
#define INDEX 281
#define TRUE 282
#define FALSE 283
#define EXP 284
#define SQRT 285
#define SIN 286
#define COS 287
#define TAN 288
#define LOG 289
#define LOG10 290
#define LOG2 291
#define ABS 292
#define NORM_1 293
#define NORM_INF 294
#define TRANSPOSE 295
#define SUM 296
#define ALL 297
#define ANY 298
#define INF 299
#define FOR 300
#define FLOOR 301
#define CEIL 302
#define ROUND 303
#define LE 304
#define leq 305
#define GE 306
#define geq 307
#define NE 308
#define neq 309
#define EQ 310
#define eq 311
#define AR_FI 312
#define AR_IF 313
#define AR_IFF 314
#define E_PROD 315
#define E_DIV 316
#define E_POW 317
#define OR 318
#define or 319
#define AND 320
#define and 321
#define UNARY 322
#define SCAL 328




#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
#line 16 "hys.y"
typedef union YYSTYPE {
    int ival;
    double dval;  
    char *sval;
    void *vval;
} YYSTYPE;
/* Line 1534 of yacc.c.  */
#line 180 "hys.tab.h"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;



