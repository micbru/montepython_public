#!/bin/bash -l
#SBATCH -p debug #debug
#SBATCH -N 1
#SBATCH -t 00:10:00
#SBATCH -J jobtest
#SBATCH -o testfakeplanck.o%j
#SBATCH -L SCRATCH  #note: specify license need for the file systems your job needs, such as SCRATCH,project (SCRATCH equivalent to scratch2)
 
cd ..
module load python/2.7-anaconda-4.4
source activate montepython
source /scratch1/scratchdirs/micbru/NoSlip/planck/plc-2.0/bin/clik_profile.sh

export OMP_NUM_THREADS=4

srun  -N 1 -n 6 -c 4 \
 python montepython/MontePython.py run \
 -o chains/test_fake \
 -p input/example.param \
 -c covmat/fake_planck_lcdm.covmat  \
 -b bestfit/base.bestfit \
 -j fast --update 300 -f 2.4 \
 -N 500

exit

