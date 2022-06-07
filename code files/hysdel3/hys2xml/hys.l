/*
	VECTOR HYSDEL
	Copyright (C) 2005  Michal Kvasnica 
	Copyright (C) 1999-2002  Fabio D. Torrisi


	This file is part of VECTOR HYSDEL.
    
	VECTOR HYSDEL is free software; you can redistribute it and/or
	modify it under the terms of the GNU General Public
	License as published by the Free Software Foundation; either
	version 2 of the License, or (at your option) any later version.

	VECTOR HYSDEL is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
	General Public License for more details.

	You should have received a copy of the GNU General Public
	License along with this library; if not, write to the Free Software
	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA

	CONTACT INFORMATION
	===================
	Michal Kvasnica
	ETH Zentrum
	Physikstrasse. 3 ETL,
	CH-8032 Zurich
	Switzerland
	mailto:kvasnica@control.ee.ethz.ch
	       kvasnica@gmail.com
*/

%option noyywrap
%option yylineno
%x comment
%{

#include "hys.tab.h"
unsigned int lineno = 1;
char linebuf[500];

%}
%%

	
[[:blank:]]+ {
	/* empty */;
}
\n.* {
/* unix-styled new line */
    strcpy(linebuf, yytext+1);
    lineno++;
    yyless(1);
}
"\r\n".* {
/* windows-styled new line */
    strcpy(linebuf, yytext+1);
    lineno++;
    yyless(1);
}

"/*" {
	BEGIN(comment);
}
<comment>[^*\n]* {
	/* eat anything that is not a star */
}
<comment>"*"+[^*/] {
	/* eat '*' not followed by '/'s */
}
<comment>\n {
/* unix-styled new line */
}
<comment>"\r\n" {
/* windows-styled new line */
}
<comment>"*"+"/" {
	BEGIN(INITIAL);
}
<<EOF>> {
	return 0;
}
[[:digit:]]*[\.[:digit:]][[:digit:]]*("E"|"e"("-"|"+")?[[:digit:]]+)? {
	return NUM;	/* NUM is defined in bison */
}


"FOR" {
        return FOR;
}


">=" {
	return GE;
}

"<=" {
	return LE;
}

"~=" {
        return NE;
}

"==" {
        return EQ;
}

"<-" {
	return AR_FI;
}

"->" {
	return AR_IF;
}

"<->" {
	return AR_IFF;
}

"||" {
	return OR;
}

"&&" {
	return AND;
}


"SYSTEM" {
        //llocp->first_line=yylineno; 
	return SYSTEM;
}
"INTERFACE" {
        //llocp->first_line=yylineno; 
	return INTERFACE;
}
"IMPLEMENTATION" {
        //llocp->first_line=yylineno; 
	return IMPLEMENTATION;
}
"IF" {
        //llocp->first_line=yylineno; 
	return IF;
}
"ELSE" {
        //llocp->first_line=yylineno; 
	return ELSE;
}
"STATE" {
        //llocp->first_line=yylineno; 
	return STATE;
}
"INPUT" {
        //llocp->first_line=yylineno; 
	return INPUT;
}
"OUTPUT" {
        //llocp->first_line=yylineno; 
	return OUTPUT;
}
"PARAMETER" {
        //llocp->first_line=yylineno; 
	return PARAMETER;
}
"MODULE" {
        //llocp->first_line=yylineno; 
	return MODULE;
}
"AUX" {
        //llocp->first_line=yylineno; 
	return AUX;
}
"AD" {
        //llocp->first_line=yylineno; 
	return AD;
}
"DA" {
        //llocp->first_line=yylineno; 
	return DA;
}
"CONTINUOUS" {
        //llocp->first_line=yylineno; 
	return CONTINUOUS;
}
"MUST" {
        //llocp->first_line=yylineno; 
	return MUST;
}
"LOGIC" {
        //llocp->first_line=yylineno; 
	return LOGIC;
}
"LINEAR" {
        //llocp->first_line=yylineno; 
	return LINEAR;
}
"REAL" {
        //llocp->first_line=yylineno; 
	return REAL;
}
"INDEX" {
        //llocp->first_line=yylineno; 
        return INDEX;
}
"BOOL" {
        //llocp->first_line=yylineno; 
	return BOOL;
}
"THEN" {
        //llocp->first_line=yylineno; 
	return THEN;
}
"AUTOMATA" {
        //llocp->first_line=yylineno; 
	return AUTOMATA;
}
"TRUE" {
        //llocp->first_line=yylineno; 
	return TRUE;
}
"FALSE" {
        //llocp->first_line=yylineno; 
	return FALSE;
}
"cos" {
        //llocp->first_line=yylineno; 
	return COS;
}
"exp" {
        //llocp->first_line=yylineno; 
	return EXP;
}
"log" {
        //llocp->first_line=yylineno; 
	return LOG;
}
"sin" {
        //llocp->first_line=yylineno; 
	return SIN;
}
"sqrt" {
        //llocp->first_line=yylineno; 
	return SQRT;
}

"sum" {
        return SUM;
}

"all" {
        return ALL;
}
 
"any" {
        return ANY;
}       

".*"  {
        return E_PROD;
}

"./"  {
        return E_DIV;
}

".^"  {
        return E_POW;
}

"abs"  {
        return ABS;
}

"log10"  {
        return LOG10;
}

"log2"  {
        return LOG2;
}

"tan"  {
        return TAN;
}

"norm_1" {
        return NORM_1;
}

"norm_inf" {
       return NORM_INF;
}

"transpose" {
       return TRANSPOSE;
}

"round" {
       return ROUND;
}

"ceil" { 
       return CEIL;
}

"floor" {
       return FLOOR;
}

[[:alpha:]]([a-zA-Z0-9_]*)(\.[a-zA-Z]+[a-zA-Z0-9_]*)* {
      //llocp->first_line=yylineno; 
    return XIDENT;
}

. {
        //llocp->first_line=yylineno; 
	return *yytext;
}
%%
void yyerror(char *s)
{
    fflush(stdout);
    printf("Line %d: syntax error at \"%s\" in:\n%s\n", lineno, yytext, linebuf);
}
