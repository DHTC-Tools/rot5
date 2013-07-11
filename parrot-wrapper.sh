#!/bin/bash
# This script downloads parrot and sets it up to work with the ATLAS CVMFS

if [ $# -ne 1 ]; then
 echo "Usage: parrot-wrapper.sh <root://path/to/file.root>"
else 
  ROOT_FILE=$1
  echo "Running against file: " $ROOT_FILE
  wget http://www.cse.nd.edu/~ccl/software/files/cctools-current-x86_64-redhat5.tar.gz
  tar -xvzf cctools-current-x86_64-redhat5.tar.gz
  export HTTP_PROXY="uc3-data.uchicago.edu:3128;http://uct2-grid1.uchicago.edu:3128;DIRECT"
  export PARROT_HELPER="cctools-current-x86_64-redhat5/lib/libparrot_helper.so"
  wget http://uc3-data.uchicago.edu/rwg-web/cern.ch.pub
  ./cctools-current-x86_64-redhat5/bin/parrot_run -r atlas.cern.ch:url=http://cvmfs.racf.bnl.gov:8000/opt/atlas,pubkey=cern.ch.pub,quota_limit=1000 /bin/bash -c "source setup.sh; make; ./readDirect $ROOT_FILE physics 10 30"
hostname
  env | grep OSG_SITE
fi
