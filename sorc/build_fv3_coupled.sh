#! /usr/bin/env bash
set -eux

source ./machine-setup.sh > /dev/null 2>&1
cwd=`pwd`

USE_PREINST_LIBS=${USE_PREINST_LIBS:-"true"}
if [ $USE_PREINST_LIBS = true ]; then
  export MOD_PATH=/scratch3/NCEPDEV/nwprod/lib/modulefiles
else
  export MOD_PATH=${cwd}/lib/modulefiles
fi

# Check final exec folder exists
if [ ! -d "../exec" ]; then
  mkdir ../exec
fi

if [ $target = hera ]; then target=hera.intel ; fi
if [ $target = orion ]; then target=orion.intel ; fi

cd fv3_coupled.fd/
FV3=$( pwd -P )/FV3
cd tests/
./compile.sh "$FV3" "$target" "CCPP=Y SUITES=FV3_GFS_v15p2_coupled,FV3_GFS_v15p2_coupled_GF,FV3_GFS_v15p2_coupled_MYNNPBL,FV3_GFS_v15p2_coupled_Thompson MOM6=Y CICE6=Y WW3=Y CMEPS=Y" 1
mv -f fcst_1.exe ../NEMS/exe/nems_fv3_ccpp_mom6_cice5_ww3.x

