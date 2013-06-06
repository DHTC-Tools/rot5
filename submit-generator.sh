#!/bin/bash


## These can be changed. scale factor is just the number after "queue" in the
## submit file

PROXY=x509up_u20069
SCALE_FACTOR=5

###############################################################################
if [ $# -ne '1' ]; then
  echo "Usage: submit-generator.sh <list of root URIs>"
  exit 1
fi


ROOT_FILES=$1
SUBMIT_FILE_NAME=`whoami`.$ROOT_FILES.$RANDOM.submit

function init() {
echo "
executable     = parrot-wrapper.sh
arguments      = root://fax.mwt2.org:1094//atlas/dq2/user/flegger/MWT2/user.flegger.MWT2.data12_8TeV.00212172.physics_Muons.merge.NTUP_SMWZ.f479_m1228_p1067_p1141_tid01007411_00/NTUP_SMWZ.01007411._000113.MWT2.root.1
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
