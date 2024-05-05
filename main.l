%{
#include <stdio.h>
#include <stdlib.h>
%}

%option noyywrap
%x STRING

%%

 /* Keywords */
"var"     { printf("KEYWORD_VAR\n");     }
"val"     { printf("KEYWORD_VAL\n");     }
"bool"    { printf("KEYWORD_BOOL\n");    }
"char"    { printf("KEYWORD_CHAR\n");    }
"int"     { printf("KEYWORD_INT\n");     }
"real"    { printf("KEYWORD_REAL\n");    }
"true"    { printf("KEYWORD_TRUE\n");    }
"false"   { printf("KEYWORD_FALSE\n");   }
"class"   { printf("KEYWORD_CLASS\n");   }
"if"      { printf("KEYWORD_IF\n");      }
"else"    { printf("KEYWORD_ELSE\n");    }
"for"     { printf("KEYWORD_FOR\n");     }
"while"   { printf("KEYWORD_WHILE\n");   }
"do"      { printf("KEYWORD_DO\n");      }
"switch"  { printf("KEYWORD_SWITCH\n");  }
"case"    { printf("KEYWORD_CASE\n");    }
"fun"     { printf("KEYWORD_FUN\n");     }
"ret"     { printf("KEYWORD_RET\n");     }
"main   " { printf("KEYWORD_FUNCTION_MAIN\n");      }
"println" { printf("KEYWORD_FUNCTION_PRINTLN\n");   }

 /* Operator & Assignment */
"+" { printf("ADDITION\n");         }
"-" { printf("SUBTRACTION\n");      }
"*" { printf("MULTIPLICATION\n");   }
"/" { printf("DIVISION\n");         }
"=" { printf("ASSIGNMENT\n");       }

 /* Others */
";" { printf("SEMICOLON\n");        }
":" { printf("COLON\n");            }
"," { printf("COMMA\n");            }
"." { printf("DOT\n");              }
"(" { printf("LEFT_PARENTHESIS\n"); }
")" { printf("RIGHT_PARENTHESIS\n");}
"[" { printf("LEFT_BRACKET\n");     }
"]" { printf("RIGHT_BRACKET\n");    }
"{" { printf("LEFT_BRACE\n");       }
"}" { printf("RIGHT_BRACE\n");      }

 /* Comparison */
"==" { printf("EQUALITY_COMPARISON\n");         }
"!=" { printf("INEQUALITY_COMPARISON\n");       }
">"  { printf("LARGER_THAN\n");                 }
"<"  { printf("SMALLER_THAN\n");                }
">=" { printf("LARGER_THAN_OR_EQUAL_TO\n");     }
"<=" { printf("SMALLER_THAN_OR_EQUAL_TO\n");    }

 /* Escape */
"\'" { printf("SINGLE_QUOTATION\n");                }
"\"" { printf("DOUBLE_QUOTATION\n"); BEGIN(STRING); }
"\\" { printf("BACKSLASH\n");                       }
"\?" { printf("QUESTION_MARK\n");                   }  // 測資沒有

 /* Identifiers & Literal */
[a-zA-Z_][a-zA-Z0-9_]* { printf("IDENTIFIER: %s\n", yytext);        }
[0-9]+                 { printf("LITERAL_INTEGER: %s\n", yytext);   }
[0-9]+"."[0-9]+        { printf("LITERAL_REAL: %s\n", yytext);      }

 /* String condition */
<STRING>[^"\n]+        {
    printf("LITERAL_STRING: %s\n", yytext); 
}
<STRING>\"             { 
    printf("DOUBLE_QUOTE\n");
    BEGIN 0;
}

[ \t\n]+                    { /* Ignore whitespace & newlines*/ }
\/\/[^\n]*\n                { /* Ignore single-line comments */ }
"/*"([^*]|\*+[^*/])*\*+"/"  { /* Ignore multi-line comments */  }
.                           { printf("ERROR: Unknown token %s\n", yytext); }

%%
int main(int argc, char **argv)
{
    yylex();
    return 0;
}
