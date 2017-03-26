grammar Project;

//tokens definition
TYPE: 'int' | 'double'| 'float'|'char' |'vector';
ID : ([a-zA-Z_&"-] | [\\] |[.])+;
SC: [:]+;
NB : [0-9]+ ','?;
COMMENT : '//' .*? '\n' -> skip;
WS : [ \r\n\t] -> skip;


//parser rules definition
program : include* namespace* function;

include : '#include' '<'(ID|TYPE)'>';
namespace : 'using' 'namespace'ID';';

function : (TYPE)* ID'('')'('{'statements*'}')*
        | TYPE ID '(' arg (',' arg)* ')' '{' statements '}'
        | ID'('(std ID ID|ID)*')''{'(stmt ';')+'}'
        ;
statements : try
           |(stmt ';')+
           ;

arg : TYPE ID;
try : 'try''{'(stmt';')+'}'function*;

stmt : TYPE ID
     | ID '=' expr
     | 'return' ID
     | std vect
     | std cerr
     | TYPE ID '{'ID'('NB')''}'
     ;

std : 'std'SC;
vect :  TYPE'<'TYPE'>'ID'{'NB*'}';
expr : expr ('+'|'-'|'/'|'*') expr
     | ID
     ;



cerr: 'cerr''<<'ID (SC)* ID '<<'  function '<<' ID
    | 'cerr''<<'ID
    ;