m4_divert(-1)                                                       -*- C -*-

# Yacc compatible skeleton for Bison
# Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003
# Free Software Foundation, Inc.

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
# 02111-1307  USA

## ---------------- ##
## Default values.  ##
## ---------------- ##

# Stack parameters.
m4_define_default([b4_stack_depth_max], [100000])
m4_define_default([b4_stack_depth_init],  [200])


## ------------------------ ##
## Pure/impure interfaces.  ##
## ------------------------ ##


# b4_pure_if(IF-TRUE, IF-FALSE)
# -----------------------------
# Expand IF-TRUE, if %pure-parser and %parse-param, IF-FALSE otherwise.
m4_define([b4_Pure_if],
[b4_pure_if([m4_ifset([b4_parse_param],
                      [$1], [$2])],
            [$2])])


# b4_yyerror_args
# ---------------
# Arguments passed to yyerror: user args plus yylloc.
m4_define([b4_yyerror_args],
[b4_Pure_if([b4_location_if([&yylloc, ])])dnl
m4_ifset([b4_parse_param], [b4_c_args(b4_parse_param), ])])


# b4_lex_param
# ------------
# Accumulate in b4_lex_param all the yylex arguments.
# b4_lex_param arrives quoted twice, but we want to keep only one level.
m4_define([b4_lex_param],
m4_dquote(b4_pure_if([[[[YYSTYPE *]], [[&yylval]]][]dnl
b4_location_if([, [[YYLTYPE *], [&yylloc]]])])dnl
m4_ifdef([b4_lex_param], [, ]b4_lex_param)))



## ------------ ##
## Data Types.  ##
## ------------ ##

# b4_int_type(MIN, MAX)
# ---------------------
# Return the smallest int type able to handle numbers ranging from
# MIN to MAX (included).  We overwrite the version from c.m4 which relies
# on "signed char" which is not portable to old K&R compilers.
m4_define([b4_int_type],
[m4_if(b4_ints_in($@,      [0],   [255]), [1], [unsigned char],
       b4_ints_in($@,   [-128],   [127]), [1], [yysigned_char],

       b4_ints_in($@,      [0], [65535]), [1], [unsigned short],
       b4_ints_in($@, [-32768], [32767]), [1], [short],

       m4_eval([0 <= $1]),                [1], [unsigned int],

 	                                       [int])])


## ----------------- ##
## Semantic Values.  ##
## ----------------- ##


# b4_lhs_value([TYPE])
# --------------------
# Expansion of $<TYPE>$.
m4_define([b4_lhs_value],
[yyval[]m4_ifval([$1], [.$1])])


# b4_rhs_value(RULE-LENGTH, NUM, [TYPE])
# --------------------------------------
# Expansion of $<TYPE>NUM, where the current rule has RULE-LENGTH
# symbols on RHS.
m4_define([b4_rhs_value],
[yyvsp@{m4_eval([$2 - $1])@}m4_ifval([$3], [.$3])])



## ----------- ##
## Locations.  ##
## ----------- ##

# b4_lhs_location()
# -----------------
# Expansion of @$.
m4_define([b4_lhs_location],
[yyloc])


# b4_rhs_location(RULE-LENGTH, NUM)
# ---------------------------------
# Expansion of @NUM, where the current rule has RULE-LENGTH symbols
# on RHS.
m4_define([b4_rhs_location],
[yylsp@{m4_eval([$2 - $1])@}])



## --------------------------------------------------------- ##
## Defining symbol actions, e.g., printers and destructors.  ##
## --------------------------------------------------------- ##

# We do want M4 expansion after # for CPP macros.
m4_changecom()
m4_divert(0)dnl
@output @output_parser_name@
b4_copyright([Skeleton parser for Yacc-like parsing with Bison],
             [1984, 1989, 1990, 2000, 2001, 2002, 2003])[

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

]b4_identification
m4_if(b4_prefix[], [ya], [],
[/* If NAME_PREFIX is specified substitute the variables and functions
   names.  */

#define yyparse b4_prefix[]parse
#define yylex   b4_prefix[]lex
#define yyerror b4_prefix[]error
#define yylval  b4_prefix[]lval
#define yytext  b4_prefix[]text
#define YYYAXX_XML  "b4_prefix[]yaxx.xml"
#define YYYAXX_DTD  "b4_prefix[]yaxx.dtd"
#define yychar  b4_prefix[]char
#define yydebug b4_prefix[]debug
#define yynerrs b4_prefix[]nerrs
b4_location_if([#define yylloc b4_prefix[]lloc])])[

]b4_token_defines(b4_tokens)[

/* Copy the first part of user declarations.  */
]b4_pre_prologue[

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG ]b4_debug[
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE ]b4_error_verbose[
#endif

#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
]m4_ifdef([b4_stype],
[b4_syncline([b4_stype_line], [b4_filename])
typedef union m4_bregexp(b4_stype, [^{], [YYSTYPE ])b4_stype YYSTYPE;
/* Line __line__ of yacc.c.  */
b4_syncline([@oline@], [@ofile@])],
[typedef int YYSTYPE;])[
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

]b4_location_if([#if ! defined (YYLTYPE) && ! defined (YYLTYPE_IS_DECLARED)
typedef struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif
])[

/* Copy the second part of user declarations.  */
]b4_post_prologue

/* Line __line__ of yacc.c.  */
b4_syncline([@oline@], [@ofile@])[

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
	 || (]b4_location_if([YYLTYPE_IS_TRIVIAL && ])[YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  short yyss;
  char *yyxs; // Yijun Yu: for XML
  YYSTYPE yyvs;
  ]b4_location_if([  YYLTYPE yyls;
])dnl
[};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)
// Yijun Yu: for yyxs
/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
]b4_location_if(
[# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (short) + sizeof (YYSTYPE) + sizeof (YYLTYPE))	\
     + sizeof(char *) \
      + 2 * YYSTACK_GAP_MAXIMUM)],
[# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (short) + sizeof (YYSTYPE))				\
     + sizeof(char *) \
      + YYSTACK_GAP_MAXIMUM)])[

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
#define YYFINAL  ]b4_final_state_number[
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   ]b4_last[

/* YYNTOKENS -- Number of terminals. */
#define YYNTOKENS  ]b4_tokens_number[
/* YYNNTS -- Number of nonterminals. */
#define YYNNTS  ]b4_nterms_number[
/* YYNRULES -- Number of rules. */
#define YYNRULES  ]b4_rules_number[
/* YYNRULES -- Number of states. */
#define YYNSTATES  ]b4_states_number[

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  ]b4_undef_token_number[
#define YYMAXUTOK   ]b4_user_token_number_max[

#define YYTRANSLATE(YYX) 						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const ]b4_int_type_for([b4_translate])[ yytranslate[] =
{
  ]b4_translate[
};

//#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const ]b4_int_type_for([b4_prhs])[ yyprhs[] =
{
  ]b4_prhs[
};

/* YYRHS -- A `-1'-separated list of the rules' RHS. */
static const ]b4_int_type_for([b4_rhs])[ yyrhs[] =
{
  ]b4_rhs[
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const ]b4_int_type_for([b4_rline])[ yyrline[] =
{
  ]b4_rline[
};
//#endif

//#if YYDEBUG || YYERROR_VERBOSE
/* YYTNME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals. */
static const char *const yytname[] =
{
  ]b4_tname[
};
//#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const ]b4_int_type_for([b4_toknum])[ yytoknum[] =
{
  ]b4_toknum[
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const ]b4_int_type_for([b4_r1])[ yyr1[] =
{
  ]b4_r1[
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const ]b4_int_type_for([b4_r2])[ yyr2[] =
{
  ]b4_r2[
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const ]b4_int_type_for([b4_defact])[ yydefact[] =
{
  ]b4_defact[
};

/* YYDEFGOTO[NTERM-NUM]. */
static const ]b4_int_type_for([b4_defgoto])[ yydefgoto[] =
{
  ]b4_defgoto[
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF ]b4_pact_ninf[
static const ]b4_int_type_for([b4_pact])[ yypact[] =
{
  ]b4_pact[
};

/* YYPGOTO[NTERM-NUM].  */
static const ]b4_int_type_for([b4_pgoto])[ yypgoto[] =
{
  ]b4_pgoto[
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF ]b4_table_ninf[
static const ]b4_int_type_for([b4_table])[ yytable[] =
{
  ]b4_table[
};

static const ]b4_int_type_for([b4_check])[ yycheck[] =
{
  ]b4_check[
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const ]b4_int_type_for([b4_stos])[ yystos[] =
{
  ]b4_stos[
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
#define YYERROR               ]b4_location_if([do                             \
                        {                             \
                          yylerrsp = yylsp;           \
                          *++yylerrsp = yyloc;        \
                          goto yyerrlab1;             \
                        }                             \
                      while (0)],
                      [goto yyerrlab1])[

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
      yyerror (]b4_yyerror_args["syntax error: cannot back up");\
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
# define YYLEX yylex (]b4_pure_if([&yylval[]b4_location_if([, &yylloc]), ])[YYLEX_PARAM)
#else
# define YYLEX ]b4_c_function_call([yylex], [int], b4_lex_param)[
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
                  Token, Value]b4_location_if([, Location])[);	\
      YYFPRINTF (stderr, "\n");					\
    }								\
} while (0)

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (cinluded).                                                   |
`------------------------------------------------------------------*/

]b4_c_function_def([yy_stack_print], [static void],
                   [[short *bottom], [bottom]],
                   [[short *top],    [top]])[
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

]b4_c_function_def([yy_reduce_print], [static void],
                   [[int yyrule], [yyrule]])[
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
# define YYINITDEPTH ]b4_stack_depth_init[
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
# define YYMAXDEPTH ]b4_stack_depth_max[
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
]b4_yysymprint_generate([b4_c_function_def])[
#endif /* ! YYDEBUG */
]b4_yydestruct_generate([b4_c_function_def])


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
# if defined (__STDC__) || defined (__cplusplus)
int yyparse (void *YYPARSE_PARAM);
# else
int yyparse ();
# endif
#else /* ! YYPARSE_PARAM */
b4_c_function_decl([yyparse], [int], b4_parse_param)
#endif /* ! YYPARSE_PARAM */


m4_divert_push([KILL])# ======================== M4 code.
# b4_declare_parser_variables
# ---------------------------
# Declare the variables that are global, or local to YYPARSE if
# pure-parser.
m4_define([b4_declare_parser_variables],
[/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;b4_location_if([
/* Location data for the lookahead symbol.  */
YYLTYPE yylloc;])
])
m4_divert_pop([KILL])dnl# ====================== End of M4 code.

b4_pure_if([],
           [b4_declare_parser_variables])

[
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
]
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
b4_c_function_def([yyparse], [int], b4_parse_param)
#endif
{[
  ]b4_pure_if([b4_declare_parser_variables])[
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

]b4_location_if(
[[  /* The location stack.  */
  YYLTYPE yylsa[YYINITDEPTH];
  YYLTYPE *yyls = yylsa;
  YYLTYPE *yylsp;
  YYLTYPE *yylerrsp;]])[
// Yijun Yu: don't forget yyxsp--
#define YYPOPSTACK   (yyvsp--, yyxsp--, yyssp--]b4_location_if([, yylsp--])[)
static char * yyxml_string=NULL; // for XML

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;
]b4_location_if([  YYLTYPE yyloc;])[

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
]b4_location_if([  yylsp = yyls;])[
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
]b4_location_if([	YYLTYPE *yyls1 = yyls;])[

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow ("parser stack overflow",
		    &yyss1, yysize * sizeof (*yyssp),
		    // Yijun Yu: don't forget yyxsl
		    &yyxs1, yysize * sizeof (*yyxsp),
		    &yyvs1, yysize * sizeof (*yyvsp),
]b4_location_if([		    &yyls1, yysize * sizeof (*yylsp),])[
		    &yystacksize);
    yyxs = yyxs1;
]b4_location_if([	yyls = yyls1;])[
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
]b4_location_if([	YYSTACK_RELOCATE (yyls);])[
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
]b4_location_if([      yylsp = yyls + yysize - 1;])[

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
]b4_location_if([  *++yylsp = yylloc;])[

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

]b4_location_if(
[  /* Default location. */
  YYLLOC_DEFAULT (yyloc, (yylsp - yylen), yylen);])[
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
    ]{
      b4_actions
    }

/* Line __line__ of yacc.c.  */
b4_syncline([@oline@], [@ofile@])

[  yyvsp -= yylen;
  yyssp -= yylen;
]b4_location_if([  yylsp -= yylen;])[

  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;
]b4_location_if([  *++yylsp = yyloc;])[

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
	      yyerror (]b4_yyerror_args[yymsg);
	      YYSTACK_FREE (yymsg);
	    }
	  else
	    yyerror (]b4_yyerror_args["syntax error; also virtual memory exhausted");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror (]b4_yyerror_args["syntax error");
    }

]b4_location_if([  yylerrsp = yylsp;])[

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
	      yydestruct (yystos[*yyssp], yyvsp]b4_location_if([, yylsp])[);
	      YYPOPSTACK;
	    }
	  YYABORT;
        }

      YYDSYMPRINTF ("Error: discarding", yytoken, &yylval, &yylloc);
      yydestruct (yytoken, &yylval]b4_location_if([, &yylloc])[);
      yychar = YYEMPTY;
]b4_location_if([      *++yylerrsp = yylloc;])[
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
      yydestruct (yystos[yystate], yyvsp]b4_location_if([, yylsp])[);
		// Yijun Yu: don't forget yyxsp
	  yyxsp--;
      yyvsp--;
      yystate = *--yyssp;
]b4_location_if([      yylsp--;])[
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  YYDPRINTF ((stderr, "Shifting error token, "));

	// Yijun Yu: yyxsp
  *++yyxsp = yyxml_string;
  yyxml_string = NULL;
  *++yyvsp = yylval;
]b4_location_if([  YYLLOC_DEFAULT (yyloc, yylsp, (yylerrsp - yylsp));
  *++yylsp = yyloc;])[

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
  yyerror (]b4_yyerror_args["parser stack overflow");
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
  return yyresult;
]}


b4_epilogue
m4_if(b4_defines_flag, 0, [],
[@output @output_header_name@
b4_copyright([Skeleton parser for Yacc-like parsing with Bison],
             [1984, 1989, 1990, 2000, 2001, 2002, 2003])

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

b4_token_defines(b4_tokens)

#if ! defined (YYSTYPE) && ! defined (YYSTYPE_IS_DECLARED)
m4_ifdef([b4_stype],
[b4_syncline([b4_stype_line], [b4_filename])
typedef union m4_bregexp(b4_stype, [^{], [YYSTYPE ])b4_stype YYSTYPE;
/* Line __line__ of yacc.c.  */
b4_syncline([@oline@], [@ofile@])],
[typedef int YYSTYPE;])
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

b4_pure_if([],
[extern YYSTYPE b4_prefix[]lval;])

b4_location_if(
[#if ! defined (YYLTYPE) && ! defined (YYLTYPE_IS_DECLARED)
typedef struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif

m4_if(b4_pure, [0],
[extern YYLTYPE b4_prefix[]lloc;])
])
])
