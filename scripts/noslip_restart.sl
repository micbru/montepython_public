#!/bin/bash -l
#SBATCH -p regular #debug
#SBATCH -N 1
#SBATCH -t 20:00:00
#SBATCH -J jobtest
#SBATCH -o sl_noslip_lite_restart_%j
#SBATCH -L SCRATCH  #note: specify license need for the file systems your job needs, such as SCRATCH,project (SCRATCH equivalent to scratch2)
 
cd ..
module load python/2.7-anaconda-4.4
source activate montepython
source /scratch1/scratchdirs/micbru/NoSlip/planck/plc-2.0/bin/clik_profile.sh

export OMP_NUM_THREADS=4

#for ((i=1; i < 7; i++ )); do
#    echo "Loop Number: "$i
#    python montepython/MontePython.py run -N 4 -r chains/noslip_lite/2018-10-12_100000__${i}.txt &
#done
#wait
# Try this using MPI directly
srun -N 1 -n 6 -c 4 python montepython/MontePython.py run -N 10000 -r chains/noslip_lite/2018-10-17_110000__1.txt

exit
