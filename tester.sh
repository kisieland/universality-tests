#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
OUT_TMP='myOut.txt'

if [ $# != "2" ]; then
    echo "usage $0 tests/path sol.py"
    echo -e "sol.py should be exetutable and ${RED}don't print the witness${NC} in case of 'NO'"
    exit 0
fi

for file in `ls $1/*.in`; do
    fileBase=${file%.in}
    echo -n "Teseting: $fileBase: "

    python3 $2 < $fileBase.in > $OUT_TMP 2> /dev/null
    diff $OUT_TMP $fileBase.out > /dev/null 2>&1

    if [ $? == "0" ]; then
        echo -e "${GREEN}OK${NC}"
    else
        echo -e "${RED}BAD${NC}"
    fi
done

rm $OUT_TMP