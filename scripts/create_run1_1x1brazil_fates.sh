#!/bin/bash

#=============================================================================================
#
# This script will BUILD a CESM/E3SM single point simulation for the 1x1_brazil resolution.
# 1x1_brazil is a pre-made "resolution", meaning the support files domain/surface/etc are
# already available. This is a single-site, located roughly in the southern Amazon.
#
# This script taks NO ARGUMENTS
#
# contact rgknox@lbl.gov with questions/comments/cake.
#=============================================================================================
WORKDIR=/data/sserbin/Modeling/ctsm/cime/scripts/
cd $WORKDIR
echo $PWD

# UNCOMMENT FOR CHEYENNE CESM/CTSM SYSTEM
CIME_MODEL=cesm
MACH=modex
COMP=I2000Clm50FatesGs
PROJECT=P93300641


# UNCOMMENT FOR CORI E3SM SYSTEM
#CIME_MODEL=acme
#PROJECT=acme
#PROJECT=m2420
#MACH=cori-haswell
#MACH=modex
#MACH=cori-knl
#COMP=ICLM45ED

rm -rf run1_1x1brazil

./create_newcase --case run1_1x1brazil --res 1x1_brazil --compset ${COMP} --mach ${MACH} --compiler gnu --project ${PROJECT} --run-unsupported

cd run1_1x1brazil

./xmlchange --id STOP_N --val 10
./xmlchange --id RUN_STARTDATE --val '2001-01-01'
./xmlchange --id STOP_OPTION --val nyears
./xmlchange --id DATM_CLMNCEP_YR_START --val 1996
./xmlchange --id DATM_CLMNCEP_YR_END --val 2001
./xmlchange --id CLM_FORCE_COLDSTART --val on


./case.setup
./case.build

