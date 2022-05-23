#!/bin/bash
line=`cat .env |head -n 3|tail -n 1`
echo $line
version=${line: 4}
echo $version
