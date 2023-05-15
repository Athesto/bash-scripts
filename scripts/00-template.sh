#!/usr/bin/env bash

##
# NAME
#   script-template - this is a template for script functions
#
# SYNOPSIS
#   cmd <subcommand> <args>
#
# DESCRIPTION
#   This is a template that is going to work as next projects. The project use
#   a case for every function and a help tho show this message. it starts from
#   the first ## and finish in the last ^#
#
#   # The help command
#   The sed command uses 2 expresions [-e '/^##/,/^$/ !d'], [-e 's/^.\{1,2\}//'] and 1 input [$0]
#     - The first expression select the documentation: 
#       - (/^##/) -> start from begining of a line (^) and the chars '##'
#       - (/^$/) -> end to the first empty line
#       - (!d) -> delete everyting except what is between start and end expression
#       - extended explanation: https://www.grymoire.com/Unix/Sed.html#uh-29
#     - The second expression remove the 2 first characters of every line (##) (# ) (#$)
#       - (s/) -> action, substitude
#       - (/^.\{1,2\}/) -> select what starts from begin of line (^) and select from one to two characters (.\{1,2\})
#       - (//) -> replace selection with no character. In other words, remove the selection
#     - The 3rd command use the actual execution file ($0)
#
#   # The show_commands function
#   The sed command used 2 expresions ['/^function main.*/,/^}$/ !d'], ['s/^[[:space:]]*\(.*[^\*]\))$/\1/p'],  1 input [$0]
#     - the first expression select the function main block:
#       - (/^function main.*/) -> start the selection from the line which start with function main
#       - (/^}$/) -> end the selection in the end of the main function
#       - (!d) -> delete everything except the selection block
#     - The second expression is substitude all the document by the selection
#       - (-ne) the expression says don't print the document and use the next expression
#       - (s/) substitude action
#       - (/^[[:space:]]*\(.*[^\*\))$/) -> agroup the interested section
#         - (^[[:space:]]*) -> select the lines that start with multiple spaces
#         - (\(.*[^\*])$\)) -> agroup all the words in group 1 but ignoring the one which ends in (*))
#       - (/\1/): substitude the selection by group 1
#       - (/p): print the substituion. This option is a answer of the flag -n which means don't print
#     - The 3rd expression is the ($0) which means that use the program location as input
#     - The 4th expression is sorting the output (sort)

# another comment

# GLOBAL variables

function main() {  # v1.0
    FORMATSTRING="h"

    FORMATSTRING_WITH_LONG="${FORMATSTRING}-:"
    while getopts "${FORMATSTRING_WITH_LONG}" optchar; do
        case "${optchar}" in
            -)
                case ${OPTARG} in
                    help) help_command ;;
                    *) echo "invalid long command" ;;
                esac
                ;;
            h) help_command;;
            *)
        esac
    done
    shift $(( OPTIND - 1 ))
}

function help_command(){ # v1.0
    sed -e '/^##$/,/^$/ !d' -e 's/^.\{1,2\}//' $0
}

function show_commands(){
    echo "Please, select any of the next commands:"
    echo
    sed -e '/^function main.*/,/^}$/ !d' -ne 's/^\(.*[^\*]\))$/\1/p' $0 | sort
    echo
}

function example(){
    echo "this an example of a function"
    echo "command $SUBCOMMAND"
    echo "Args: $*"
}

main "$@"
# comment

