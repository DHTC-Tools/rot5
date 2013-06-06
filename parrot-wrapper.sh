#!/bin/bash
# This script downloads parrot and sets it up to work with the ATLAS CVMFS
 
wget http://www.cse.nd.edu/~ccl/software/files/cctools-current-x86_64-redhat5.tar.gz
export HTTP_PROXY="uc3-data.uchicago.edu:3128;http://uct2-grid1.uchicago.edu:3128;DIRECT"
export PARROT_HELPER="cctools-current-x86_64-redhat5/lib/libparrot_helper.so"
wget http://uc3-data.uchicago.edu/rwg-web/cern.ch.pub
./cctools-current-x86_64-redhat5/bin/parrot_run -r atlas.cern.ch:url=http://cvmfs.racf.bnl.gov:8000/opt/atlas,pubkey=cern.ch.pub,quota_limit=1000 /bin/bash -c 'source setup.sh; make; ./readDirect root://fax.mwt2.org:1094//atlas/dq2/user/flegger/MWT2/user.flegger.MWT2.data12_8TeV.00212172.physics_Muons.merge.NTUP_SMWZ.f479_m1228_p1067_p1141_tid01007411_00/NTUP_SMWZ.01007411._000113.MWT2.root.1 physics 10 30'
hostname
