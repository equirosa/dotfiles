#!/bin/sh
# Finds file that have been deleted through Git
git log --diff-filter=D --summary | grep "delete mode"
