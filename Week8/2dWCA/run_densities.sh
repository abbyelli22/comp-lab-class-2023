#!/bin/bash 
#SBATCH --job-name=run-densities 
#SBATCH --nodes=1 
#SBATCH --tasks-per-node=4 
#SBATCH --mem=10GB 
#SBATCH --time=02:00:00 
##SBATCH --gres=gpu:1 ## To ask for a gpu, remove #, don’t need right 

module purge
source /scratch/work/courses/CHEM-GA-2671-2023fa/software/lammps-gcc-30Oct2022/setup_lammps.bash

start=0.5
step=0.1
end=1.1

densities=($(seq $start $step $end))

for i in "${densities[@]}"; do
  
    mpirun lmp -in "2dWCA.in" -var density "$i"  -log "log_2dWCA_$i.log"

done

	  

