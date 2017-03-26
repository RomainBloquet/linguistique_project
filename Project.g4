grammar Project;

//tokens definition
//TYPE of attributes or functions
TYPE: 'int' | 'double'| 'float'|'char' |'vector';
ID : ([a-zA-Z_&"-] | [\\] |[.]| [,] )+;
SC: [:]+;
NB : [0-9]+ ','?;
COMMENT : '//' .*? '\n' -> skip;
WS : [ \r\n\t] -> skip;
CV : '<<';



//parser rules definition
program : include* namespace* function*;

include : '#include' '<'(ID|TYPE)'>';
namespace : 'using' 'namespace'ID';';

function : (TYPE)* ID'('')'('{'statements*'}')*
        | TYPE ID '(' arg (',' arg)* ')' '{' statements '}'
        | ID'('(std ID ID|ID)*')''{'(stmt ';')+'}'
        | TYPE ID '('arg*')''{'(stmt ';')+'}'
        | ID'('(ID)*')'
        ;
statements : try
           |(stmt ';')+
           ;

arg : TYPE ID;
try : 'try''{'(stmt';')+'}'function*;

stmt : TYPE ID*
     | ID '=' expr
     | 'return' ID
     | std vect
     | std cerr
     | TYPE ID '{'ID'('NB')''}'
     | 'cout''<<'ID*(SC*ID+)*(CV*ID)*
     | 'cin' '>>' ID*
     | ID '=' function
     | function
     ;

std : ID SC;
vect :  TYPE'<'TYPE'>'ID'{'NB*'}';
expr : expr ('+'|'-') expr
     | expr ('/'|'*') expr
     | ID
     ;



cerr: 'cerr''<<'ID (SC)* ID '<<'  function '<<' ID
    | 'cerr''<<'ID
    ;