#!/bin/bash
#SBATCH --job-name=run-alanine
#SBATCH --nodes=1
#SBATCH --tasks-per-node=4
#SBATCH --mem=8GB
#SBATCH --time=04:00:00 

module purge
module load gromacs/openmpi/intel/2018.3

gmx_mpi mdrun -mp adp.top 