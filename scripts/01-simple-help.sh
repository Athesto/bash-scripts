#!/usr/bin/env bash

##
# NAME
#   simple-help - this is a simple if that return the help block
#
# SYNOPSIS
#   cmd -h|--help
#
# DESCRIPTION
#   this script uses sed to print the block which starts with ##
#
# EXAMPLES
#   ./01-simple-help.sh --help
#       <print help>
#
#   ./01-simple-help.sh -h
#       <print help>
#
# AUTHOR
#   Gustavo Mejía: gamez[dot]live[at]gmail[dot]com


if [[ $1 =~ -h|--help ]]; then
    sed -e '/^##$/,/^$/ !d' \
        -e 's/^.\{1,2\}//' \
        $0
    exit;
fi

