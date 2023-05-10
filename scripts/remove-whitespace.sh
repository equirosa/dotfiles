#!/bin/sh
# Removes trailing whitespace from a given file.

sed -i 's/[[:space:]]*$//' "${1}"
