#!/bin/bash -l
#SBATCH -p debug
#SBATCH -N 1
#SBATCH -t 00:30:00
#SBATCH -J jobtest
#SBATCH -o sl_noslip_lite_restart_%j
#SBATCH -L SCRATCH  #note: specify license need for the file systems your job needs, such as SCRATCH,project (SCRATCH equivalent to scratch2)
 
cd ..
module load python/2.7-anaconda-4.4
source activate montepython
source /scratch1/scratchdirs/micbru/NoSlip/planck/plc-2.0/bin/clik_profile.sh

export OMP_NUM_THREADS=4

for ((i=1; i < 7; i++ )); do
    python montepython/Montepython.py run -r -N 4 chains/noslip_lite/2018-10-12_100000__$i.txt &
done
wait
