#!/bin/bash
# This script downloads parrot and sets it up to work with the ATLAS CVMFS

if [ $# -ne 1 ]; then
 echo "Usage: vanilla-wrapper.sh <http://path/to/file.root>"
else
  ROOT_FILE=$1
  echo "Running against file: " $ROOT_FILE
  source setup.sh; make; ./readDirect $ROOT_FILE physics 10 30
  hostname
fi
