#!/bin/bash


## These can be changed. scale factor is just the number after "queue" in the
## submit file

PROXY=x509up_u20069 # Add your proxy
SCALE_FACTOR=1 # Change as desired

###############################################################################
if [ $# -ne '1' ]; then
  echo "Usage: submit-generator.sh <list of root URIs>"
  exit 1
fi


ROOT_FILES=$1
SUBMIT_FILE_NAME=`whoami`.$ROOT_FILES.$RANDOM.submit

function init() {
echo "
executable     = vanilla-wrapper.sh
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
ProxyFile = $PROXY 
" > $SUBMIT_FILE_NAME
}

function queue()
{
  while read line  
  do 
    echo "arguments = $line" >> $SUBMIT_FILE_NAME
    echo "queue $SCALE_FACTOR" >> $SUBMIT_FILE_NAME
  done < $ROOT_FILES
}

init
queue

echo "Generated submit file $SUBMIT_FILE_NAME"
