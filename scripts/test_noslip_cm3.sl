#!/bin/bash -l
#SBATCH -p regular #debug
#SBATCH -N 1
#SBATCH -t 01:00:00
#SBATCH -J jobtest
#SBATCH -o sl_test_noslip_cm3_%j
#SBATCH -L SCRATCH  #note: specify license need for the file systems your job needs, such as SCRATCH,project (SCRATCH equivalent to scratch2)
 
cd ..
module load python/2.7-anaconda-4.4
source activate montepython
source /scratch1/scratchdirs/micbru/NoSlip/planck/plc-2.0/bin/clik_profile.sh

export OMP_NUM_THREADS=4

srun  -N 1 -n 6 -c 4 \
 python montepython/MontePython.py run \
 -o chains/test_noslip_cm3/ \
 -p input/test_noslip_cm3.param \
 -c covmat/base2015.covmat  \
 -b bestfit/base2015.bestfit \
 -j fast --update 300 -f 2.4 \
 -N 5000

exit
# Note that I could use base2015.covmat and base2015.bestfit since those are from a small run, but it's ok.
