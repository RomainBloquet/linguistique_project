grammar Project;

//tokens definition
TYPE: 'int' | 'double'| 'float'|'char';
ID : [a-zA-Z]+;
NB : ([0-9]+ ','?)+;
COMMENT : '//' .*? '\n' -> skip;
WS : [ \r\n\t] -> skip;

//parser rules definition
program : include* namespace* main_function;

include : '#include' '<'ID'>';
namespace : 'using' 'namespace'ID';';

main_function : TYPE 'main''('')''{'statements*'}';
statements : try*;
try : 'try''{'(stmt';')+'}';
stmt :

