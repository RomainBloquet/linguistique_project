grammar Project;

//tokens definition
TYPE: 'int' | 'double'| 'float'|'char' |'vector';
ID : ([a-zA-Z_&"-] | [\\] |[.])+;
SC: [:];
NB : [0-9]+ ','?;
COMMENT : '//' .*? '\n' -> skip;
WS : [ \r\n\t] -> skip;


//parser rules definition
program : include* namespace* main_function;

include : '#include' '<'(ID|TYPE)'>';
namespace : 'using' 'namespace'ID';';

main_function : TYPE 'main''('')''{'statements*'}';
statements : try;
try : 'try''{'(stmt';')+'}'catch_function*;

stmt : TYPE ID
     | ID '=' expr
     | 'return' ID
     | std vect
     | std cerr
     | TYPE ID '{'ID'('NB')''}'
     ;

std : 'std''::';
vect :  TYPE'<'TYPE'>'ID'{'NB*'}';
expr : expr ('+'|'-'|'/'|'*') expr
     | ID
     ;

catch_function : 'catch''('(std ID ID|ID)*')''{'(stmt ';')+'}';

cerr: 'cerr''<<'ID (SC)* ID '<<' ID '('')' '<<' ID
    | 'cerr''<<'ID 
    ;