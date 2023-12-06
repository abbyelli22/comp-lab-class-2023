#!/bin/bash 
#SBATCH --job-name=3d-run-densities 
#SBATCH --time=24:00:00
#SBATCH --nodes=6
#SBATCH --mem=16GB
#SBATCH --tasks-per-node=24
#SBATCH --cpus-per-task=2



module purge
source /scratch/work/courses/CHEM-GA-2671-2023fa/software/lammps-gcc-30Oct2022/setup_lammps.bash

start=1.0
step=0.1
end=1.5

densities=($(seq $start $step $end))

for i in "${densities[@]}"; do
  
    srun lmp -in "3dWCA.in" -var density "$i"  -log "log_3dWCA_$i.log"

done

	  

