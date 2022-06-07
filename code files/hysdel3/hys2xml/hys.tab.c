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

/* Written by Richard Stallman by simplifying the original so called
   ``semantic'' parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Skeleton name.  */
#define YYSKELETON_NAME "yaxx.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0

/* If NAME_PREFIX is specified substitute the variables and functions
   names.  */

#define yyparse yyparse
#define yylex   yylex
#define yyerror yyerror
#define yylval  yylval
#define yytext  yytext
#define YYYAXX_XML  "yyyaxx.xml"
#define YYYAXX_DTD  "yyyaxx.dtd"
#define yychar  yychar
#define yydebug yydebug
#define yynerrs yynerrs


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




/* Copy the first part of user declarations.  */
#line 1 "hys.y"

/** yylex is called from the pure_parser. It cannot be a method. */
/* int yylex (YYSTYPE *lvalp, struct yyltype *llocp, lexer_input *l_in); */
#define YYERROR_VERBOSE
//#define yyerror(msg) yysmarterror(msg,yylloc.first_line) 
#include <stdio.h>


//void yysmarterror(const char * s, int line) {
//	printf("line %d: %s\n", line, s);
//} 



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
#line 16 "hys.y"
typedef union YYSTYPE {
    int ival;
    double dval;  
    char *sval;
    void *vval;
} YYSTYPE;
/* Line 193 of yacc.c.  */
#line 246 "hys.tab.c"
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */
#line 258 "hys.tab.c"

#if ! defined (yyoverflow) || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

#  define XML_ALLOC(X) malloc(X)
#  define XML_FREE(X) free(X)
# if YYSTACK_USE_ALLOCA
#  define YYSTACK_ALLOC alloca
# else
#  ifndef YYSTACK_USE_ALLOCA
#   if defined (alloca) || defined (_ALLOCA_H)
#    define YYSTACK_ALLOC alloca
#   else
#    ifdef __GNUC__
#     define YYSTACK_ALLOC __builtin_alloca
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning. */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
# else
#  if defined (__STDC__) || defined (__cplusplus)
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   define YYSIZE_T size_t
#  endif
#  define YYSTACK_ALLOC malloc
#  define YYSTACK_FREE free
# endif
#endif /* ! defined (yyoverflow) || YYERROR_VERBOSE */


#if (! defined (yyoverflow) \
     && (! defined (__cplusplus) \
	 || (YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  short yyss;
  char *yyxs; // Yijun Yu: for XML
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)
// Yijun Yu: for yyxs
/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (short) + sizeof (YYSTYPE))				\
     + sizeof(char *) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  register YYSIZE_T yyi;		\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (0)
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (0)

#endif

#if defined (__STDC__) || defined (__cplusplus)
   typedef signed char yysigned_char;
#else
   typedef short yysigned_char;
#endif

/* YYFINAL -- State number of the termination state. */
#define YYFINAL  5
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   2921

/* YYNTOKENS -- Number of terminals. */
#define YYNTOKENS  95
/* YYNNTS -- Number of nonterminals. */
#define YYNNTS  96
/* YYNRULES -- Number of rules. */
#define YYNRULES  327
/* YYNRULES -- Number of states. */
#define YYNSTATES  801

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   328

#define YYTRANSLATE(YYX) 						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const unsigned char yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    81,     2,     2,     2,     2,    79,     2,
      86,    87,    70,    69,    89,    68,     2,    71,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    90,    88,
      93,    67,    94,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    91,     2,    92,    72,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    84,    74,    85,    82,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    73,    75,    76,    77,    78,    80,    83
};

//#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const unsigned short yyprhs[] =
{
       0,     0,     3,    10,    15,    18,    20,    21,    23,    25,
      27,    29,    31,    37,    39,    42,    44,    46,    48,    50,
      52,    54,    56,    58,    63,    68,    73,    78,    83,    84,
      89,    99,   109,   119,   129,   139,   149,   159,   169,   171,
     174,   176,   179,   181,   184,   186,   189,   191,   194,   196,
     199,   203,   207,   211,   215,   219,   223,   227,   231,   234,
     238,   242,   246,   250,   252,   254,   256,   261,   268,   270,
     272,   276,   280,   284,   288,   292,   296,   299,   303,   307,
     311,   316,   321,   326,   331,   336,   341,   346,   351,   356,
     361,   366,   371,   376,   381,   386,   391,   395,   399,   403,
     407,   411,   415,   419,   423,   425,   429,   434,   439,   444,
     449,   454,   459,   464,   469,   474,   479,   484,   489,   494,
     499,   504,   509,   513,   517,   521,   525,   529,   533,   537,
     541,   547,   551,   555,   557,   559,   561,   563,   565,   567,
     569,   572,   574,   578,   580,   584,   586,   590,   592,   596,
     598,   602,   604,   608,   610,   614,   616,   620,   624,   628,
     630,   634,   637,   638,   642,   646,   650,   654,   657,   659,
     662,   666,   670,   672,   676,   678,   680,   685,   687,   691,
     693,   697,   699,   701,   705,   710,   712,   716,   720,   724,
     728,   732,   736,   740,   744,   748,   751,   756,   761,   766,
     771,   776,   781,   786,   791,   796,   801,   806,   811,   816,
     821,   826,   831,   833,   835,   837,   841,   845,   849,   853,
     857,   861,   865,   869,   873,   876,   879,   884,   889,   891,
     892,   894,   896,   900,   902,   906,   910,   912,   916,   918,
     922,   926,   930,   935,   937,   940,   944,   948,   952,   956,
     960,   964,   969,   971,   975,   980,   982,   985,   997,  1007,
    1017,  1029,  1031,  1035,  1040,  1042,  1045,  1050,  1052,  1056,
    1061,  1063,  1066,  1071,  1073,  1077,  1082,  1084,  1087,  1090,
    1095,  1098,  1103,  1108,  1113,  1118,  1125,  1132,  1139,  1146,
    1153,  1160,  1167,  1174,  1181,  1188,  1195,  1202,  1209,  1216,
    1223,  1230,  1239,  1248,  1257,  1266,  1268,  1272,  1276,  1280,
    1284,  1289,  1291,  1294,  1299,  1301,  1305,  1310,  1312,  1315,
    1320,  1322,  1326,  1331,  1333,  1336,  1341,  1346
};

/* YYRHS -- A `-1'-separated list of the rules' RHS. */
static const short yyrhs[] =
{
      96,     0,    -1,     5,   131,    84,    97,   100,    85,    -1,
       6,    84,    98,    85,    -1,    98,    99,    -1,    99,    -1,
      -1,   103,    -1,   104,    -1,   105,    -1,   106,    -1,   107,
      -1,     7,    84,   108,   101,    85,    -1,   102,    -1,   101,
     102,    -1,   182,    -1,   185,    -1,   165,    -1,   169,    -1,
     172,    -1,   175,    -1,   188,    -1,   178,    -1,    11,    84,
     117,    85,    -1,    12,    84,   118,    85,    -1,    13,    84,
     119,    85,    -1,    14,    84,   120,    85,    -1,    15,    84,
     121,    85,    -1,    -1,    16,    84,   122,    85,    -1,    45,
      86,   130,    67,   133,    87,    84,   173,    85,    -1,    45,
      86,   130,    67,   133,    87,    84,   166,    85,    -1,    45,
      86,   130,    67,   133,    87,    84,   170,    85,    -1,    45,
      86,   130,    67,   133,    87,    84,   186,    85,    -1,    45,
      86,   130,    67,   133,    87,    84,   183,    85,    -1,    45,
      86,   130,    67,   133,    87,    84,   179,    85,    -1,    45,
      86,   130,    67,   133,    87,    84,   176,    85,    -1,    45,
      86,   130,    67,   133,    87,    84,   189,    85,    -1,   123,
      -1,   117,   123,    -1,   124,    -1,   118,   124,    -1,   125,
      -1,   119,   125,    -1,   126,    -1,   120,   126,    -1,   127,
      -1,   121,   127,    -1,   128,    -1,   122,   128,    -1,    24,
     139,    88,    -1,    25,   140,    88,    -1,    24,   141,    88,
      -1,    25,   142,    88,    -1,    24,   143,    88,    -1,    25,
     144,    88,    -1,    24,   145,    88,    -1,    25,   146,    88,
      -1,   149,    88,    -1,   152,   151,    88,    -1,    24,   153,
      88,    -1,    25,   154,    88,    -1,    26,   155,    88,    -1,
       4,    -1,     4,    -1,     4,    -1,     4,    86,   133,    87,
      -1,     4,    86,   133,    89,   133,    87,    -1,     3,    -1,
     130,    -1,   132,    69,   132,    -1,   132,    68,   132,    -1,
     132,    70,   132,    -1,   132,    71,   132,    -1,   132,    72,
     132,    -1,    86,   132,    87,    -1,    68,   132,    -1,   132,
      60,   132,    -1,   132,    61,   132,    -1,   132,    62,   132,
      -1,    32,    86,   132,    87,    -1,    29,    86,   132,    87,
      -1,    31,    86,   132,    87,    -1,    33,    86,   132,    87,
      -1,    30,    86,   132,    87,    -1,    34,    86,   132,    87,
      -1,    41,    86,   132,    87,    -1,    37,    86,   132,    87,
      -1,    35,    86,   132,    87,    -1,    36,    86,   132,    87,
      -1,    38,    86,   132,    87,    -1,    39,    86,   132,    87,
      -1,    40,    86,   132,    87,    -1,    48,    86,   132,    87,
      -1,    47,    86,   132,    87,    -1,    46,    86,   132,    87,
      -1,   131,    69,   131,    -1,   131,    68,   131,    -1,   131,
      70,   131,    -1,   131,    71,   131,    -1,   131,    72,   131,
      -1,   131,    60,   131,    -1,   131,    61,   131,    -1,   131,
      62,   131,    -1,   131,    -1,    86,   131,    87,    -1,    32,
      86,   131,    87,    -1,    29,    86,   131,    87,    -1,    31,
      86,   131,    87,    -1,    33,    86,   131,    87,    -1,    30,
      86,   131,    87,    -1,    34,    86,   131,    87,    -1,    41,
      86,   131,    87,    -1,    37,    86,   131,    87,    -1,    35,
      86,   131,    87,    -1,    36,    86,   131,    87,    -1,    38,
      86,   131,    87,    -1,    39,    86,   131,    87,    -1,    40,
      86,   131,    87,    -1,    48,    86,   131,    87,    -1,    47,
      86,   131,    87,    -1,    46,    86,   131,    87,    -1,   131,
      69,   132,    -1,   131,    68,   132,    -1,   131,    70,   132,
      -1,   131,    71,   132,    -1,   131,    72,   132,    -1,   131,
      60,   132,    -1,   131,    61,   132,    -1,   131,    62,   132,
      -1,   135,    90,   137,    90,   136,    -1,   135,    90,   136,
      -1,    91,   159,    92,    -1,   132,    -1,   161,    -1,   132,
      -1,   134,    -1,   134,    -1,   134,    -1,   131,    -1,   131,
     158,    -1,   138,    -1,   139,    89,   138,    -1,   138,    -1,
     140,    89,   138,    -1,   138,    -1,   141,    89,   138,    -1,
     138,    -1,   142,    89,   138,    -1,   138,    -1,   143,    89,
     138,    -1,   138,    -1,   144,    89,   138,    -1,   147,    -1,
     145,    89,   147,    -1,   148,    -1,   146,    89,   148,    -1,
     129,    67,   156,    -1,   129,    67,   161,    -1,   131,    -1,
     131,    67,   161,    -1,   131,   158,    -1,    -1,   129,    67,
     157,    -1,   129,    67,   164,    -1,   131,    67,   157,    -1,
     131,    67,   164,    -1,   131,   158,    -1,   150,    -1,   149,
     150,    -1,   129,    67,   156,    -1,   129,    67,   157,    -1,
     129,    -1,   151,    89,   129,    -1,   129,    -1,   138,    -1,
     153,    89,   138,   158,    -1,   138,    -1,   154,    89,   138,
      -1,   130,    -1,   155,    89,   130,    -1,     3,    -1,   131,
      -1,    86,   131,    87,    -1,    86,    24,   157,    87,    -1,
     161,    -1,   156,    69,   156,    -1,   156,    68,   156,    -1,
     156,    70,   156,    -1,   156,    71,   156,    -1,   156,    72,
     156,    -1,   156,    60,   156,    -1,   156,    61,   156,    -1,
     156,    62,   156,    -1,    86,   156,    87,    -1,    68,   156,
      -1,    32,    86,   156,    87,    -1,    29,    86,   156,    87,
      -1,    31,    86,   156,    87,    -1,    33,    86,   156,    87,
      -1,    30,    86,   156,    87,    -1,    34,    86,   156,    87,
      -1,    41,    86,   156,    87,    -1,    37,    86,   156,    87,
      -1,    35,    86,   156,    87,    -1,    36,    86,   156,    87,
      -1,    38,    86,   156,    87,    -1,    39,    86,   156,    87,
      -1,    40,    86,   156,    87,    -1,    48,    86,   156,    87,
      -1,    47,    86,   156,    87,    -1,    46,    86,   156,    87,
      -1,    27,    -1,    28,    -1,   131,    -1,    86,   131,    87,
      -1,   157,    74,   157,    -1,   157,    63,   157,    -1,   157,
      79,   157,    -1,   157,    65,   157,    -1,   157,    58,   157,
      -1,   157,    57,   157,    -1,   157,    59,   157,    -1,    86,
     157,    87,    -1,    82,   157,    -1,    81,   157,    -1,    43,
      86,   157,    87,    -1,    42,    86,   157,    87,    -1,   164,
      -1,    -1,   161,    -1,   156,    -1,   156,    89,   159,    -1,
     159,    -1,   160,    88,   159,    -1,    91,   160,    92,    -1,
     157,    -1,   157,    89,   162,    -1,   162,    -1,   163,    88,
     162,    -1,    91,   163,    92,    -1,    17,    84,    85,    -1,
      17,    84,   166,    85,    -1,   168,    -1,   166,   168,    -1,
     156,    93,   156,    -1,   156,    94,   156,    -1,   156,    49,
     156,    -1,   156,    51,   156,    -1,   156,    55,   156,    -1,
      86,   167,    87,    -1,   131,    67,   167,    88,    -1,   110,
      -1,    18,    84,    85,    -1,    18,    84,   170,    85,    -1,
     171,    -1,   170,   171,    -1,   131,    67,    84,     8,   157,
      10,   156,     9,   156,    85,    88,    -1,   131,    67,    84,
       8,   157,    10,   156,    85,    88,    -1,   131,    67,    84,
       8,   167,    10,   156,    85,    88,    -1,   131,    67,    84,
       8,   167,    10,   156,     9,   156,    85,    88,    -1,   111,
      -1,    19,    84,    85,    -1,    19,    84,   173,    85,    -1,
     174,    -1,   173,   174,    -1,   131,    67,   156,    88,    -1,
     109,    -1,    20,    84,    85,    -1,    20,    84,   176,    85,
      -1,   177,    -1,   176,   177,    -1,   131,    67,   157,    88,
      -1,   115,    -1,    21,    84,    85,    -1,    21,    84,   179,
      85,    -1,   180,    -1,   179,   180,    -1,   181,    88,    -1,
      86,   181,    87,    88,    -1,   157,    88,    -1,   157,    58,
     157,    88,    -1,   157,    57,   157,    88,    -1,   157,    59,
     157,    88,    -1,   157,    55,   157,    88,    -1,    86,   181,
      87,    74,   157,    88,    -1,    86,   181,    87,    63,   157,
      88,    -1,    86,   181,    87,    79,   157,    88,    -1,    86,
     181,    87,    65,   157,    88,    -1,   157,    74,    86,   181,
      87,    88,    -1,   157,    63,    86,   181,    87,    88,    -1,
     157,    79,    86,   181,    87,    88,    -1,   157,    65,    86,
     181,    87,    88,    -1,    86,   181,    87,    58,   157,    88,
      -1,    86,   181,    87,    57,   157,    88,    -1,    86,   181,
      87,    59,   157,    88,    -1,    86,   181,    87,    55,   157,
      88,    -1,   157,    58,    86,   181,    87,    88,    -1,   157,
      57,    86,   181,    87,    88,    -1,   157,    59,    86,   181,
      87,    88,    -1,   157,    55,    86,   181,    87,    88,    -1,
      86,   181,    87,    58,    86,   181,    87,    88,    -1,    86,
     181,    87,    57,    86,   181,    87,    88,    -1,    86,   181,
      87,    59,    86,   181,    87,    88,    -1,    86,   181,    87,
      55,    86,   181,    87,    88,    -1,   114,    -1,   156,    49,
     156,    -1,   156,    51,   156,    -1,   156,    55,   156,    -1,
      22,    84,    85,    -1,    22,    84,   183,    85,    -1,   184,
      -1,   183,   184,    -1,   131,    67,   157,    88,    -1,   113,
      -1,    23,    84,    85,    -1,    23,    84,   186,    85,    -1,
     187,    -1,   186,   187,    -1,   131,    67,   156,    88,    -1,
     112,    -1,    13,    84,    85,    -1,    13,    84,   189,    85,
      -1,   190,    -1,   189,   190,    -1,   131,    67,   156,    88,
      -1,   131,    67,   157,    88,    -1,   116,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const unsigned short yyrline[] =
{
       0,    85,    85,    88,    91,    92,    93,    97,    98,    99,
     100,   101,   105,   108,   109,   112,   113,   114,   115,   116,
     117,   118,   119,   122,   124,   126,   128,   130,   133,   134,
     137,   140,   143,   146,   149,   152,   155,   158,   166,   167,
     169,   170,   172,   173,   175,   176,   178,   179,   181,   182,
     185,   186,   188,   189,   191,   192,   194,   195,   196,   199,
     202,   203,   204,   208,   215,   218,   219,   220,   224,   225,
     226,   227,   228,   229,   230,   231,   232,   233,   234,   235,
     236,   237,   238,   239,   240,   241,   242,   243,   244,   245,
     246,   247,   248,   249,   250,   251,   252,   253,   254,   255,
     256,   257,   258,   259,   260,   261,   262,   263,   264,   265,
     266,   267,   268,   269,   270,   271,   272,   273,   274,   275,
     276,   277,   278,   279,   280,   281,   282,   283,   284,   285,
     294,   295,   296,   297,   298,   304,   308,   312,   316,   323,
     324,   328,   329,   333,   334,   338,   339,   343,   344,   348,
     349,   353,   354,   359,   360,   362,   363,   366,   367,   368,
     369,   370,   373,   374,   375,   376,   377,   378,   382,   383,
     387,   388,   392,   393,   397,   400,   401,   404,   405,   408,
     409,   415,   417,   418,   419,   420,   421,   422,   423,   424,
     425,   426,   427,   428,   429,   430,   431,   432,   433,   434,
     435,   436,   437,   438,   439,   440,   441,   442,   443,   444,
     445,   446,   454,   455,   456,   457,   458,   459,   460,   461,
     462,   463,   464,   465,   466,   467,   468,   469,   470,   478,
     479,   483,   484,   488,   489,   493,   497,   498,   502,   503,
     507,   516,   517,   521,   522,   526,   527,   528,   529,   530,
     531,   535,   536,   543,   544,   548,   549,   553,   554,   555,
     556,   557,   564,   565,   568,   569,   573,   574,   579,   580,
     583,   584,   587,   588,   595,   596,   599,   600,   604,   605,
     606,   607,   608,   609,   610,   611,   612,   613,   614,   615,
     616,   617,   618,   619,   620,   621,   622,   623,   624,   625,
     626,   627,   628,   629,   630,   631,   635,   636,   637,   642,
     643,   647,   648,   651,   652,   657,   658,   661,   662,   665,
     666,   671,   672,   676,   677,   681,   682,   683
};
//#endif

//#if YYDEBUG || YYERROR_VERBOSE
/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "NUM", "XIDENT", "SYSTEM", "INTERFACE",
  "IMPLEMENTATION", "IF", "ELSE", "THEN", "STATE", "INPUT", "OUTPUT",
  "PARAMETER", "MODULE", "AUX", "AD", "DA", "CONTINUOUS", "AUTOMATA",
  "MUST", "LOGIC", "LINEAR", "REAL", "BOOL", "INDEX", "TRUE", "FALSE",
  "EXP", "SQRT", "SIN", "COS", "TAN", "LOG", "LOG10", "LOG2", "ABS",
  "NORM_1", "NORM_INF", "TRANSPOSE", "SUM", "ALL", "ANY", "INF", "FOR",
  "FLOOR", "CEIL", "ROUND", "LE", "leq", "GE", "geq", "NE", "neq", "EQ",
  "eq", "AR_FI", "AR_IF", "AR_IFF", "E_PROD", "E_DIV", "E_POW", "OR", "or",
  "AND", "and", "'='", "'-'", "'+'", "'*'", "'/'", "'^'", "UNARY", "'|'",
  "\"||\"", "\"<-\"", "\"->\"", "\"<->\"", "'&'", "\"&&\"", "'!'", "'~'",
  "SCAL", "'{'", "'}'", "'('", "')'", "';'", "','", "':'", "'['", "']'",
  "'<'", "'>'", "$accept", "system", "interface", "interface_list_t",
  "interface_item_t", "implementation_t", "section_list_t", "section_t",
  "state_interface_t", "input_interface_t", "output_interface_t",
  "parameter_interface_t", "module_interface_t", "aux_impl_t",
  "continuous_for_t", "AD_for_t", "DA_for_t", "linear_for_t",
  "logic_for_t", "must_for_t", "automata_for_t", "output_for_t",
  "state_decl_list_t", "input_decl_list_t", "output_decl_list_t",
  "parameter_decl_list_t", "module_decl_list_t", "aux_decl_list_t",
  "state_decl_t", "input_decl_t", "output_decl_t", "parameter_decl_t",
  "module_decl_t", "aux_decl_t", "ident_t", "iterator_ident_t",
  "indexed_ident_t", "index_expr_t", "cycle_item_t", "cycle_index_num",
  "cycle_index_lower_t", "cycle_index_upper_t", "cycle_index_inc_t",
  "ios_ident_t", "state_real_ident_list_t", "state_bool_ident_list_t",
  "input_real_ident_list_t", "input_bool_ident_list_t",
  "output_real_ident_list_t", "output_bool_ident_list_t",
  "parameter_real_ident_list_t", "parameter_bool_ident_list_t",
  "parameter_real_ident_t", "parameter_bool_ident_t",
  "module_parameter_list_t", "module_parameter_t", "module_ident_t",
  "module_name_t", "aux_real_ident_list_t", "aux_bool_ident_list_t",
  "aux_index_ident_list_t", "real_expr_t", "logic_expr_t",
  "opt_var_minmax_t", "row_t", "rows_t", "matrix_t", "row_bool_t",
  "rows_bool_t", "matrix_bool_t", "AD_section_t", "AD_list_t",
  "real_cond_t", "AD_item_t", "DA_section_t", "DA_list_t", "DA_item_t",
  "continuous_section_t", "continuous_list_t", "continuous_item_t",
  "automata_section_t", "automata_list_t", "automata_item_t",
  "must_section_t", "must_list_t", "must_item_t", "must_affine_t",
  "logic_section_t", "logic_list_t", "logic_item_t", "linear_section_t",
  "linear_list_t", "linear_item_t", "output_section_t", "output_list_t",
  "output_item_t", 0
};
//#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const unsigned short yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,    61,    45,    43,
      42,    47,    94,   322,   124,   323,   324,   325,   326,    38,
     327,    33,   126,   328,   123,   125,    40,    41,    59,    44,
      58,    91,    93,    60,    62
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const unsigned char yyr1[] =
{
       0,    95,    96,    97,    98,    98,    98,    99,    99,    99,
      99,    99,   100,   101,   101,   102,   102,   102,   102,   102,
     102,   102,   102,   103,   104,   105,   106,   107,   108,   108,
     109,   110,   111,   112,   113,   114,   115,   116,   117,   117,
     118,   118,   119,   119,   120,   120,   121,   121,   122,   122,
     123,   123,   124,   124,   125,   125,   126,   126,   126,   127,
     128,   128,   128,   129,   130,   131,   131,   131,   132,   132,
     132,   132,   132,   132,   132,   132,   132,   132,   132,   132,
     132,   132,   132,   132,   132,   132,   132,   132,   132,   132,
     132,   132,   132,   132,   132,   132,   132,   132,   132,   132,
     132,   132,   132,   132,   132,   132,   132,   132,   132,   132,
     132,   132,   132,   132,   132,   132,   132,   132,   132,   132,
     132,   132,   132,   132,   132,   132,   132,   132,   132,   132,
     133,   133,   133,   133,   133,   134,   135,   136,   137,   138,
     138,   139,   139,   140,   140,   141,   141,   142,   142,   143,
     143,   144,   144,   145,   145,   146,   146,   147,   147,   147,
     147,   147,   148,   148,   148,   148,   148,   148,   149,   149,
     150,   150,   151,   151,   152,   153,   153,   154,   154,   155,
     155,   156,   156,   156,   156,   156,   156,   156,   156,   156,
     156,   156,   156,   156,   156,   156,   156,   156,   156,   156,
     156,   156,   156,   156,   156,   156,   156,   156,   156,   156,
     156,   156,   157,   157,   157,   157,   157,   157,   157,   157,
     157,   157,   157,   157,   157,   157,   157,   157,   157,   158,
     158,   159,   159,   160,   160,   161,   162,   162,   163,   163,
     164,   165,   165,   166,   166,   167,   167,   167,   167,   167,
     167,   168,   168,   169,   169,   170,   170,   171,   171,   171,
     171,   171,   172,   172,   173,   173,   174,   174,   175,   175,
     176,   176,   177,   177,   178,   178,   179,   179,   180,   180,
     180,   180,   180,   180,   180,   180,   180,   180,   180,   180,
     180,   180,   180,   180,   180,   180,   180,   180,   180,   180,
     180,   180,   180,   180,   180,   180,   181,   181,   181,   182,
     182,   183,   183,   184,   184,   185,   185,   186,   186,   187,
     187,   188,   188,   189,   189,   190,   190,   190
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const unsigned char yyr2[] =
{
       0,     2,     6,     4,     2,     1,     0,     1,     1,     1,
       1,     1,     5,     1,     2,     1,     1,     1,     1,     1,
       1,     1,     1,     4,     4,     4,     4,     4,     0,     4,
       9,     9,     9,     9,     9,     9,     9,     9,     1,     2,
       1,     2,     1,     2,     1,     2,     1,     2,     1,     2,
       3,     3,     3,     3,     3,     3,     3,     3,     2,     3,
       3,     3,     3,     1,     1,     1,     4,     6,     1,     1,
       3,     3,     3,     3,     3,     3,     2,     3,     3,     3,
       4,     4,     4,     4,     4,     4,     4,     4,     4,     4,
       4,     4,     4,     4,     4,     4,     3,     3,     3,     3,
       3,     3,     3,     3,     1,     3,     4,     4,     4,     4,
       4,     4,     4,     4,     4,     4,     4,     4,     4,     4,
       4,     4,     3,     3,     3,     3,     3,     3,     3,     3,
       5,     3,     3,     1,     1,     1,     1,     1,     1,     1,
       2,     1,     3,     1,     3,     1,     3,     1,     3,     1,
       3,     1,     3,     1,     3,     1,     3,     3,     3,     1,
       3,     2,     0,     3,     3,     3,     3,     2,     1,     2,
       3,     3,     1,     3,     1,     1,     4,     1,     3,     1,
       3,     1,     1,     3,     4,     1,     3,     3,     3,     3,
       3,     3,     3,     3,     3,     2,     4,     4,     4,     4,
       4,     4,     4,     4,     4,     4,     4,     4,     4,     4,
       4,     4,     1,     1,     1,     3,     3,     3,     3,     3,
       3,     3,     3,     3,     2,     2,     4,     4,     1,     0,
       1,     1,     3,     1,     3,     3,     1,     3,     1,     3,
       3,     3,     4,     1,     2,     3,     3,     3,     3,     3,
       3,     4,     1,     3,     4,     1,     2,    11,     9,     9,
      11,     1,     3,     4,     1,     2,     4,     1,     3,     4,
       1,     2,     4,     1,     3,     4,     1,     2,     2,     4,
       2,     4,     4,     4,     4,     6,     6,     6,     6,     6,
       6,     6,     6,     6,     6,     6,     6,     6,     6,     6,
       6,     8,     8,     8,     8,     1,     3,     3,     3,     3,
       4,     1,     2,     4,     1,     3,     4,     1,     2,     4,
       1,     3,     4,     1,     2,     4,     4,     1
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const unsigned short yydefact[] =
{
       0,     0,     0,    65,     0,     1,     0,     0,    68,    64,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,    69,
     104,   133,     0,   136,     0,   134,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,    76,     0,     0,   181,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,   182,   231,   233,
       0,   185,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,    66,     0,
       0,     6,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,   105,    75,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,   195,     0,   182,     0,   233,     0,
       0,     0,     0,     0,     0,     0,     0,     0,   132,     0,
     235,   101,   127,   102,   128,   103,   129,    97,   123,    96,
     122,    98,   124,    99,   125,   100,   126,    77,    78,    79,
      71,    70,    72,    73,    74,     0,   135,   137,   131,     0,
       0,     0,     0,     0,     0,     0,     5,     7,     8,     9,
      10,    11,    28,     2,   107,    81,   110,    84,   108,    82,
     106,    80,   109,    83,   111,    85,   114,    88,   115,    89,
     113,    87,   116,    90,   117,    91,   118,    92,   112,    86,
     121,    95,   120,    94,   119,    93,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   212,   213,     0,     0,     0,     0,     0,     0,
     214,     0,   228,   183,   194,   191,   192,   193,   187,   186,
     188,   189,   190,   232,   234,    67,     0,     0,     0,     0,
       0,     0,     3,     4,     0,     0,   197,   200,   198,   196,
     199,   201,   204,   205,   203,   206,   207,   208,   202,   211,
     210,   209,     0,     0,   225,   224,   214,     0,   236,   238,
       0,     0,     0,     0,     0,     0,     0,     0,   184,   137,
     130,     0,     0,     0,    38,     0,     0,     0,    40,     0,
       0,     0,    42,    63,     0,   162,     0,    44,     0,     0,
     168,     0,    46,   174,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    13,    17,    18,    19,    20,
      22,    15,    16,    21,     0,     0,   215,   223,     0,     0,
     240,   221,   220,   222,   217,   219,   216,   218,   139,   141,
       0,   143,     0,    23,    39,   145,     0,   147,     0,    24,
      41,   149,     0,   151,     0,    25,    43,    65,     0,   159,
       0,   153,     0,   229,     0,   155,    26,    45,     0,    58,
     169,    27,    47,   172,     0,     0,     0,     0,     0,    48,
       0,     0,     0,     0,     0,     0,     0,     0,    12,    14,
     227,   226,   237,   239,   140,   230,    50,     0,    51,     0,
      52,     0,    53,     0,    54,     0,    55,     0,     0,     0,
     161,    56,     0,     0,     0,   167,    57,   162,     0,     0,
     182,   170,   171,    59,     0,   175,     0,   177,     0,    64,
     179,     0,    29,    49,     0,   321,   327,     0,     0,   323,
       0,   241,   252,     0,     0,   243,     0,   253,   261,     0,
       0,   255,     0,   262,   267,     0,     0,   264,     0,   268,
     273,     0,     0,   270,     0,   274,     0,   305,     0,     0,
       0,   276,     0,     0,   309,   314,     0,     0,   311,     0,
     315,   320,     0,     0,   317,   142,   144,   146,   148,   150,
     152,   157,   185,   160,   154,   163,   228,   165,   228,   156,
     182,   173,    60,     0,    61,     0,    62,     0,     0,     0,
     322,   324,     0,     0,   242,   244,     0,     0,   254,   256,
       0,     0,   263,   265,     0,     0,   269,   271,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,   280,   275,   277,   278,     0,     0,   310,   312,
       0,     0,   316,   318,   183,   229,   178,   180,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,   306,   307,   308,     0,     0,     0,   221,
       0,   220,     0,   222,     0,     0,     0,     0,     0,     0,
       0,     0,   176,     0,   325,   326,     0,     0,     0,     0,
       0,     0,     0,     0,   251,     0,     0,     0,   266,     0,
     272,     0,     0,     0,     0,     0,     0,     0,     0,     0,
     279,   182,     0,   284,     0,   282,     0,   281,     0,   283,
       0,     0,     0,     0,     0,   313,     0,   319,     0,     0,
     250,   247,   248,   249,   245,   246,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,   296,     0,   294,     0,   293,     0,
     295,   286,   288,   285,   287,   300,   298,   297,   299,   290,
     292,   289,   291,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,     0,     0,   304,
     302,   301,   303,     0,     0,    37,    31,    32,     0,   258,
       0,   259,    30,    36,    35,    34,    33,     0,     0,   257,
     260
};

/* YYDEFGOTO[NTERM-NUM]. */
static const short yydefgoto[] =
{
      -1,     2,    37,   205,   206,   103,   364,   365,   207,   208,
     209,   210,   211,   295,   504,   492,   498,   531,   525,   517,
     510,   486,   333,   337,   341,   346,   351,   428,   334,   338,
     342,   347,   352,   429,   348,    29,    77,    31,    32,    33,
      34,   198,   199,   389,   390,   392,   396,   398,   402,   404,
     410,   414,   411,   415,   349,   350,   424,   354,   476,   478,
     481,   518,   317,   444,   158,    80,    81,   319,   320,   272,
     366,   494,   648,   495,   367,   500,   501,   368,   506,   507,
     369,   512,   513,   370,   520,   521,   522,   371,   527,   528,
     372,   533,   534,   373,   488,   489
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -546
static const short yypact[] =
{
       7,    25,    55,   -28,   -17,  -546,   761,    66,  -546,   -28,
      -6,    72,   100,   110,   118,   137,   184,   193,   221,   241,
     254,   266,   270,   288,   311,   315,  1575,  1575,  1471,  -546,
    1357,   452,   213,  -546,    22,  -546,   159,   290,  1575,  1575,
    1575,  1575,  1575,  1575,  1575,  1575,  1575,  1575,  1575,  1575,
    1575,  1575,  1575,  1575,   133,  1960,  1980,  -546,   317,   321,
     323,   332,   353,   363,   367,   369,   371,   374,   383,   388,
     410,   417,   445,   447,  1471,  1367,  1471,  -546,  1465,   258,
     -64,  -546,  1575,  1575,  1575,  1575,  1575,  1575,  1575,  1575,
    1575,  1575,  1575,  1575,  1575,  1575,  1575,  1575,  -546,   761,
    1575,   567,   344,   404,  1993,  2013,  2026,  2046,  2059,  2079,
    2092,  2112,  2125,  2145,  2158,  2178,  2191,  2211,  2224,  2244,
    2257,  2277,  2290,  2310,  2323,  2343,  2356,  2376,  2389,  2409,
    2422,  2442,  2455,  2475,  2488,  2508,  -546,  -546,  1471,  1471,
    1471,  1471,  1471,  1471,  1471,  1471,  1471,  1471,  1471,  1471,
    1471,  1471,  1471,  1471,   147,   217,   354,  2521,  -546,  1471,
    1471,  1471,  1471,  1471,  1471,  1471,  1471,  1471,  -546,  1471,
    -546,  1357,  2836,  1357,  2836,  1357,  2836,   301,   762,   301,
     762,   456,   488,   456,   488,   328,   133,  2836,  2836,  2836,
     762,   762,   488,   488,   133,   440,  2836,   461,  -546,   463,
     471,   477,   485,   508,   517,   199,  -546,  -546,  -546,  -546,
    -546,  -546,   547,  -546,  -546,  -546,  -546,  -546,  -546,  -546,
    -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,
    -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,
    -546,  -546,  -546,  -546,  -546,  -546,  2541,  2554,  2574,  2587,
    2607,  2620,  2640,  2653,  2673,  2686,  2706,  2719,  2739,  2752,
    2772,  2785,  -546,  -546,   486,   534,   217,   217,   217,   217,
    -546,  1165,  -546,  -546,  -546,  2849,  2849,  2849,   835,   835,
     504,   504,   147,  -546,  -546,  -546,  1575,   166,   264,   268,
     342,   599,  -546,  -546,   537,   944,  -546,  -546,  -546,  -546,
    -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,
    -546,  -546,   217,   217,   715,   715,   518,  1834,  1403,  -546,
      68,   217,   217,   217,   217,   217,   217,   217,  -546,  -546,
    -546,    25,    25,   115,  -546,    25,    25,   157,  -546,    25,
      25,   291,  -546,  -546,   620,   620,    29,  -546,   559,    13,
    -546,    53,  -546,  -546,   599,   397,   544,   546,   548,   555,
     560,   562,   564,   566,   458,  -546,  -546,  -546,  -546,  -546,
    -546,  -546,  -546,  -546,  1837,  1860,  -546,  -546,   217,   217,
    -546,  1310,  1310,  1310,  1310,  1310,   425,   715,   552,  -546,
     230,  -546,   304,  -546,  -546,  -546,   327,  -546,   338,  -546,
    -546,  -546,   376,  -546,   384,  -546,  -546,   117,   585,   -32,
     403,  -546,   586,    51,   406,  -546,  -546,  -546,  1238,  -546,
    -546,  -546,  -546,  -546,   412,    25,    25,   653,   280,  -546,
      15,    17,    18,    19,    23,   842,    28,    30,  -546,  -546,
    -546,  -546,  -546,  -546,  -546,  -546,  -546,    25,  -546,    25,
    -546,    25,  -546,    25,  -546,    25,  -546,    25,  1471,   552,
    -546,  -546,   620,   217,   217,  -546,  -546,   620,  1040,  1238,
    1406,  2849,  1310,  -546,   599,  -546,   441,  -546,   479,  -546,
    -546,   505,  -546,  -546,   588,  -546,  -546,   611,    32,  -546,
     593,  -546,  -546,   613,    52,  -546,   596,  -546,  -546,   617,
      61,  -546,   604,  -546,  -546,   624,    74,  -546,   606,  -546,
    -546,   626,   116,  -546,   608,  -546,  1040,  -546,  2831,   756,
     908,  -546,   607,   615,  -546,  -546,   630,   140,  -546,   619,
    -546,  -546,   636,   201,  -546,  -546,  -546,  -546,  -546,  -546,
    -546,  2849,   509,  -546,  -546,  1310,   519,  1310,   521,  -546,
    1870,  -546,  -546,    25,  -546,    25,  -546,   653,   653,  1238,
    -546,  -546,   653,  1512,  -546,  -546,   653,   623,  -546,  -546,
     653,  1471,  -546,  -546,   653,   217,  -546,  -546,   653,  1631,
     628,  1471,  1471,  1471,   305,   356,   416,   595,   645,   671,
     822,   888,  -546,  -546,  -546,  -546,   653,   217,  -546,  -546,
     653,  1471,  -546,  -546,  1510,   552,  -546,  -546,   655,  1913,
    1507,   656,  1408,  1604,   637,   657,   708,   662,  1926,   663,
    1652,   665,  1649,  2849,  2849,  2849,  1238,  1662,  1238,  1686,
    1238,  1689,  1238,  1699,  1238,  1238,  1238,  1238,   666,  1723,
     668,  1947,  -546,   761,  -546,  -546,   761,  1576,   658,  1471,
    1471,  1471,  1471,  1471,  -546,   761,  1304,   761,  -546,   761,
    -546,   761,   954,  1020,  1086,  1152,   217,   217,   217,   217,
    -546,  1893,   659,  -546,   660,  -546,   661,  -546,   664,  -546,
     676,   684,   692,   694,   761,  -546,   761,  -546,   697,   699,
    -546,  2849,  2849,  2849,  2849,  2849,   701,  1106,  1561,   732,
     702,   716,   717,  1238,  1726,  1238,  1736,  1238,  1760,  1238,
    1763,  1773,  1797,  1800,  1810,   670,   718,   722,   724,   730,
     739,   743,   748,   733,   751,   721,   758,   764,  1471,  1471,
     767,   769,   770,   753,  -546,   768,  -546,   771,  -546,   772,
    -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,
    -546,  -546,  -546,   773,   777,    16,    26,    62,  1227,  1293,
     144,   153,  1172,   775,   779,   798,   803,   306,   313,   211,
     297,   309,  1471,   805,  1471,   806,   310,   355,   974,  -546,
    -546,  -546,  -546,   360,   366,  -546,  -546,  -546,   649,  -546,
    2805,  -546,  -546,  -546,  -546,  -546,  -546,   810,   811,  -546,
    -546
};

/* YYPGOTO[NTERM-NUM].  */
static const short yypgoto[] =
{
    -546,  -546,  -546,  -546,   538,  -546,  -546,   385,  -546,  -546,
    -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,
    -546,  -546,  -546,  -546,  -546,  -546,  -546,  -546,   523,   413,
     561,   554,   550,   481,  -275,  -221,    -1,    83,   -84,   -89,
    -546,   631,  -546,   -45,  -546,  -546,  -546,  -546,  -546,  -546,
    -546,  -546,   457,   451,  -546,   565,  -546,  -546,  -546,  -546,
    -546,    88,   -50,  -403,   -14,  -546,   182,   107,  -546,    81,
    -546,   164,  -545,  -492,  -546,   165,  -491,  -546,   161,  -493,
    -546,   168,  -508,  -546,   163,  -517,  -485,  -546,   167,  -519,
    -546,   158,  -526,  -546,   177,  -487
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -216
static const short yytable[] =
{
       4,   561,   565,   594,   577,    30,   460,   603,   599,   569,
     465,   197,     1,   573,    79,   195,   353,   343,   614,     3,
       3,     3,     3,     3,   169,    30,    55,     3,   170,     3,
       3,   580,     3,   343,     3,   459,     3,   104,   106,   108,
     110,   112,   114,   116,   118,   120,   122,   124,   126,   128,
     130,   132,   134,   344,   345,     5,     3,   343,     6,    76,
     484,   484,   490,   496,   502,     3,     3,     7,   508,   408,
     412,   490,    36,   523,   156,   529,   353,   484,     3,   423,
      38,   171,   173,   175,   177,   179,   181,   183,   185,    30,
      30,    30,    30,    30,    30,    30,    30,   490,    30,    30,
     485,   419,   491,   497,   503,   271,   496,   496,   509,    54,
      56,   699,   100,   524,   416,   530,    78,   560,   464,   502,
       3,   105,   107,   109,   111,   113,   115,   117,   119,   121,
     123,   125,   127,   129,   131,   133,   135,   564,   421,   331,
     332,   672,    76,   674,     3,   676,   568,   678,     3,   680,
     681,   682,   683,   283,   270,   284,   379,     3,    39,   572,
     380,   508,   154,   157,    78,   172,   174,   176,   178,   180,
     182,   184,   186,   187,   188,   189,   190,   191,   192,   193,
     194,   335,   336,   196,   -63,   523,    40,   408,    35,   502,
     331,   332,   412,    90,    91,    92,    41,   329,   508,   551,
     393,   576,   642,     6,    42,     3,   480,   159,   160,   161,
     200,   201,   202,   203,   204,     3,   314,   315,   733,   318,
     735,     3,   737,    43,   739,   598,   246,   247,   248,   249,
     250,   251,   252,   253,   254,   255,   256,   257,   258,   259,
     260,   261,   399,   101,   262,   263,   529,   275,   276,   277,
     278,   279,   280,   281,   282,    78,   484,    78,   603,   264,
     265,   594,   374,   375,   599,   270,   270,   316,   270,   577,
      44,   381,   382,   383,   384,   385,   386,   387,   565,    45,
     569,    35,   561,   573,   292,    30,   602,   391,   335,   336,
     395,   397,   339,   340,   401,   403,   785,   102,   266,   267,
      98,     3,    99,   268,   425,   426,   427,    46,   269,     3,
       3,   270,   270,     3,     3,   339,   340,     3,   446,   447,
     270,   270,   270,   270,   270,   270,   270,    47,   318,   318,
     388,   388,   262,   263,   388,   388,   607,   608,   388,   388,
      48,   611,   490,   409,   413,   615,   343,   264,   265,   617,
     168,   523,    49,   619,   496,   502,    50,   621,   529,     3,
       3,    82,    83,    84,     3,   482,   344,   345,   472,   196,
       3,    87,    88,    89,    51,   638,   405,   270,   270,   640,
     475,   477,   786,   262,   263,   519,   266,   267,    82,    83,
      84,   626,   448,   449,   787,   792,   269,    52,   264,   265,
     508,    53,   535,   138,   536,   523,   537,   139,   538,   140,
     539,   529,   540,   545,   547,   450,   451,   470,   141,   318,
       3,   425,   426,   427,   388,   388,   452,   453,   212,   487,
     493,   499,   505,   511,   470,   526,   532,   266,   267,   142,
     793,   273,   628,   262,   263,   795,   388,   269,   388,   143,
     388,   796,   388,   144,   388,   145,   388,   146,   264,   265,
     147,   409,   270,   270,   454,   455,   413,   550,   470,   148,
     519,   356,   456,   457,   149,   357,   358,   359,   360,   361,
     362,   363,   321,   322,   323,   442,   443,   487,   324,   213,
     325,   461,   462,   493,   466,   467,   150,   266,   267,   499,
     473,   474,   630,   151,   327,   505,   471,   269,   605,   610,
     606,   511,    90,    91,    92,   550,    82,    83,    84,   470,
      93,    94,    95,    96,    97,   620,   526,   285,    89,   552,
     553,   152,   532,   153,   627,   629,   631,   633,   384,   385,
     386,   387,  -135,   438,   546,   548,   541,   639,    90,    91,
      92,  -138,   388,   286,   388,   287,   157,    78,   470,   688,
      97,   288,   689,   294,   159,   160,   161,   554,   555,   289,
     445,   696,   312,   700,   270,   701,   166,   702,   200,   201,
     202,   203,   204,   270,   270,   270,   270,   270,   270,   270,
     270,   445,   290,   556,   557,   445,   270,  -158,  -158,     3,
     723,   291,   724,   343,   579,   376,   698,  -164,  -164,  -166,
    -166,   156,   704,   706,   708,   710,   711,   712,   713,   714,
     313,   355,   262,   263,   407,   671,   418,   671,   430,   671,
     431,   671,   432,   671,   671,   671,   671,   264,   265,   433,
     542,   543,    30,    76,   434,    30,   435,   609,   436,     3,
     437,   613,   458,   463,    30,   470,    30,   479,    30,   618,
      30,   270,   270,   270,   270,   270,   270,   270,   270,   623,
     624,   625,   262,   263,   558,     3,   266,   267,   559,   562,
     563,   632,   566,    30,   567,    30,   269,   264,   265,   641,
     570,   571,   574,   575,   578,   595,   550,   597,   262,   263,
     647,   596,   671,   601,   671,   600,   671,   616,   671,   159,
     160,   161,   519,   264,   265,   622,   656,   162,   163,   164,
     165,   166,   643,   646,   655,   654,   266,   267,   519,   657,
     659,   634,   661,   684,   797,   686,   269,   691,   692,   693,
     694,   695,   729,   293,   613,   690,   715,   716,   717,   439,
     400,   718,   266,   267,   487,   493,   499,   635,   745,   505,
     511,   470,   269,   719,     8,     9,   526,   532,   487,   493,
     499,   720,   321,   322,   323,   505,   511,   470,   324,   721,
     325,   722,   526,   532,   725,   647,   726,   445,   727,   730,
      10,    11,    12,    13,    14,    15,    16,    17,    18,    19,
      20,    21,    22,   731,   732,   755,   746,    23,    24,    25,
     747,   584,   748,   585,   586,   587,   758,   759,   749,   588,
     753,   589,    90,    91,    92,    35,     3,   750,    35,    26,
     590,   751,    95,    96,    97,   591,   752,    35,   754,    35,
     763,    35,   756,    35,   592,    57,     3,    27,   757,   262,
     263,   760,    28,   761,   762,   764,   394,   767,   765,   766,
     788,   768,   790,   779,   264,   265,    35,   780,    35,   262,
     263,    58,    59,    60,    61,    62,    63,    64,    65,    66,
      67,    68,    69,    70,   264,   265,   781,   514,    71,    72,
      73,   782,     3,   789,   791,   159,   160,   161,   799,   800,
     417,   422,   406,   266,   267,   164,   165,   166,   636,   483,
      74,    57,     3,   269,   420,   262,   263,   330,   549,   544,
     770,   776,   771,   266,   267,   778,   784,   515,   516,   777,
     264,   265,   769,   469,   783,   262,   263,    58,    59,    60,
      61,    62,    63,    64,    65,    66,    67,    68,    69,    70,
     264,   265,     0,   514,    71,    72,    73,   356,     3,     0,
       0,   357,   358,   359,   360,   361,   362,   363,     0,   266,
     267,     0,     0,     0,   637,     0,    74,    57,     3,   269,
       0,   262,   263,     0,     0,     0,     0,     0,     0,   266,
     267,     0,     0,   593,   516,     0,   264,   265,     0,   469,
       0,   262,   263,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,   264,   265,     0,   514,
      71,    72,    73,     0,     3,     0,     0,     0,     0,     0,
       0,     0,     0,     0,     0,   266,   267,     0,     0,     0,
     703,     0,    74,    57,     3,   269,     0,   262,   263,     0,
       0,     0,     0,     0,     0,   266,   267,     0,     0,   794,
     516,     0,   264,   265,   155,   469,     0,   262,   263,    58,
      59,    60,    61,    62,    63,    64,    65,    66,    67,    68,
      69,    70,   264,   265,     0,     0,    71,    72,    73,     0,
       3,     0,     0,     0,     0,     0,     0,     0,     0,     0,
       0,   266,   267,     0,     0,     0,   705,     0,    74,    57,
       3,   269,     0,   262,   263,     0,     0,     0,     0,     0,
       0,   266,   267,     0,     0,     0,   468,     0,   264,   265,
     155,   469,     0,   262,   263,    58,    59,    60,    61,    62,
      63,    64,    65,    66,    67,    68,    69,    70,   264,   265,
       0,     0,    71,    72,    73,     0,     3,     0,     0,     0,
       0,     0,     0,     0,     0,     0,     0,   266,   267,     0,
       0,     0,   707,     0,    74,    57,     3,   269,     0,   262,
     263,     0,     0,     0,     0,     0,     0,   266,   267,     0,
       0,     0,   697,     0,   264,   265,     0,   469,     0,   262,
     263,    58,    59,    60,    61,    62,    63,    64,    65,    66,
      67,    68,    69,    70,   264,   265,     0,   514,    71,    72,
      73,     0,   321,   322,   323,     0,     0,     0,   324,     0,
     325,     0,     0,   266,   267,     0,   772,     0,   709,   326,
      74,    57,     3,   269,   327,     0,     0,     0,     0,     0,
       0,     0,   328,   266,   267,     0,     0,     0,   516,     0,
       0,     0,     0,   469,     0,   262,   263,    58,    59,    60,
      61,    62,    63,    64,    65,    66,    67,    68,    69,    70,
     264,   265,     0,     0,    71,    72,    73,   159,   160,   161,
       0,     0,     0,     0,     0,   162,   163,   164,   165,   166,
       0,     0,   774,     0,     0,     0,    74,    57,     3,     0,
       0,     0,   773,     0,     0,     0,     0,     0,     0,   266,
     267,     0,     0,     0,   468,     0,     0,     0,     0,   469,
       0,   262,   263,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68,    69,    70,   264,   265,     0,     0,
      71,    72,    73,   159,   160,   161,     0,     0,     0,     0,
       0,   162,   163,   164,   165,   166,     0,   321,   322,   323,
      57,     3,    74,   324,     0,   325,     0,     0,   775,     0,
       0,     0,     0,     0,   326,   266,   267,     0,     0,   327,
     697,   155,     0,     0,     0,   469,    58,    59,    60,    61,
      62,    63,    64,    65,    66,    67,    68,    69,    70,     0,
       0,    57,     3,    71,    72,    73,  -214,    82,    83,    84,
       0,     0,     0,     0,     0,    85,    86,    87,    88,    89,
       0,     0,   155,     0,     0,    74,     0,    58,    59,    60,
      61,    62,    63,    64,    65,    66,    67,    68,    69,    70,
       0,     0,     0,    75,    71,    72,    73,     0,    76,     0,
     321,   322,   323,  -214,  -214,  -214,   324,     0,   325,  -214,
       0,  -214,     0,     0,    57,     3,    74,   326,     0,     0,
    -214,     0,   327,     0,     0,  -214,     0,     0,     0,     0,
       0,     0,   378,     0,   612,     0,     0,     0,     0,    76,
      58,    59,    60,    61,    62,    63,    64,    65,    66,    67,
      68,    69,    70,     0,     0,    57,     3,    71,    72,    73,
    -215,     0,     0,     0,     0,   159,   160,   161,     0,     0,
       0,     0,     0,   162,   163,   164,   165,   166,     0,    74,
       0,    58,    59,    60,    61,    62,    63,    64,    65,    66,
      67,    68,    69,    70,   167,     0,     0,    75,    71,    72,
      73,     0,    76,     0,   321,   322,   323,  -215,  -215,  -215,
     324,   728,   325,  -215,     0,  -215,     0,     0,     8,     9,
      74,   326,     0,     0,  -215,     0,   327,     0,     0,  -215,
       0,     0,     0,     0,     0,   645,     0,     0,   612,     0,
       0,     0,     0,    76,    10,    11,    12,    13,    14,    15,
      16,    17,    18,    19,    20,    21,    22,     0,   321,   322,
     323,    23,    24,    25,   324,   649,   325,   650,     0,     0,
       0,   651,     0,     0,     0,   326,   159,   160,   161,     0,
     327,     0,     0,    26,   162,   163,   164,   165,   166,     0,
       0,     0,     0,   649,     0,   650,     0,     0,     0,   651,
       0,    27,     0,   274,   159,   160,   161,     0,     0,   652,
     653,     0,   162,   163,   164,   165,   166,     0,     0,     0,
     581,     0,   582,     0,     0,     0,   583,     0,     0,     0,
       0,   159,   160,   161,     0,     0,     0,   652,   653,   162,
     163,   164,   165,   166,   662,     0,   663,   664,   665,   321,
     322,   323,   666,     0,   667,   324,     0,   325,   274,   321,
     322,   323,     0,   668,     0,   324,   326,   325,   669,     0,
       0,   327,     0,     0,     0,     0,   326,   670,     0,     0,
     660,   327,     0,   321,   322,   323,   321,   322,   323,   324,
     673,   325,   324,     0,   325,     0,   321,   322,   323,     0,
     326,     0,   324,   326,   325,   327,     0,     0,   327,     0,
       0,     0,     0,   326,   675,     0,     0,   677,   327,     0,
     321,   322,   323,   321,   322,   323,   324,   679,   325,   324,
       0,   325,     0,   321,   322,   323,     0,   326,     0,   324,
     326,   325,   327,     0,     0,   327,     0,     0,     0,     0,
     326,   685,     0,     0,   734,   327,     0,   321,   322,   323,
     321,   322,   323,   324,   736,   325,   324,     0,   325,     0,
     321,   322,   323,     0,   326,     0,   324,   326,   325,   327,
       0,     0,   327,     0,     0,     0,     0,   326,   738,     0,
       0,   740,   327,     0,   321,   322,   323,   321,   322,   323,
     324,   741,   325,   324,     0,   325,     0,   321,   322,   323,
       0,   326,     0,   324,   326,   325,   327,     0,     0,   327,
       0,     0,     0,     0,   326,   742,     0,     0,   743,   327,
       0,   321,   322,   323,   321,   322,   323,   324,   744,   325,
     324,     0,   325,     0,     0,     0,     0,     0,   326,     0,
       0,   326,     0,   327,     0,     0,   327,   321,   322,   323,
       0,   377,     0,   324,   440,   325,     0,  -214,  -214,  -214,
       0,     0,     0,  -214,   326,  -214,     0,     0,     0,   327,
       0,     0,     0,     0,  -214,     0,     0,   441,     0,  -214,
    -214,  -214,  -214,     0,     0,     0,  -214,   604,  -214,     0,
       0,     0,     0,     0,     0,     0,     0,  -214,     0,     0,
       0,     0,  -214,   159,   160,   161,     0,     0,     0,     0,
     376,   162,   163,   164,   165,   166,   159,   160,   161,     0,
       0,     0,     0,     0,   162,   163,   164,   165,   166,     0,
       0,   644,     0,     0,     0,     0,     0,   159,   160,   161,
       0,     0,     0,     0,   658,   162,   163,   164,   165,   166,
      82,    83,    84,     0,     0,     0,     0,     0,    85,    86,
      87,    88,    89,     0,     0,   687,     0,     0,     0,     0,
      90,    91,    92,     0,     0,     0,     0,   136,    93,    94,
      95,    96,    97,    82,    83,    84,     0,     0,     0,     0,
       0,    85,    86,    87,    88,    89,     0,   137,     0,     0,
       0,     0,     0,    90,    91,    92,     0,     0,     0,     0,
     214,    93,    94,    95,    96,    97,    82,    83,    84,     0,
       0,     0,     0,     0,    85,    86,    87,    88,    89,     0,
     215,     0,     0,     0,     0,     0,    90,    91,    92,     0,
       0,     0,     0,   216,    93,    94,    95,    96,    97,    82,
      83,    84,     0,     0,     0,     0,     0,    85,    86,    87,
      88,    89,     0,   217,     0,     0,     0,     0,     0,    90,
      91,    92,     0,     0,     0,     0,   218,    93,    94,    95,
      96,    97,    82,    83,    84,     0,     0,     0,     0,     0,
      85,    86,    87,    88,    89,     0,   219,     0,     0,     0,
       0,     0,    90,    91,    92,     0,     0,     0,     0,   220,
      93,    94,    95,    96,    97,    82,    83,    84,     0,     0,
       0,     0,     0,    85,    86,    87,    88,    89,     0,   221,
       0,     0,     0,     0,     0,    90,    91,    92,     0,     0,
       0,     0,   222,    93,    94,    95,    96,    97,    82,    83,
      84,     0,     0,     0,     0,     0,    85,    86,    87,    88,
      89,     0,   223,     0,     0,     0,     0,     0,    90,    91,
      92,     0,     0,     0,     0,   224,    93,    94,    95,    96,
      97,    82,    83,    84,     0,     0,     0,     0,     0,    85,
      86,    87,    88,    89,     0,   225,     0,     0,     0,     0,
       0,    90,    91,    92,     0,     0,     0,     0,   226,    93,
      94,    95,    96,    97,    82,    83,    84,     0,     0,     0,
       0,     0,    85,    86,    87,    88,    89,     0,   227,     0,
       0,     0,     0,     0,    90,    91,    92,     0,     0,     0,
       0,   228,    93,    94,    95,    96,    97,    82,    83,    84,
       0,     0,     0,     0,     0,    85,    86,    87,    88,    89,
       0,   229,     0,     0,     0,     0,     0,    90,    91,    92,
       0,     0,     0,     0,   230,    93,    94,    95,    96,    97,
      82,    83,    84,     0,     0,     0,     0,     0,    85,    86,
      87,    88,    89,     0,   231,     0,     0,     0,     0,     0,
      90,    91,    92,     0,     0,     0,     0,   232,    93,    94,
      95,    96,    97,    82,    83,    84,     0,     0,     0,     0,
       0,    85,    86,    87,    88,    89,     0,   233,     0,     0,
       0,     0,     0,    90,    91,    92,     0,     0,     0,     0,
     234,    93,    94,    95,    96,    97,    82,    83,    84,     0,
       0,     0,     0,     0,    85,    86,    87,    88,    89,     0,
     235,     0,     0,     0,     0,     0,    90,    91,    92,     0,
       0,     0,     0,   236,    93,    94,    95,    96,    97,    82,
      83,    84,     0,     0,     0,     0,     0,    85,    86,    87,
      88,    89,     0,   237,     0,     0,     0,     0,     0,    90,
      91,    92,     0,     0,     0,     0,   238,    93,    94,    95,
      96,    97,    82,    83,    84,     0,     0,     0,     0,     0,
      85,    86,    87,    88,    89,     0,   239,     0,     0,     0,
       0,     0,    90,    91,    92,     0,     0,     0,     0,   240,
      93,    94,    95,    96,    97,    82,    83,    84,     0,     0,
       0,     0,     0,    85,    86,    87,    88,    89,     0,   241,
       0,     0,     0,     0,     0,    90,    91,    92,     0,     0,
       0,     0,   242,    93,    94,    95,    96,    97,    82,    83,
      84,     0,     0,     0,     0,     0,    85,    86,    87,    88,
      89,     0,   243,     0,     0,     0,     0,     0,    90,    91,
      92,     0,     0,     0,     0,   244,    93,    94,    95,    96,
      97,   159,   160,   161,     0,     0,     0,     0,     0,   162,
     163,   164,   165,   166,     0,   245,     0,     0,     0,     0,
       0,   159,   160,   161,     0,     0,     0,     0,   274,   162,
     163,   164,   165,   166,   159,   160,   161,     0,     0,     0,
       0,     0,   162,   163,   164,   165,   166,     0,   296,     0,
       0,     0,     0,     0,   159,   160,   161,     0,     0,     0,
       0,   297,   162,   163,   164,   165,   166,   159,   160,   161,
       0,     0,     0,     0,     0,   162,   163,   164,   165,   166,
       0,   298,     0,     0,     0,     0,     0,   159,   160,   161,
       0,     0,     0,     0,   299,   162,   163,   164,   165,   166,
     159,   160,   161,     0,     0,     0,     0,     0,   162,   163,
     164,   165,   166,     0,   300,     0,     0,     0,     0,     0,
     159,   160,   161,     0,     0,     0,     0,   301,   162,   163,
     164,   165,   166,   159,   160,   161,     0,     0,     0,     0,
       0,   162,   163,   164,   165,   166,     0,   302,     0,     0,
       0,     0,     0,   159,   160,   161,     0,     0,     0,     0,
     303,   162,   163,   164,   165,   166,   159,   160,   161,     0,
       0,     0,     0,     0,   162,   163,   164,   165,   166,     0,
     304,     0,     0,     0,     0,     0,   159,   160,   161,     0,
       0,     0,     0,   305,   162,   163,   164,   165,   166,   159,
     160,   161,     0,     0,     0,     0,     0,   162,   163,   164,
     165,   166,     0,   306,     0,     0,     0,     0,     0,   159,
     160,   161,     0,     0,     0,     0,   307,   162,   163,   164,
     165,   166,   159,   160,   161,     0,     0,     0,     0,     0,
     162,   163,   164,   165,   166,     0,   308,     0,     0,     0,
       0,     0,   159,   160,   161,     0,     0,     0,     0,   309,
     162,   163,   164,   165,   166,   159,   160,   161,     0,     0,
       0,     0,     0,   162,   163,   164,   165,   166,     0,   310,
       0,     0,     0,     0,     0,   159,   160,   161,     0,     0,
       0,     0,   311,   162,   163,   164,   165,   166,     0,     0,
     581,     0,   582,     0,     0,     0,   583,     0,     0,     0,
     798,   159,   160,   161,     0,     0,    90,    91,    92,   162,
     163,   164,   165,   166,    93,    94,    95,    96,    97,   159,
     160,   161,     0,     0,     0,     0,     0,   162,   163,   164,
     165,   166
};

static const short yycheck[] =
{
       1,   488,   494,   520,   512,     6,   409,   533,   527,   500,
     413,   100,     5,   506,    28,    99,   291,     4,   563,     4,
       4,     4,     4,     4,    88,    26,    27,     4,    92,     4,
       4,   516,     4,     4,     4,    67,     4,    38,    39,    40,
      41,    42,    43,    44,    45,    46,    47,    48,    49,    50,
      51,    52,    53,    24,    25,     0,     4,     4,    86,    91,
      45,    45,    45,    45,    45,     4,     4,    84,    45,   344,
     345,    45,     6,    45,    75,    45,   351,    45,     4,   354,
      86,    82,    83,    84,    85,    86,    87,    88,    89,    90,
      91,    92,    93,    94,    95,    96,    97,    45,    99,   100,
      85,    88,    85,    85,    85,   155,    45,    45,    85,    26,
      27,   656,    90,    85,    85,    85,    28,    85,    67,    45,
       4,    38,    39,    40,    41,    42,    43,    44,    45,    46,
      47,    48,    49,    50,    51,    52,    53,    85,    85,    24,
      25,   626,    91,   628,     4,   630,    85,   632,     4,   634,
     635,   636,   637,   167,   155,   169,    88,     4,    86,    85,
      92,    45,    74,    75,    76,    82,    83,    84,    85,    86,
      87,    88,    89,    90,    91,    92,    93,    94,    95,    96,
      97,    24,    25,   100,    67,    45,    86,   462,     6,    45,
      24,    25,   467,    60,    61,    62,    86,   286,    45,   474,
      85,    85,   605,    86,    86,     4,   427,    60,    61,    62,
      11,    12,    13,    14,    15,     4,   266,   267,   703,   269,
     705,     4,   707,    86,   709,    85,   138,   139,   140,   141,
     142,   143,   144,   145,   146,   147,   148,   149,   150,   151,
     152,   153,    85,    84,    27,    28,    45,   159,   160,   161,
     162,   163,   164,   165,   166,   167,    45,   169,   784,    42,
      43,   778,   312,   313,   783,   266,   267,   268,   269,   777,
      86,   321,   322,   323,   324,   325,   326,   327,   770,    86,
     771,    99,   769,   776,    85,   286,    85,   332,    24,    25,
     335,   336,    24,    25,   339,   340,    85,     7,    81,    82,
      87,     4,    89,    86,    24,    25,    26,    86,    91,     4,
       4,   312,   313,     4,     4,    24,    25,     4,    88,    89,
     321,   322,   323,   324,   325,   326,   327,    86,   378,   379,
     331,   332,    27,    28,   335,   336,   557,   558,   339,   340,
      86,   562,    45,   344,   345,   566,     4,    42,    43,   570,
      92,    45,    86,   574,    45,    45,    86,   578,    45,     4,
       4,    60,    61,    62,     4,    85,    24,    25,   418,   286,
       4,    70,    71,    72,    86,   596,    85,   378,   379,   600,
     425,   426,    85,    27,    28,   435,    81,    82,    60,    61,
      62,    86,    88,    89,    85,    85,    91,    86,    42,    43,
      45,    86,   447,    86,   449,    45,   451,    86,   453,    86,
     455,    45,   457,   463,   464,    88,    89,   418,    86,   469,
       4,    24,    25,    26,   425,   426,    88,    89,    84,   430,
     431,   432,   433,   434,   435,   436,   437,    81,    82,    86,
      85,    87,    86,    27,    28,    85,   447,    91,   449,    86,
     451,    85,   453,    86,   455,    86,   457,    86,    42,    43,
      86,   462,   463,   464,    88,    89,   467,   468,   469,    86,
     520,    13,    88,    89,    86,    17,    18,    19,    20,    21,
      22,    23,    57,    58,    59,   378,   379,   488,    63,    85,
      65,    88,    89,   494,    88,    89,    86,    81,    82,   500,
      88,    89,    86,    86,    79,   506,   418,    91,   553,   559,
     555,   512,    60,    61,    62,   516,    60,    61,    62,   520,
      68,    69,    70,    71,    72,   575,   527,    87,    72,    88,
      89,    86,   533,    86,   584,   585,   586,   587,   588,   589,
     590,   591,    90,    85,   463,   464,   458,   597,    60,    61,
      62,    90,   553,    90,   555,    84,   468,   469,   559,   643,
      72,    84,   646,    16,    60,    61,    62,    88,    89,    84,
     388,   655,    86,   657,   575,   659,    72,   661,    11,    12,
      13,    14,    15,   584,   585,   586,   587,   588,   589,   590,
     591,   409,    84,    88,    89,   413,   597,    88,    89,     4,
     684,    84,   686,     4,   516,    87,   656,    88,    89,    88,
      89,   612,   662,   663,   664,   665,   666,   667,   668,   669,
      86,    84,    27,    28,     4,   626,    67,   628,    84,   630,
      84,   632,    84,   634,   635,   636,   637,    42,    43,    84,
     458,   459,   643,    91,    84,   646,    84,   559,    84,     4,
      84,   563,    67,    67,   655,   656,   657,     4,   659,   571,
     661,   662,   663,   664,   665,   666,   667,   668,   669,   581,
     582,   583,    27,    28,    86,     4,    81,    82,    67,    86,
      67,    86,    86,   684,    67,   686,    91,    42,    43,   601,
      86,    67,    86,    67,    86,    88,   697,    67,    27,    28,
     612,    86,   703,    67,   705,    86,   707,    84,   709,    60,
      61,    62,   762,    42,    43,    87,     8,    68,    69,    70,
      71,    72,    67,    67,    67,    88,    81,    82,   778,    67,
      67,    86,    67,    67,    85,    67,    91,   649,   650,   651,
     652,   653,    10,   205,   656,    87,    87,    87,    87,   364,
     337,    87,    81,    82,   755,   756,   757,    86,    88,   760,
     761,   762,    91,    87,     3,     4,   767,   768,   769,   770,
     771,    87,    57,    58,    59,   776,   777,   778,    63,    87,
      65,    87,   783,   784,    87,   697,    87,   605,    87,    87,
      29,    30,    31,    32,    33,    34,    35,    36,    37,    38,
      39,    40,    41,    87,    87,    84,    88,    46,    47,    48,
      88,    55,    88,    57,    58,    59,   728,   729,    88,    63,
      87,    65,    60,    61,    62,   643,     4,    88,   646,    68,
      74,    88,    70,    71,    72,    79,    88,   655,    87,   657,
      87,   659,    84,   661,    88,     3,     4,    86,    84,    27,
      28,    84,    91,    84,    84,    87,   333,    84,    87,    87,
     772,    84,   774,    88,    42,    43,   684,    88,   686,    27,
      28,    29,    30,    31,    32,    33,    34,    35,    36,    37,
      38,    39,    40,    41,    42,    43,    88,    45,    46,    47,
      48,    88,     4,    88,    88,    60,    61,    62,    88,    88,
     346,   351,   341,    81,    82,    70,    71,    72,    86,   428,
      68,     3,     4,    91,   349,    27,    28,   286,   467,   462,
     756,   760,   757,    81,    82,   762,   768,    85,    86,   761,
      42,    43,   755,    91,   767,    27,    28,    29,    30,    31,
      32,    33,    34,    35,    36,    37,    38,    39,    40,    41,
      42,    43,    -1,    45,    46,    47,    48,    13,     4,    -1,
      -1,    17,    18,    19,    20,    21,    22,    23,    -1,    81,
      82,    -1,    -1,    -1,    86,    -1,    68,     3,     4,    91,
      -1,    27,    28,    -1,    -1,    -1,    -1,    -1,    -1,    81,
      82,    -1,    -1,    85,    86,    -1,    42,    43,    -1,    91,
      -1,    27,    28,    29,    30,    31,    32,    33,    34,    35,
      36,    37,    38,    39,    40,    41,    42,    43,    -1,    45,
      46,    47,    48,    -1,     4,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    81,    82,    -1,    -1,    -1,
      86,    -1,    68,     3,     4,    91,    -1,    27,    28,    -1,
      -1,    -1,    -1,    -1,    -1,    81,    82,    -1,    -1,    85,
      86,    -1,    42,    43,    24,    91,    -1,    27,    28,    29,
      30,    31,    32,    33,    34,    35,    36,    37,    38,    39,
      40,    41,    42,    43,    -1,    -1,    46,    47,    48,    -1,
       4,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,    -1,
      -1,    81,    82,    -1,    -1,    -1,    86,    -1,    68,     3,
       4,    91,    -1,    27,    28,    -1,    -1,    -1,    -1,    -1,
      -1,    81,    82,    -1,    -1,    -1,    86,    -1,    42,    43,
      24,    91,    -1,    27,    28,    29,    30,    31,    32,    33,
      34,    35,    36,    37,    38,    39,    40,    41,    42,    43,
      -1,    -1,    46,    47,    48,    -1,     4,    -1,    -1,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    81,    82,    -1,
      -1,    -1,    86,    -1,    68,     3,     4,    91,    -1,    27,
      28,    -1,    -1,    -1,    -1,    -1,    -1,    81,    82,    -1,
      -1,    -1,    86,    -1,    42,    43,    -1,    91,    -1,    27,
      28,    29,    30,    31,    32,    33,    34,    35,    36,    37,
      38,    39,    40,    41,    42,    43,    -1,    45,    46,    47,
      48,    -1,    57,    58,    59,    -1,    -1,    -1,    63,    -1,
      65,    -1,    -1,    81,    82,    -1,     9,    -1,    86,    74,
      68,     3,     4,    91,    79,    -1,    -1,    -1,    -1,    -1,
      -1,    -1,    87,    81,    82,    -1,    -1,    -1,    86,    -1,
      -1,    -1,    -1,    91,    -1,    27,    28,    29,    30,    31,
      32,    33,    34,    35,    36,    37,    38,    39,    40,    41,
      42,    43,    -1,    -1,    46,    47,    48,    60,    61,    62,
      -1,    -1,    -1,    -1,    -1,    68,    69,    70,    71,    72,
      -1,    -1,     9,    -1,    -1,    -1,    68,     3,     4,    -1,
      -1,    -1,    85,    -1,    -1,    -1,    -1,    -1,    -1,    81,
      82,    -1,    -1,    -1,    86,    -1,    -1,    -1,    -1,    91,
      -1,    27,    28,    29,    30,    31,    32,    33,    34,    35,
      36,    37,    38,    39,    40,    41,    42,    43,    -1,    -1,
      46,    47,    48,    60,    61,    62,    -1,    -1,    -1,    -1,
      -1,    68,    69,    70,    71,    72,    -1,    57,    58,    59,
       3,     4,    68,    63,    -1,    65,    -1,    -1,    85,    -1,
      -1,    -1,    -1,    -1,    74,    81,    82,    -1,    -1,    79,
      86,    24,    -1,    -1,    -1,    91,    29,    30,    31,    32,
      33,    34,    35,    36,    37,    38,    39,    40,    41,    -1,
      -1,     3,     4,    46,    47,    48,    10,    60,    61,    62,
      -1,    -1,    -1,    -1,    -1,    68,    69,    70,    71,    72,
      -1,    -1,    24,    -1,    -1,    68,    -1,    29,    30,    31,
      32,    33,    34,    35,    36,    37,    38,    39,    40,    41,
      -1,    -1,    -1,    86,    46,    47,    48,    -1,    91,    -1,
      57,    58,    59,    57,    58,    59,    63,    -1,    65,    63,
      -1,    65,    -1,    -1,     3,     4,    68,    74,    -1,    -1,
      74,    -1,    79,    -1,    -1,    79,    -1,    -1,    -1,    -1,
      -1,    -1,    89,    -1,    86,    -1,    -1,    -1,    -1,    91,
      29,    30,    31,    32,    33,    34,    35,    36,    37,    38,
      39,    40,    41,    -1,    -1,     3,     4,    46,    47,    48,
      10,    -1,    -1,    -1,    -1,    60,    61,    62,    -1,    -1,
      -1,    -1,    -1,    68,    69,    70,    71,    72,    -1,    68,
      -1,    29,    30,    31,    32,    33,    34,    35,    36,    37,
      38,    39,    40,    41,    89,    -1,    -1,    86,    46,    47,
      48,    -1,    91,    -1,    57,    58,    59,    57,    58,    59,
      63,    10,    65,    63,    -1,    65,    -1,    -1,     3,     4,
      68,    74,    -1,    -1,    74,    -1,    79,    -1,    -1,    79,
      -1,    -1,    -1,    -1,    -1,    88,    -1,    -1,    86,    -1,
      -1,    -1,    -1,    91,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    -1,    57,    58,
      59,    46,    47,    48,    63,    49,    65,    51,    -1,    -1,
      -1,    55,    -1,    -1,    -1,    74,    60,    61,    62,    -1,
      79,    -1,    -1,    68,    68,    69,    70,    71,    72,    -1,
      -1,    -1,    -1,    49,    -1,    51,    -1,    -1,    -1,    55,
      -1,    86,    -1,    87,    60,    61,    62,    -1,    -1,    93,
      94,    -1,    68,    69,    70,    71,    72,    -1,    -1,    -1,
      49,    -1,    51,    -1,    -1,    -1,    55,    -1,    -1,    -1,
      -1,    60,    61,    62,    -1,    -1,    -1,    93,    94,    68,
      69,    70,    71,    72,    55,    -1,    57,    58,    59,    57,
      58,    59,    63,    -1,    65,    63,    -1,    65,    87,    57,
      58,    59,    -1,    74,    -1,    63,    74,    65,    79,    -1,
      -1,    79,    -1,    -1,    -1,    -1,    74,    88,    -1,    -1,
      88,    79,    -1,    57,    58,    59,    57,    58,    59,    63,
      88,    65,    63,    -1,    65,    -1,    57,    58,    59,    -1,
      74,    -1,    63,    74,    65,    79,    -1,    -1,    79,    -1,
      -1,    -1,    -1,    74,    88,    -1,    -1,    88,    79,    -1,
      57,    58,    59,    57,    58,    59,    63,    88,    65,    63,
      -1,    65,    -1,    57,    58,    59,    -1,    74,    -1,    63,
      74,    65,    79,    -1,    -1,    79,    -1,    -1,    -1,    -1,
      74,    88,    -1,    -1,    88,    79,    -1,    57,    58,    59,
      57,    58,    59,    63,    88,    65,    63,    -1,    65,    -1,
      57,    58,    59,    -1,    74,    -1,    63,    74,    65,    79,
      -1,    -1,    79,    -1,    -1,    -1,    -1,    74,    88,    -1,
      -1,    88,    79,    -1,    57,    58,    59,    57,    58,    59,
      63,    88,    65,    63,    -1,    65,    -1,    57,    58,    59,
      -1,    74,    -1,    63,    74,    65,    79,    -1,    -1,    79,
      -1,    -1,    -1,    -1,    74,    88,    -1,    -1,    88,    79,
      -1,    57,    58,    59,    57,    58,    59,    63,    88,    65,
      63,    -1,    65,    -1,    -1,    -1,    -1,    -1,    74,    -1,
      -1,    74,    -1,    79,    -1,    -1,    79,    57,    58,    59,
      -1,    87,    -1,    63,    87,    65,    -1,    57,    58,    59,
      -1,    -1,    -1,    63,    74,    65,    -1,    -1,    -1,    79,
      -1,    -1,    -1,    -1,    74,    -1,    -1,    87,    -1,    79,
      57,    58,    59,    -1,    -1,    -1,    63,    87,    65,    -1,
      -1,    -1,    -1,    -1,    -1,    -1,    -1,    74,    -1,    -1,
      -1,    -1,    79,    60,    61,    62,    -1,    -1,    -1,    -1,
      87,    68,    69,    70,    71,    72,    60,    61,    62,    -1,
      -1,    -1,    -1,    -1,    68,    69,    70,    71,    72,    -1,
      -1,    88,    -1,    -1,    -1,    -1,    -1,    60,    61,    62,
      -1,    -1,    -1,    -1,    88,    68,    69,    70,    71,    72,
      60,    61,    62,    -1,    -1,    -1,    -1,    -1,    68,    69,
      70,    71,    72,    -1,    -1,    88,    -1,    -1,    -1,    -1,
      60,    61,    62,    -1,    -1,    -1,    -1,    87,    68,    69,
      70,    71,    72,    60,    61,    62,    -1,    -1,    -1,    -1,
      -1,    68,    69,    70,    71,    72,    -1,    87,    -1,    -1,
      -1,    -1,    -1,    60,    61,    62,    -1,    -1,    -1,    -1,
      87,    68,    69,    70,    71,    72,    60,    61,    62,    -1,
      -1,    -1,    -1,    -1,    68,    69,    70,    71,    72,    -1,
      87,    -1,    -1,    -1,    -1,    -1,    60,    61,    62,    -1,
      -1,    -1,    -1,    87,    68,    69,    70,    71,    72,    60,
      61,    62,    -1,    -1,    -1,    -1,    -1,    68,    69,    70,
      71,    72,    -1,    87,    -1,    -1,    -1,    -1,    -1,    60,
      61,    62,    -1,    -1,    -1,    -1,    87,    68,    69,    70,
      71,    72,    60,    61,    62,    -1,    -1,    -1,    -1,    -1,
      68,    69,    70,    71,    72,    -1,    87,    -1,    -1,    -1,
      -1,    -1,    60,    61,    62,    -1,    -1,    -1,    -1,    87,
      68,    69,    70,    71,    72,    60,    61,    62,    -1,    -1,
      -1,    -1,    -1,    68,    69,    70,    71,    72,    -1,    87,
      -1,    -1,    -1,    -1,    -1,    60,    61,    62,    -1,    -1,
      -1,    -1,    87,    68,    69,    70,    71,    72,    60,    61,
      62,    -1,    -1,    -1,    -1,    -1,    68,    69,    70,    71,
      72,    -1,    87,    -1,    -1,    -1,    -1,    -1,    60,    61,
      62,    -1,    -1,    -1,    -1,    87,    68,    69,    70,    71,
      72,    60,    61,    62,    -1,    -1,    -1,    -1,    -1,    68,
      69,    70,    71,    72,    -1,    87,    -1,    -1,    -1,    -1,
      -1,    60,    61,    62,    -1,    -1,    -1,    -1,    87,    68,
      69,    70,    71,    72,    60,    61,    62,    -1,    -1,    -1,
      -1,    -1,    68,    69,    70,    71,    72,    -1,    87,    -1,
      -1,    -1,    -1,    -1,    60,    61,    62,    -1,    -1,    -1,
      -1,    87,    68,    69,    70,    71,    72,    60,    61,    62,
      -1,    -1,    -1,    -1,    -1,    68,    69,    70,    71,    72,
      -1,    87,    -1,    -1,    -1,    -1,    -1,    60,    61,    62,
      -1,    -1,    -1,    -1,    87,    68,    69,    70,    71,    72,
      60,    61,    62,    -1,    -1,    -1,    -1,    -1,    68,    69,
      70,    71,    72,    -1,    87,    -1,    -1,    -1,    -1,    -1,
      60,    61,    62,    -1,    -1,    -1,    -1,    87,    68,    69,
      70,    71,    72,    60,    61,    62,    -1,    -1,    -1,    -1,
      -1,    68,    69,    70,    71,    72,    -1,    87,    -1,    -1,
      -1,    -1,    -1,    60,    61,    62,    -1,    -1,    -1,    -1,
      87,    68,    69,    70,    71,    72,    60,    61,    62,    -1,
      -1,    -1,    -1,    -1,    68,    69,    70,    71,    72,    -1,
      87,    -1,    -1,    -1,    -1,    -1,    60,    61,    62,    -1,
      -1,    -1,    -1,    87,    68,    69,    70,    71,    72,    60,
      61,    62,    -1,    -1,    -1,    -1,    -1,    68,    69,    70,
      71,    72,    -1,    87,    -1,    -1,    -1,    -1,    -1,    60,
      61,    62,    -1,    -1,    -1,    -1,    87,    68,    69,    70,
      71,    72,    60,    61,    62,    -1,    -1,    -1,    -1,    -1,
      68,    69,    70,    71,    72,    -1,    87,    -1,    -1,    -1,
      -1,    -1,    60,    61,    62,    -1,    -1,    -1,    -1,    87,
      68,    69,    70,    71,    72,    60,    61,    62,    -1,    -1,
      -1,    -1,    -1,    68,    69,    70,    71,    72,    -1,    87,
      -1,    -1,    -1,    -1,    -1,    60,    61,    62,    -1,    -1,
      -1,    -1,    87,    68,    69,    70,    71,    72,    60,    61,
      62,    -1,    -1,    -1,    -1,    -1,    68,    69,    70,    71,
      72,    -1,    87,    -1,    -1,    -1,    -1,    -1,    60,    61,
      62,    -1,    -1,    -1,    -1,    87,    68,    69,    70,    71,
      72,    60,    61,    62,    -1,    -1,    -1,    -1,    -1,    68,
      69,    70,    71,    72,    -1,    87,    -1,    -1,    -1,    -1,
      -1,    60,    61,    62,    -1,    -1,    -1,    -1,    87,    68,
      69,    70,    71,    72,    60,    61,    62,    -1,    -1,    -1,
      -1,    -1,    68,    69,    70,    71,    72,    -1,    87,    -1,
      -1,    -1,    -1,    -1,    60,    61,    62,    -1,    -1,    -1,
      -1,    87,    68,    69,    70,    71,    72,    60,    61,    62,
      -1,    -1,    -1,    -1,    -1,    68,    69,    70,    71,    72,
      -1,    87,    -1,    -1,    -1,    -1,    -1,    60,    61,    62,
      -1,    -1,    -1,    -1,    87,    68,    69,    70,    71,    72,
      60,    61,    62,    -1,    -1,    -1,    -1,    -1,    68,    69,
      70,    71,    72,    -1,    87,    -1,    -1,    -1,    -1,    -1,
      60,    61,    62,    -1,    -1,    -1,    -1,    87,    68,    69,
      70,    71,    72,    60,    61,    62,    -1,    -1,    -1,    -1,
      -1,    68,    69,    70,    71,    72,    -1,    87,    -1,    -1,
      -1,    -1,    -1,    60,    61,    62,    -1,    -1,    -1,    -1,
      87,    68,    69,    70,    71,    72,    60,    61,    62,    -1,
      -1,    -1,    -1,    -1,    68,    69,    70,    71,    72,    -1,
      87,    -1,    -1,    -1,    -1,    -1,    60,    61,    62,    -1,
      -1,    -1,    -1,    87,    68,    69,    70,    71,    72,    60,
      61,    62,    -1,    -1,    -1,    -1,    -1,    68,    69,    70,
      71,    72,    -1,    87,    -1,    -1,    -1,    -1,    -1,    60,
      61,    62,    -1,    -1,    -1,    -1,    87,    68,    69,    70,
      71,    72,    60,    61,    62,    -1,    -1,    -1,    -1,    -1,
      68,    69,    70,    71,    72,    -1,    87,    -1,    -1,    -1,
      -1,    -1,    60,    61,    62,    -1,    -1,    -1,    -1,    87,
      68,    69,    70,    71,    72,    60,    61,    62,    -1,    -1,
      -1,    -1,    -1,    68,    69,    70,    71,    72,    -1,    87,
      -1,    -1,    -1,    -1,    -1,    60,    61,    62,    -1,    -1,
      -1,    -1,    87,    68,    69,    70,    71,    72,    -1,    -1,
      49,    -1,    51,    -1,    -1,    -1,    55,    -1,    -1,    -1,
      85,    60,    61,    62,    -1,    -1,    60,    61,    62,    68,
      69,    70,    71,    72,    68,    69,    70,    71,    72,    60,
      61,    62,    -1,    -1,    -1,    -1,    -1,    68,    69,    70,
      71,    72
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const unsigned char yystos[] =
{
       0,     5,    96,     4,   131,     0,    86,    84,     3,     4,
      29,    30,    31,    32,    33,    34,    35,    36,    37,    38,
      39,    40,    41,    46,    47,    48,    68,    86,    91,   130,
     131,   132,   133,   134,   135,   161,     6,    97,    86,    86,
      86,    86,    86,    86,    86,    86,    86,    86,    86,    86,
      86,    86,    86,    86,   132,   131,   132,     3,    29,    30,
      31,    32,    33,    34,    35,    36,    37,    38,    39,    40,
      41,    46,    47,    48,    68,    86,    91,   131,   156,   159,
     160,   161,    60,    61,    62,    68,    69,    70,    71,    72,
      60,    61,    62,    68,    69,    70,    71,    72,    87,    89,
      90,    84,     7,   100,   131,   132,   131,   132,   131,   132,
     131,   132,   131,   132,   131,   132,   131,   132,   131,   132,
     131,   132,   131,   132,   131,   132,   131,   132,   131,   132,
     131,   132,   131,   132,   131,   132,    87,    87,    86,    86,
      86,    86,    86,    86,    86,    86,    86,    86,    86,    86,
      86,    86,    86,    86,   156,    24,   131,   156,   159,    60,
      61,    62,    68,    69,    70,    71,    72,    89,    92,    88,
      92,   131,   132,   131,   132,   131,   132,   131,   132,   131,
     132,   131,   132,   131,   132,   131,   132,   132,   132,   132,
     132,   132,   132,   132,   132,   133,   132,   134,   136,   137,
      11,    12,    13,    14,    15,    98,    99,   103,   104,   105,
     106,   107,    84,    85,    87,    87,    87,    87,    87,    87,
      87,    87,    87,    87,    87,    87,    87,    87,    87,    87,
      87,    87,    87,    87,    87,    87,    87,    87,    87,    87,
      87,    87,    87,    87,    87,    87,   156,   156,   156,   156,
     156,   156,   156,   156,   156,   156,   156,   156,   156,   156,
     156,   156,    27,    28,    42,    43,    81,    82,    86,    91,
     131,   157,   164,    87,    87,   156,   156,   156,   156,   156,
     156,   156,   156,   159,   159,    87,    90,    84,    84,    84,
      84,    84,    85,    99,    16,   108,    87,    87,    87,    87,
      87,    87,    87,    87,    87,    87,    87,    87,    87,    87,
      87,    87,    86,    86,   157,   157,   131,   157,   157,   162,
     163,    57,    58,    59,    63,    65,    74,    79,    87,   134,
     136,    24,    25,   117,   123,    24,    25,   118,   124,    24,
      25,   119,   125,     4,    24,    25,   120,   126,   129,   149,
     150,   121,   127,   129,   152,    84,    13,    17,    18,    19,
      20,    21,    22,    23,   101,   102,   165,   169,   172,   175,
     178,   182,   185,   188,   157,   157,    87,    87,    89,    88,
      92,   157,   157,   157,   157,   157,   157,   157,   131,   138,
     139,   138,   140,    85,   123,   138,   141,   138,   142,    85,
     124,   138,   143,   138,   144,    85,   125,     4,   129,   131,
     145,   147,   129,   131,   146,   148,    85,   126,    67,    88,
     150,    85,   127,   129,   151,    24,    25,    26,   122,   128,
      84,    84,    84,    84,    84,    84,    84,    84,    85,   102,
      87,    87,   162,   162,   158,   161,    88,    89,    88,    89,
      88,    89,    88,    89,    88,    89,    88,    89,    67,    67,
     158,    88,    89,    67,    67,   158,    88,    89,    86,    91,
     131,   156,   157,    88,    89,   138,   153,   138,   154,     4,
     130,   155,    85,   128,    45,    85,   116,   131,   189,   190,
      45,    85,   110,   131,   166,   168,    45,    85,   111,   131,
     170,   171,    45,    85,   109,   131,   173,   174,    45,    85,
     115,   131,   176,   177,    45,    85,    86,   114,   156,   157,
     179,   180,   181,    45,    85,   113,   131,   183,   184,    45,
      85,   112,   131,   186,   187,   138,   138,   138,   138,   138,
     138,   156,   161,   161,   147,   157,   164,   157,   164,   148,
     131,   129,    88,    89,    88,    89,    88,    89,    86,    67,
      85,   190,    86,    67,    85,   168,    86,    67,    85,   171,
      86,    67,    85,   174,    86,    67,    85,   177,    86,   156,
     181,    49,    51,    55,    55,    57,    58,    59,    63,    65,
      74,    79,    88,    85,   180,    88,    86,    67,    85,   184,
      86,    67,    85,   187,    87,   138,   138,   130,   130,   156,
     157,   130,    86,   156,   167,   130,    84,   130,   156,   130,
     157,   130,    87,   156,   156,   156,    86,   157,    86,   157,
      86,   157,    86,   157,    86,    86,    86,    86,   130,   157,
     130,   156,   158,    67,    88,    88,    67,   156,   167,    49,
      51,    55,    93,    94,    88,    67,     8,    67,    88,    67,
      88,    67,    55,    57,    58,    59,    63,    65,    74,    79,
      88,   131,   181,    88,   181,    88,   181,    88,   181,    88,
     181,   181,   181,   181,    67,    88,    67,    88,   133,   133,
      87,   156,   156,   156,   156,   156,   133,    86,   157,   167,
     133,   133,   133,    86,   157,    86,   157,    86,   157,    86,
     157,   157,   157,   157,   157,    87,    87,    87,    87,    87,
      87,    87,    87,   133,   133,    87,    87,    87,    10,    10,
      87,    87,    87,   181,    88,   181,    88,   181,    88,   181,
      88,    88,    88,    88,    88,    88,    88,    88,    88,    88,
      88,    88,    88,    87,    87,    84,    84,    84,   156,   156,
      84,    84,    84,    87,    87,    87,    87,    84,    84,   189,
     166,   170,     9,    85,     9,    85,   173,   176,   179,    88,
      88,    88,    88,   183,   186,    85,    85,    85,   156,    88,
     156,    88,    85,    85,    85,    85,    85,    85,    85,    88,
      88
};

#if ! defined (YYSIZE_T) && defined (__SIZE_TYPE__)
# define YYSIZE_T __SIZE_TYPE__
#endif
#if ! defined (YYSIZE_T) && defined (size_t)
# define YYSIZE_T size_t
#endif
#if ! defined (YYSIZE_T)
# if defined (__STDC__) || defined (__cplusplus)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# endif
#endif
#if ! defined (YYSIZE_T)
# define YYSIZE_T unsigned int
#endif

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR               goto yyerrlab1

/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { 								\
      yyerror ("syntax error: cannot back up");\
      YYERROR;							\
    }								\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

/* YYLLOC_DEFAULT -- Compute the default location (before the actions
   are run).  */

#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)         \
  Current.first_line   = Rhs[1].first_line;      \
  Current.first_column = Rhs[1].first_column;    \
  Current.last_line    = Rhs[N].last_line;       \
  Current.last_column  = Rhs[N].last_column;
#endif

/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

#  include <stdio.h> 

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (0)

# define YYDSYMPRINT(Args)			\
do {						\
  if (yydebug)					\
    yysymprint Args;				\
} while (0)

# define YYDSYMPRINTF(Title, Token, Value, Location)		\
do {								\
  if (yydebug)							\
    {								\
      YYFPRINTF (stderr, "%s ", Title);				\
      yysymprint (stderr, 					\
                  Token, Value);	\
      YYFPRINTF (stderr, "\n");					\
    }								\
} while (0)

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (cinluded).                                                   |
`------------------------------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yy_stack_print (short *bottom, short *top)
#else
static void
yy_stack_print (bottom, top)
    short *bottom;
    short *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (/* Nothing. */; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yy_reduce_print (int yyrule)
#else
static void
yy_reduce_print (yyrule)
    int yyrule;
#endif
{
  int yyi;
  unsigned int yylineno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %u), ",
             yyrule - 1, yylineno);
  /* Print the symbols being reduced, and their result.  */
  for (yyi = yyprhs[yyrule]; 0 <= yyrhs[yyi]; yyi++)
    YYFPRINTF (stderr, "%s ", yytname [yyrhs[yyi]]);
  YYFPRINTF (stderr, "-> %s\n", yytname [yyr1[yyrule]]);
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (Rule);		\
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YYDSYMPRINT(Args)
# define YYDSYMPRINTF(Title, Token, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   SIZE_MAX < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#if YYMAXDEPTH == 0
# undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 100000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined (__GLIBC__) && defined (_STRING_H)
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
#   if defined (__STDC__) || defined (__cplusplus)
yystrlen (const char *yystr)
#   else
yystrlen (yystr)
     const char *yystr;
#   endif
{
  register const char *yys = yystr;

  while (*yys++ != '\0')
    continue;

  return yys - yystr - 1;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined (__GLIBC__) && defined (_STRING_H) && defined (_GNU_SOURCE)
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
#   if defined (__STDC__) || defined (__cplusplus)
yystpcpy (char *yydest, const char *yysrc)
#   else
yystpcpy (yydest, yysrc)
     char *yydest;
     const char *yysrc;
#   endif
{
  register char *yyd = yydest;
  register const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

#endif /* !YYERROR_VERBOSE */



#if YYDEBUG
/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yysymprint (FILE *yyoutput, int yytype, YYSTYPE *yyvaluep)
#else
static void
yysymprint (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  /* Pacify ``unused variable'' warnings.  */
  (void) yyvaluep;

  if (yytype < YYNTOKENS)
    {
      YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
# ifdef YYPRINT
      YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
    }
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  switch (yytype)
    {
      default:
        break;
    }
  YYFPRINTF (yyoutput, ")");
}

#endif /* ! YYDEBUG */
/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

#if defined (__STDC__) || defined (__cplusplus)
static void
yydestruct (int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yytype, yyvaluep)
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  /* Pacify ``unused variable'' warnings.  */
  (void) yyvaluep;

  switch (yytype)
    {

      default:
        break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
# if defined (__STDC__) || defined (__cplusplus)
int yyparse (void *YYPARSE_PARAM);
# else
int yyparse ();
# endif
#else /* ! YYPARSE_PARAM */
#if defined (__STDC__) || defined (__cplusplus)
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



// Yijun Yu: utility functions -----------------------------------------------
#include <stdio.h>
/// replace character terminals into symbolic terminals
static char *YYTNAME(int r)
{
  static char yytname_buf[8];
  if (strlen(yytname[r])==3 && yytname[r][0] == '\'' && yytname[r][2] == '\'') 
  { 
        sprintf(yytname_buf, "CHAR%d", (int)yytname[r][1]);
        return yytname_buf;
  } 
  else if (strlen(yytname[r])>=2 && yytname[r][0] == 64 )
  {
    strcpy(yytname_buf,"ACTION");
    strcat(yytname_buf,&(yytname[r][1]));
    return yytname_buf;
  }

  return (char *)yytname[r];
}
#include <stdio.h>
static char *yytext_buf = NULL;

/// replace a special character in the text into an entity
static
void replace_entity(char c, char *s)
{
    char *buf;
    char *i;
    int len, l;
    i = yytext_buf;
    do {
        i =  (char *)index(i, c);
        if (i) {
            l = i - yytext_buf;
            len = strlen(yytext_buf) + strlen(s) - 1;
            //buf = (char*)YYSTACK_ALLOC(1000000);
            buf = (char*)YYSTACK_ALLOC(len + 1); // Myo M Thein
            if (l>0) {
#if 1 // Myo M Thein
		strncpy(buf, yytext_buf, l);
#else
		int t = 0;
		while (t < l) {
			buf[t] = yytext_buf[t]; 
			t++;
		}
                buf[t] = 0;
#endif
            } else {
                buf[0] = 0;
            }
            strcat(buf, s); 
            strncat(buf, yytext_buf + l + 1, strlen(yytext_buf) - l); 
            buf[len] = 0;
            YYSTACK_FREE(yytext_buf); 
            //yytext_buf = buf;
	    memcpy(yytext_buf,buf,len+1);
        i++;
        if (*i=='\0')
            i=NULL;
        }
    } while (i);
}

/// replace the special characters in the text into entities 
static
char* xml_encode( char ch)
{
  static char text[2];
    switch(ch)
    {
    case '&':
        return ( "&amp;");
        break;
    case '>':
        return ( "&gt;");
        break;
    case '<' :
        return ( "&lt;" );
        break;
    case  '\"':
        return ( "&quot;");
        break;
    case '\'':
        return ( "&apos;");
        break;
    default:
        text[0]=ch;
        text[1]=0;
        return text;
        break;
    }
}

static
void replace_special_entities(char *text,char *text_out)
{
  int i,lg;
    if (!text) { strcpy(text_out,"??");return ; }
    lg = strlen(text);
    strcpy(text_out,"");
    for (i=0;i<lg;i++)
    {
       strcat(text_out,xml_encode(text[i]));
    }
}
static
void generate_xml_output(char **yyxsp,char **yyxs)
{
#ifndef YYYAXX_XML 
#define YYYAXX_XML  "yaxx.xml"
#endif
#ifndef YYYAXX_DTD
#define YYYAXX_DTD "yaxx.dtd"
#endif
       int r, i, j;
       char buf[2000];
       int old_rule = 0;
       FILE *stdout = fopen(YYYAXX_XML, "w");
       char *p = *yyxsp + 6;
#if 0
       char *v = strsep(&p, ">");
       strcpy(buf, v);
#else
	   i = 0;
	   while (p[i]!='>') {
		buf[i] = p[i];
		i++;
	   }
	   buf[i]  = 0;
#endif
       /// Generating the XML document 
       /// version 
       fprintf(stdout,"<?xml version=\"1.0\"?>\n");
       /// DTD reference
       fprintf(stdout,"<?xml-stylesheet type=\"text/xsl\" href=\"yaxx.xsl\"?>");
       fprintf(stdout,"<!DOCTYPE %s SYSTEM \"" YYYAXX_DTD "\">\n", buf);
       /// inserting name space before the XML data
       fprintf(stdout,"<yaxx:%s xmlns:yaxx=\"urn:YAcc-Xml-eXtension\"%s\n", buf,
            yyxs[1]+i+6); //ffprintf(stdout,f, "%s\n", yyxs[1]);
       /// Generating the document type definition (DTD) 
       stdout = fopen(YYYAXX_DTD , "w");
       /// DTD for non-terminals
       for (r = 2; r < sizeof(yyr1)/sizeof(unsigned short); r++) 
       {
        j = yyr1[r];
        if (j != old_rule) {
        	if (old_rule!=0)
        		fprintf(stdout,")>\n");
	        fprintf(stdout,"<!ELEMENT %s (", YYTNAME(yyr1[r]));
        } else
	    	fprintf(stdout," | ");
        if (yyr2[r]==0) 
           fprintf(stdout,"EMPTY");
        else {
        	int multiple = 0;
            for (i = yyprhs[r]; yyrhs[i] > 0 ; i++)
               if (i!=yyprhs[r]) {
               	multiple = 1; break;
               }
       		if (multiple) fprintf(stdout,"(");
            for (i = yyprhs[r]; yyrhs[i] > 0 ; i++) {
               if (i!=yyprhs[r])
                   fprintf(stdout,",");
               fprintf(stdout,"%s", YYTNAME(yyrhs[i]));
            }
       		if (multiple) fprintf(stdout,")");
         }
         old_rule = j;
       }
       fprintf(stdout,")>\n");
       /// DTD for terminals
       for (r = 3; r < YYNTOKENS; r++) 
       {
            fprintf(stdout,"<!ELEMENT %s (#PCDATA)>\n", YYTNAME(r));
       }
    
}

//------------------------------------------------------------------------
/*----------.
| yyparse.  |
`----------*/
// Yijun Yu
#include <stdio.h>
char *yytext=NULL;

#ifdef YYPARSE_PARAM
# if defined (__STDC__) || defined (__cplusplus)
int yyparse (void *YYPARSE_PARAM)
# else
int yyparse (YYPARSE_PARAM)
  void *YYPARSE_PARAM;
# endif
#else /* ! YYPARSE_PARAM */
#if defined (__STDC__) || defined (__cplusplus)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  register int yystate;
  register int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyxs': related to xml tags,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  short	yyssa[YYINITDEPTH];
  short *yyss = yyssa;
  register short *yyssp;

  // Yijun Yu: for XML
  /* The tags stack. */
  char *yyxsa[YYINITDEPTH];
  char **yyxs = yyxsa;
  register char **yyxsp;
  //-----------------------------------------------

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  register YYSTYPE *yyvsp;


// Yijun Yu: don't forget yyxsp--
#define YYPOPSTACK   (yyvsp--, yyxsp--, yyssp--)
static char * yyxml_string=NULL; // for XML

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* When reducing, the number of symbols on the RHS of the reduced
     rule.  */
  int yylen;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  // Yijun Yu: don't forget yyxsp
  yyxsp = yyxs;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed. so pushing a state here evens the stacks.
     */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack. Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	// Yijun Yu: don't forget yyxs
    char **yyxs1 = yyxs;
	short *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow ("parser stack overflow",
		    &yyss1, yysize * sizeof (*yyssp),
		    // Yijun Yu: don't forget yyxsl
		    &yyxs1, yysize * sizeof (*yyxsp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);
    yyxs = yyxs1;

	yyss = yyss1;
	// Yijun Yu: don't forget yyxsl
    yyxs = yyxs1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyoverflowlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyoverflowlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	short *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
    char **yyxs1 = yyxs;
	if (! yyptr)
	  goto yyoverflowlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
		// Yijun Yu: yyxsp
      yyxsp = yyxs + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
    { // Yijun Yu: process the terminal
      yyxml_string = (char *) XML_ALLOC(200);
      strcpy(yyxml_string, "<yaxx:");
      strcat(yyxml_string, YYTNAME(yytoken));      
      strcat(yyxml_string, ">");
      if (yytoken < YYNTOKENS) {
          char *tmp;
          tmp=(char *)YYSTACK_ALLOC(6*strlen(yytext)+1); 
          replace_special_entities(yytext,tmp);
          strcat(yyxml_string, tmp);
          YYSTACK_FREE(tmp);
      }
      strcat(yyxml_string, "</yaxx:");
      strcat(yyxml_string, YYTNAME(yytoken));
      strcat(yyxml_string, ">\n");
    }
      YYDSYMPRINTF ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */
  YYDPRINTF ((stderr, "Shifting token %s, ", yytname[yytoken]));

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

	// Yijun Yu: update yyxsp
  *++yyxsp = yyxml_string;
  yyxml_string = 0;
  *++yyvsp = yylval;


  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  yystate = yyn;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
    {
      int len = 0;
      int alloc_len=0;
      int n = 0;
      int yyi;
      int i;
      for (yyi = yyprhs[yyn]; yyrhs[yyi] > 0 ; yyi++, n++) {
          int l;
          char * yyxml_str = yyxsp[-n];
          if (yyxml_str==NULL) {
            l = 0;
          } else
              l = strlen(yyxml_str);
          len += l;
      }
      alloc_len =len+100+2*strlen(YYTNAME(yyr1[yyn]));
      yyxml_string = (char *) XML_ALLOC(alloc_len);
      strcpy(yyxml_string, "<yaxx:");
      strcat(yyxml_string, YYTNAME(yyr1[yyn]));
      strcat(yyxml_string, ">\n");
      i = n;
      for (yyi = yyprhs[yyn]; yyrhs[yyi] > 0; yyi++, i--) 
      {
          char * yyxml_str = yyxsp[1-i];
          if (yyxml_str) {
              strcat(yyxml_string, yyxml_str); 
              XML_FREE(yyxml_str);
              yyxsp[1-i] = NULL;
          } else {
            fprintf(stderr, "Warning! the %d-th argument is empty", n-i+1);
          }
      }
      strcat(yyxml_string, "</yaxx:");
      strcat(yyxml_string, YYTNAME(yyr1[yyn]));
      strcat(yyxml_string, ">\n");
      yyxsp -= n;
      *++yyxsp = yyxml_string;
      yyxml_string = NULL;
    }
  switch (yyn)
    {
        case 4:
#line 91 "hys.y"
    {;}
    break;

  case 5:
#line 92 "hys.y"
    {;}
    break;

  case 6:
#line 93 "hys.y"
    {;}
    break;

  case 7:
#line 97 "hys.y"
    {;}
    break;

  case 8:
#line 98 "hys.y"
    {;}
    break;

  case 9:
#line 99 "hys.y"
    {;}
    break;

  case 10:
#line 100 "hys.y"
    {;}
    break;

  case 11:
#line 101 "hys.y"
    {;}
    break;

  case 23:
#line 122 "hys.y"
    {;}
    break;

  case 24:
#line 124 "hys.y"
    {;}
    break;

  case 25:
#line 126 "hys.y"
    {;}
    break;

  case 26:
#line 128 "hys.y"
    {;}
    break;

  case 27:
#line 130 "hys.y"
    {;}
    break;

  case 28:
#line 133 "hys.y"
    {;}
    break;

  case 29:
#line 134 "hys.y"
    {;}
    break;

  case 38:
#line 166 "hys.y"
    {;}
    break;

  case 39:
#line 167 "hys.y"
    {;}
    break;

  case 40:
#line 169 "hys.y"
    {;}
    break;

  case 41:
#line 170 "hys.y"
    {;}
    break;

  case 42:
#line 172 "hys.y"
    {;}
    break;

  case 43:
#line 173 "hys.y"
    {;}
    break;

  case 44:
#line 175 "hys.y"
    {;}
    break;

  case 45:
#line 176 "hys.y"
    {;}
    break;

  case 46:
#line 178 "hys.y"
    {;}
    break;

  case 47:
#line 179 "hys.y"
    {;}
    break;

  case 48:
#line 181 "hys.y"
    {;}
    break;

  case 49:
#line 182 "hys.y"
    {;}
    break;

  case 50:
#line 185 "hys.y"
    {;}
    break;

  case 51:
#line 186 "hys.y"
    {;}
    break;

  case 52:
#line 188 "hys.y"
    {;}
    break;

  case 53:
#line 189 "hys.y"
    {;}
    break;

  case 54:
#line 191 "hys.y"
    {;}
    break;

  case 55:
#line 192 "hys.y"
    {;}
    break;

  case 56:
#line 194 "hys.y"
    {;}
    break;

  case 57:
#line 195 "hys.y"
    {;}
    break;

  case 58:
#line 196 "hys.y"
    {;}
    break;

  case 59:
#line 199 "hys.y"
    {;}
    break;

  case 60:
#line 202 "hys.y"
    {;}
    break;

  case 61:
#line 203 "hys.y"
    {;}
    break;

  case 62:
#line 204 "hys.y"
    {;}
    break;

  case 168:
#line 382 "hys.y"
    {;}
    break;

  case 169:
#line 383 "hys.y"
    {;}
    break;

  case 229:
#line 478 "hys.y"
    {;}
    break;


    }

/* Line 1270 of yacc.c.  */
#line 2760 "hys.tab.c"

  yyvsp -= yylen;
  yyssp -= yylen;


  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (YYPACT_NINF < yyn && yyn < YYLAST)
	{
	  YYSIZE_T yysize = 0;
	  int yytype = YYTRANSLATE (yychar);
	  char *yymsg;
	  int yyx;

	  /* Start YYX at -YYN if negative to avoid negative indexes in
	     YYCHECK.  */
          int yyxbase = yyn < 0 ? -yyn : 0;
  
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn;
          int yynsyms = sizeof (yytname) / sizeof (yytname[0]);
          int yyxlim = yychecklim < yynsyms ? yychecklim : yynsyms;
          int yycount = 0;
  
          for (yyx = yyxbase; yyx < yyxlim; yyx++)
	    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
              {
                yysize += (! yycount
                           ? sizeof (", expecting ") - 1
                           : sizeof (" or ") - 1);
                yysize += yystrlen (yytname[yyx]);
                yycount++;
                if (yycount == 5)
                  {
                    yysize = 0;
                    break;
                  }             
              }
          yysize += (sizeof ("syntax error, unexpected ")
                     + yystrlen (yytname[yytype]));
	  yymsg = (char *) YYSTACK_ALLOC (yysize);
	  if (yymsg != 0)
	    {
	      char *yyp = yystpcpy (yymsg, "syntax error, unexpected ");
	      yyp = yystpcpy (yyp, yytname[yytype]);

	      if (yycount < 5)
		{
		  yycount = 0;
                  for (yyx = yyxbase; yyx < yyxlim; yyx++)
		    if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
		      {
			const char *yyq = ! yycount ? ", expecting " : " or ";
			yyp = yystpcpy (yyp, yyq);
			yyp = yystpcpy (yyp, yytname[yyx]);
			yycount++;
		      }
		}
	      yyerror (yymsg);
	      YYSTACK_FREE (yymsg);
	    }
	  else
	    yyerror ("syntax error; also virtual memory exhausted");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror ("syntax error");
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      /* Return failure if at end of input.  */
      if (yychar == YYEOF)
        {
	  /* Pop the error token.  */
          YYPOPSTACK;
	  /* Pop the rest of the stack.  */
	  while (yyss < yyssp)
	    {
	      YYDSYMPRINTF ("Error: popping", yystos[*yyssp], yyvsp, yylsp);
	      yydestruct (yystos[*yyssp], yyvsp);
	      YYPOPSTACK;
	    }
	  YYABORT;
        }

      YYDSYMPRINTF ("Error: discarding", yytoken, &yylval, &yylloc);
      yydestruct (yytoken, &yylval);
      yychar = YYEMPTY;

    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*----------------------------------------------------.
| yyerrlab1 -- error raised explicitly by an action.  |
`----------------------------------------------------*/
yyerrlab1:


  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;

      YYDSYMPRINTF ("Error: popping", yystos[*yyssp], yyvsp, yylsp);
      yydestruct (yystos[yystate], yyvsp);
		// Yijun Yu: don't forget yyxsp
	  yyxsp--;
      yyvsp--;
      yystate = *--yyssp;

      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  YYDPRINTF ((stderr, "Shifting error token, "));

	// Yijun Yu: yyxsp
  *++yyxsp = yyxml_string;
  yyxml_string = NULL;
  *++yyvsp = yylval;


  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  generate_xml_output(yyxsp,yyxs);
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*----------------------------------------------.
| yyoverflowlab -- parser overflow comes here.  |
`----------------------------------------------*/
yyoverflowlab:
  yyerror ("parser stack overflow");
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  return yyresult;
}


#line 690 "hys.y"



//#include <stdio.h>

/*
yyerror(s)
char *s;
{
    fflush(stdout);
    printf("Parsing error: %s\n", s);    
} 
*/


