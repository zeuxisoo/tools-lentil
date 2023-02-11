# Tools Lentil

Convert the custom syntax to specified syntax

## Development

Show the token list

    v run lentil.v token -f examples/default.tin

Show the object of abstract syntax tree

    v run lentil.v ast -f examples/default.tin

Show the string of abstract syntax tree

    v run lentil.v parse -f examples/default.tin

Generate the converted content of file in stdout

    v run lentil.v generate -f examples/default.tin
