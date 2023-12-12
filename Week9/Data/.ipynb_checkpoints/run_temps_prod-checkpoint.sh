#!/bin/bash 
#SBATCH --job-name=KALJ_LAMMPS_prod
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --mem=16GB
#SBATCH --tasks-per-node=4
#SBATCH --cpus-per-task=1

module purge
source /scratch/work/courses/CHEM-GA-2671-2023fa/software/lammps-gcc-30Oct2022/setup_lammps.bash

#list of temps for equilibriation
temps_list=("1.5 1.0 0.9 0.8 0.7 0.65 0.6 0.55 0.5 0.475")

#create system
#mpirun lmp -var configfile ../Inputs/n360/kalj_n360_create.lmp -var id 1 -in ../Inputs/create_3d_binary.lmp

#equilibriates and anneals
for temp in "${temps_list[@]}"; do
    mpirun lmp -var configfile ../Inputs/n360/kalj_n360_T$temp.lmp -var id 1 -in ../Inputs/production_3d_binary.lmp -log log_prod_kalj_n360_T$temp.log
done


