#!/bin/bash

if [ $# -ne '1' ]; then
  echo "Usage: submit-generator.sh <list of root URIs>"
  exit 1
fi

SCALER=1
ROOT_FILES=$1
SUBMIT_FILE_NAME=`whoami`.$ROOT_FILES.$RANDOM.submit

function init() {
echo "
executable     = parrot-wrapper.sh
universe       = vanilla

Error   = log/err.\$(Cluster).\$(Process)
Output  = log/out.\$(Cluster).\$(Process)
Log     = log/log.\$(Cluster)

transfer_executable = True
transfer_input_files=read.C,readCopy.C,Makefile,setup.sh,\$(ProxyFile)
when_to_transfer_output = ON_EXIT

# Uncomment to steer to OSG resources
requirements =isUndefined(GLIDECLIENT_Name) == FALSE

# Change to your proxy
ProxyFile = x509up_u20069
" > $SUBMIT_FILE_NAME
}

function queue()
{
  while read line  
  do 
    echo "arguments = $line" >> $SUBMIT_FILE_NAME
    echo "queue $SCALER" >> $SUBMIT_FILE_NAME
  done < $ROOT_FILES
}

init
queue 

echo "Generated submit file $SUBMIT_FILE_NAME"
