%{
/** yylex is called from the pure_parser. It cannot be a method. */
/* int yylex (YYSTYPE *lvalp, struct yyltype *llocp, lexer_input *l_in); */
#define YYERROR_VERBOSE
//#define yyerror(msg) yysmarterror(msg,yylloc.first_line) 
#include <stdio.h>


//void yysmarterror(const char * s, int line) {
//	printf("line %d: %s\n", line, s);
//} 

%} 

%name-prefix="yy" /* accorunarding to Sebastien Fricker */
%union {
    int ival;
    double dval;  
    char *sval;
    void *vval;
} 


%token <dval> NUM  /* double precision number */
%token <sval>  XIDENT
%token   SYSTEM INTERFACE IMPLEMENTATION	/* KEYWORDS*/
%token   IF ELSE THEN STATE INPUT		/* KEYWORDS*/
%token   OUTPUT PARAMETER MODULE AUX AD DA	/* KEYWORDS*/
%token   CONTINUOUS AUTOMATA MUST LOGIC	/* KEYWORDS*/
%token   LINEAR REAL BOOL INDEX TRUE FALSE	/* KEYWORDS*/
%token   EXP SQRT SIN COS TAN LOG LOG10 LOG2        /* operators on scalarexp*/
%token   ABS NORM_1 NORM_INF TRANSPOSE          /* operators on vectors */
%token   SUM ALL ANY INF FOR FLOOR CEIL ROUND 

/* %token LE "<=" */
/* %token GE ">=" */
%token LE leq
%token GE geq
%token NE neq
%token EQ eq

/* %token AR_FI "<-" */
/* %token AR_IF "->" */
/* %token AR_IFF "<->" */
%token AR_FI
%token AR_IF
%token AR_IFF

/* element-wise token E_PROD ".*" */
/* element-wise token E_DIV "./" */
/* element-wise token E_POW ".^" */
%token E_PROD
%token E_DIV
%token E_POW

/* %token OR "||" */
/* %token AND "&&" */
%token OR or
%token AND and

//%token CYCLE_START cycle_start
//%token CYCLE_END cycle_end


%right '='
%left '-' '+'
%left '*' '/'
%left '^'
%left UNARY
%left '|' "||"
%left "<-" "->" "<->"
%left '&' "&&"
%left '!' '~'
%left SCAL
/*end bison declarations*/ 
/****************************************************************************** 
 * Grammar begins                                                             * 
 ******************************************************************************/
%%
/****************************************************************************** 
 * Hi level rules                                                             * 
 ******************************************************************************/
system: 
        SYSTEM indexed_ident_t '{' interface implementation_t '}' ;

interface:
	INTERFACE '{' interface_list_t '}' ;

interface_list_t:
	interface_list_t interface_item_t {}
	| interface_item_t {}
	| /*empty*/ {};
	
	
interface_item_t:
	state_interface_t {}
	| input_interface_t {}
	| output_interface_t {}
	| parameter_interface_t {}
        | module_interface_t {}
        ;

implementation_t:
	IMPLEMENTATION '{' aux_impl_t section_list_t '}';
	
section_list_t:
	section_t 
	| section_list_t section_t;
		
section_t:
	logic_section_t 
	| linear_section_t 
	| AD_section_t
	| DA_section_t
	| continuous_section_t
	| automata_section_t
	| output_section_t 
	| must_section_t ;

state_interface_t:
	STATE '{' state_decl_list_t '}' {};
input_interface_t:
	INPUT '{' input_decl_list_t '}' {};
output_interface_t:
	OUTPUT '{' output_decl_list_t '}' {};
parameter_interface_t:
	PARAMETER '{' parameter_decl_list_t '}' {};
module_interface_t:
        MODULE '{' module_decl_list_t '}' {};

aux_impl_t:
	/*empty*/ {}
        | AUX '{' aux_decl_list_t '}' {};

continuous_for_t:
        FOR '(' iterator_ident_t '=' cycle_item_t ')' '{' continuous_list_t '}';

AD_for_t:
        FOR '(' iterator_ident_t '=' cycle_item_t ')' '{' AD_list_t '}';

DA_for_t:
        FOR '(' iterator_ident_t '=' cycle_item_t ')' '{' DA_list_t '}';

linear_for_t:
        FOR '(' iterator_ident_t '=' cycle_item_t ')' '{' linear_list_t '}';

logic_for_t:
        FOR '(' iterator_ident_t '=' cycle_item_t ')' '{' logic_list_t '}';

must_for_t:
        FOR '(' iterator_ident_t '=' cycle_item_t ')' '{' must_list_t '}';

automata_for_t:
        FOR '(' iterator_ident_t '=' cycle_item_t ')' '{' automata_list_t '}';

output_for_t:
        FOR '(' iterator_ident_t '=' cycle_item_t ')' '{' output_list_t '}';


/****************************************************************************** 
 * variable and parameter declarations                                        * 
 ******************************************************************************/

state_decl_list_t:
	state_decl_t {}
	| state_decl_list_t state_decl_t {};
input_decl_list_t:
	input_decl_t {}
	| input_decl_list_t input_decl_t {};	
output_decl_list_t:
	output_decl_t {}
	| output_decl_list_t output_decl_t {};
parameter_decl_list_t:
	parameter_decl_t {}
	| parameter_decl_list_t parameter_decl_t {};
module_decl_list_t:
        module_decl_t {}
        | module_decl_list_t module_decl_t {};
aux_decl_list_t:
	aux_decl_t {}
	| aux_decl_list_t aux_decl_t {};

state_decl_t:
	REAL state_real_ident_list_t ';' {}
	| BOOL state_bool_ident_list_t ';' {};
input_decl_t:
	REAL input_real_ident_list_t ';' {}
	| BOOL input_bool_ident_list_t ';' {};
output_decl_t:
	REAL output_real_ident_list_t ';' {}
	| BOOL output_bool_ident_list_t ';' {};
parameter_decl_t:
	REAL parameter_real_ident_list_t ';' {}
	| BOOL parameter_bool_ident_list_t ';' {}
        | module_parameter_list_t ';' {}
        ;
module_decl_t:
	module_name_t module_ident_t ';' {};

aux_decl_t:
	REAL aux_real_ident_list_t ';' {}
	| BOOL aux_bool_ident_list_t ';' {}
	| INDEX aux_index_ident_list_t ';' {};
	

ident_t:
        XIDENT;


/////////////////////////////////////////////////////////
// INDEXES
// X(i), X(i+1), X((1+k)*j), ...
iterator_ident_t:
        XIDENT;

indexed_ident_t:
	XIDENT
	| XIDENT '(' cycle_item_t ')'
	| XIDENT '(' cycle_item_t ',' cycle_item_t ')'
	;
        
index_expr_t:
        NUM
	| iterator_ident_t
	| index_expr_t '+' index_expr_t
	| index_expr_t '-' index_expr_t
	| index_expr_t '*' index_expr_t
        | index_expr_t '/' index_expr_t
        | index_expr_t '^' index_expr_t
	| '('index_expr_t')'
	| '-' index_expr_t %prec UNARY 
        | index_expr_t E_PROD index_expr_t
        | index_expr_t E_DIV index_expr_t
        | index_expr_t E_POW index_expr_t
        | COS '(' index_expr_t ')' %prec UNARY
        | EXP '(' index_expr_t ')' %prec UNARY
        | SIN '(' index_expr_t ')' %prec UNARY
        | TAN '(' index_expr_t ')' %prec UNARY
        | SQRT '(' index_expr_t ')' %prec UNARY
        | LOG '(' index_expr_t ')' %prec UNARY
        | SUM '(' index_expr_t ')' %prec UNARY
        | ABS '(' index_expr_t ')' %prec UNARY
        | LOG10 '(' index_expr_t ')' %prec UNARY
        | LOG2 '(' index_expr_t ')' %prec UNARY
        | NORM_1 '(' index_expr_t ')' %prec UNARY 
        | NORM_INF '(' index_expr_t ')' %prec UNARY 
	| TRANSPOSE '(' index_expr_t ')' %prec UNARY 
        | ROUND '(' index_expr_t ')' %prec UNARY
        | CEIL '(' index_expr_t ')' %prec UNARY
        | FLOOR '(' index_expr_t ')' %prec UNARY
          | indexed_ident_t '+' indexed_ident_t
          | indexed_ident_t '-' indexed_ident_t
          | indexed_ident_t '*' indexed_ident_t
          | indexed_ident_t '/' indexed_ident_t
          | indexed_ident_t '^' indexed_ident_t
          | indexed_ident_t E_PROD indexed_ident_t
          | indexed_ident_t E_DIV indexed_ident_t
          | indexed_ident_t E_POW indexed_ident_t
          | indexed_ident_t
          | '('indexed_ident_t')'
          | COS '(' indexed_ident_t ')' %prec UNARY
          | EXP '(' indexed_ident_t ')' %prec UNARY
          | SIN '(' indexed_ident_t ')' %prec UNARY
          | TAN '(' indexed_ident_t ')' %prec UNARY
          | SQRT '(' indexed_ident_t ')' %prec UNARY
          | LOG '(' indexed_ident_t ')' %prec UNARY
          | SUM '(' indexed_ident_t ')' %prec UNARY
          | ABS '(' indexed_ident_t ')' %prec UNARY
          | LOG10 '(' indexed_ident_t ')' %prec UNARY
          | LOG2 '(' indexed_ident_t ')' %prec UNARY
          | NORM_1 '(' indexed_ident_t ')' %prec UNARY 
          | NORM_INF '(' indexed_ident_t ')' %prec UNARY
          | ROUND '(' indexed_ident_t ')' %prec UNARY
          | CEIL '(' indexed_ident_t ')' %prec UNARY
          | FLOOR '(' indexed_ident_t ')' %prec UNARY
            | indexed_ident_t '+' index_expr_t
            | indexed_ident_t '-' index_expr_t
            | indexed_ident_t '*' index_expr_t
            | indexed_ident_t '/' index_expr_t
            | indexed_ident_t '^' index_expr_t
            | indexed_ident_t E_PROD index_expr_t
            | indexed_ident_t E_DIV index_expr_t
            | indexed_ident_t E_POW index_expr_t
            ;


//////////////////////////////////////////////////////////////
// CYCLES:
// FOR (iter = ind) { repeated_expr }

cycle_item_t:
    cycle_index_lower_t ':' cycle_index_inc_t ':' cycle_index_upper_t
    | cycle_index_lower_t ':' cycle_index_upper_t
    | '[' row_t ']'
    | index_expr_t
    | matrix_t
    ;



cycle_index_num:
    index_expr_t
    ;

cycle_index_lower_t:
    cycle_index_num
    ;
        
cycle_index_upper_t:
    cycle_index_num
    ;
    
cycle_index_inc_t:
    cycle_index_num
    ;


//////////////////////////////////////////////////////////////

ios_ident_t:
        indexed_ident_t
	| indexed_ident_t opt_var_minmax_t
	;

state_real_ident_list_t:
        ios_ident_t
	| state_real_ident_list_t ',' ios_ident_t
	;

state_bool_ident_list_t:
	ios_ident_t
	| state_bool_ident_list_t ',' ios_ident_t
	;

input_real_ident_list_t:
	ios_ident_t
	| input_real_ident_list_t ',' ios_ident_t
	;

input_bool_ident_list_t:
	ios_ident_t
	| input_bool_ident_list_t ',' ios_ident_t
	;

output_real_ident_list_t:
	ios_ident_t
	| output_real_ident_list_t ',' ios_ident_t
	;
                                                                   
output_bool_ident_list_t:                                          
	ios_ident_t                                                
	| output_bool_ident_list_t ',' ios_ident_t
	;


parameter_real_ident_list_t:
	parameter_real_ident_t
	| parameter_real_ident_list_t ',' parameter_real_ident_t;
parameter_bool_ident_list_t:
	parameter_bool_ident_t
	| parameter_bool_ident_list_t ',' parameter_bool_ident_t;
	
parameter_real_ident_t:
	ident_t '=' real_expr_t
	| ident_t '=' matrix_t
	| indexed_ident_t
	| indexed_ident_t '=' matrix_t
        | indexed_ident_t opt_var_minmax_t // bounds on symbolic REAL parameters
	;

parameter_bool_ident_t:
        | ident_t '=' logic_expr_t
        | ident_t '=' matrix_bool_t
        | indexed_ident_t '=' logic_expr_t
        | indexed_ident_t '=' matrix_bool_t
        | indexed_ident_t opt_var_minmax_t // bounds on symbolic BOOL parameters
        ;

module_parameter_list_t:
        module_parameter_t {}
        | module_parameter_list_t module_parameter_t {} 
        ;

module_parameter_t:
        ident_t '=' real_expr_t 
        | ident_t '=' logic_expr_t
        ;

module_ident_t:
        ident_t
        | module_ident_t ',' ident_t
        ;

module_name_t:
        ident_t;

aux_real_ident_list_t:
	ios_ident_t
	| aux_real_ident_list_t ',' ios_ident_t opt_var_minmax_t;
                                                                   
aux_bool_ident_list_t:                                          
	ios_ident_t                                                
	| aux_bool_ident_list_t ',' ios_ident_t;

aux_index_ident_list_t:                                          
	iterator_ident_t                                                
	| aux_index_ident_list_t ',' iterator_ident_t;

/****************************************************************************** 
 * real expressions                                                           * 
 ******************************************************************************/
real_expr_t:
	NUM
	//MK: | XIDENT
	| indexed_ident_t
	| '(' indexed_ident_t ')'
 	| '(' REAL  logic_expr_t ')'
        | matrix_t
	| real_expr_t '+' real_expr_t
	| real_expr_t '-' real_expr_t
	| real_expr_t '*' real_expr_t
	| real_expr_t '/' real_expr_t
	| real_expr_t '^' real_expr_t
	| real_expr_t E_PROD real_expr_t
	| real_expr_t E_DIV real_expr_t
	| real_expr_t E_POW real_expr_t
	| '('real_expr_t')'
	| '-' real_expr_t %prec UNARY 
	| COS '(' real_expr_t ')' %prec UNARY
	| EXP '(' real_expr_t ')' %prec UNARY
	| SIN '(' real_expr_t ')' %prec UNARY
	| TAN '(' real_expr_t ')' %prec UNARY
	| SQRT '(' real_expr_t ')' %prec UNARY
	| LOG '(' real_expr_t ')' %prec UNARY
	| SUM '(' real_expr_t ')' %prec UNARY
	| ABS '(' real_expr_t ')' %prec UNARY
	| LOG10 '(' real_expr_t ')' %prec UNARY
	| LOG2 '(' real_expr_t ')' %prec UNARY
	| NORM_1 '(' real_expr_t ')' %prec UNARY 
	| NORM_INF '(' real_expr_t ')' %prec UNARY
	| TRANSPOSE '(' real_expr_t ')' %prec UNARY  
        | ROUND '(' real_expr_t ')' %prec UNARY
        | CEIL '(' real_expr_t ')' %prec UNARY
        | FLOOR '(' real_expr_t ')' %prec UNARY
	;


/****************************************************************************** 
 * logic expressions                                                          * 
 ******************************************************************************/
logic_expr_t:
	TRUE
	| FALSE
	| indexed_ident_t
	| '(' indexed_ident_t ')'
	| logic_expr_t '|' logic_expr_t 
	| logic_expr_t OR logic_expr_t 
	| logic_expr_t '&' logic_expr_t 
	| logic_expr_t AND logic_expr_t
	| logic_expr_t AR_IF logic_expr_t
	| logic_expr_t AR_FI logic_expr_t
	| logic_expr_t AR_IFF logic_expr_t
	| '(' logic_expr_t ')'
	| '~' logic_expr_t
	| '!' logic_expr_t 
	| ANY '(' logic_expr_t ')' %prec UNARY
	| ALL '(' logic_expr_t ')' %prec UNARY
	| matrix_bool_t
	;

/****************************************************************************** 
 * min/max, min/max/eps                                                       *
 ******************************************************************************/

opt_var_minmax_t:
        /*empty*/ {}
        | matrix_t
        ;
       
row_t:
        real_expr_t
        | real_expr_t ',' row_t
        ;

rows_t:
        row_t
        | rows_t ';' row_t
        ;
                
matrix_t:
        '[' rows_t ']'
        ;

row_bool_t:
        logic_expr_t
        | logic_expr_t ',' row_bool_t
        ;

rows_bool_t:
        row_bool_t
        | rows_bool_t ';' row_bool_t
        ;
                
matrix_bool_t:
        '[' rows_bool_t ']'
        ;



/****************************************************************************** 
 * implementation of sections and items                                       * 
 ******************************************************************************/
AD_section_t:
	AD '{' '}'
	| AD '{' AD_list_t '}'
        ;
		
AD_list_t:
	AD_item_t
	| AD_list_t AD_item_t
        ;
		
real_cond_t:
        real_expr_t '<' real_expr_t 
        | real_expr_t '>' real_expr_t
        | real_expr_t LE real_expr_t 
	| real_expr_t GE real_expr_t
	| real_expr_t EQ real_expr_t
	| '(' real_cond_t ')'
	;

AD_item_t:	
	indexed_ident_t '=' real_cond_t  ';'
        | AD_for_t
	;
	
/*****************************************************************************/ 


DA_section_t:
	DA '{' '}'
	| DA '{' DA_list_t '}'
        ;

DA_list_t:
	DA_item_t
	| DA_list_t DA_item_t
        ;
					
DA_item_t:
	indexed_ident_t '=' '{' IF logic_expr_t THEN real_expr_t ELSE real_expr_t '}'   ';'
	| indexed_ident_t '=' '{' IF logic_expr_t THEN real_expr_t  '}'  ';'
	| indexed_ident_t '=' '{' IF real_cond_t THEN real_expr_t  '}'  ';'
	| indexed_ident_t '=' '{' IF real_cond_t THEN real_expr_t ELSE real_expr_t '}'  ';'
        | DA_for_t
	;

	
/******************************************************************************/

continuous_section_t:
	CONTINUOUS '{' '}'
	| CONTINUOUS '{' continuous_list_t '}';
		
continuous_list_t:		
	continuous_item_t
	| continuous_list_t continuous_item_t
	;

continuous_item_t:
	indexed_ident_t '=' real_expr_t  ';'
	| continuous_for_t
	;
	
/******************************************************************************/
automata_section_t:
	AUTOMATA '{' '}'
	| AUTOMATA '{' automata_list_t '}';

automata_list_t:		
	automata_item_t
	| automata_list_t automata_item_t;
	
automata_item_t:
	indexed_ident_t '=' logic_expr_t  ';'
    | automata_for_t
	;
		

/******************************************************************************/

must_section_t:
	MUST '{' '}'
	| MUST '{' must_list_t '}';

must_list_t:
	must_item_t
	| must_list_t must_item_t
	;

must_item_t:
	must_affine_t ';'
	| '(' must_affine_t ')' ';'
	| logic_expr_t ';'
    | logic_expr_t AR_IF logic_expr_t ';'
	| logic_expr_t AR_FI logic_expr_t ';'
	| logic_expr_t AR_IFF logic_expr_t ';'
	| logic_expr_t EQ logic_expr_t ';'
        | '(' must_affine_t ')' '|' logic_expr_t ';'
        | '(' must_affine_t ')' OR logic_expr_t ';'
        | '(' must_affine_t ')' '&' logic_expr_t ';'
        | '(' must_affine_t ')' AND logic_expr_t ';'
        | logic_expr_t '|' '(' must_affine_t ')' ';'
        | logic_expr_t OR '(' must_affine_t ')' ';'
        | logic_expr_t '&' '(' must_affine_t ')' ';'
        | logic_expr_t AND '(' must_affine_t ')' ';'
        | '(' must_affine_t ')' AR_IF logic_expr_t ';'
        | '(' must_affine_t ')' AR_FI logic_expr_t ';'
        | '(' must_affine_t ')' AR_IFF logic_expr_t ';'
	| '(' must_affine_t ')' EQ logic_expr_t ';'		
	| logic_expr_t AR_IF '(' must_affine_t ')' ';'
        | logic_expr_t AR_FI '(' must_affine_t ')' ';'
        | logic_expr_t AR_IFF '(' must_affine_t ')' ';'
	| logic_expr_t EQ '(' must_affine_t ')' ';'
	| '(' must_affine_t ')' AR_IF '(' must_affine_t ')' ';'
        | '(' must_affine_t ')' AR_FI '(' must_affine_t ')' ';'
	| '(' must_affine_t ')' AR_IFF '(' must_affine_t ')' ';'
	| '(' must_affine_t ')' EQ '(' must_affine_t ')' ';'
        | must_for_t	
        ;

must_affine_t:
	real_expr_t LE  real_expr_t
	| real_expr_t GE  real_expr_t
	| real_expr_t EQ  real_expr_t
	;

/******************************************************************************/
logic_section_t:
	LOGIC '{' '}'
	| LOGIC '{' logic_list_t '}'
	;

logic_list_t:
	logic_item_t
	|logic_list_t logic_item_t ;

logic_item_t:
	indexed_ident_t '=' logic_expr_t  ';'
        | logic_for_t
	;
	
/******************************************************************************/
linear_section_t:
	LINEAR '{' '}'
	| LINEAR '{'linear_list_t'}';

linear_list_t:
	linear_item_t
	| linear_list_t linear_item_t;

linear_item_t:
	indexed_ident_t '=' real_expr_t  ';'
        | linear_for_t
	;
	
/******************************************************************************/
output_section_t:
	OUTPUT '{' '}'
	| OUTPUT '{'output_list_t'}'
        ;

output_list_t:
	output_item_t
	| output_list_t output_item_t
        ;

output_item_t:
	indexed_ident_t '=' real_expr_t  ';' 
	| indexed_ident_t '=' logic_expr_t  ';'
        | output_for_t
	;


/****************************************************************************** 
 * Grammar ends                                                               * 
 ******************************************************************************/
%%


//#include <stdio.h>

/*
yyerror(s)
char *s;
{
    fflush(stdout);
    printf("Parsing error: %s\n", s);    
} 
*/

