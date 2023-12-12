#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --time=12:00:00
#SBATCH --job-name=LAMMPS_annealing
#SBATCH --output=annealing.log

# Load necessary modules (if required)
source /scratch/work/courses/CHEM-GA-2671-2023fa/software/lammps-gcc-30Oct2022/setup_lammps.bash

# Define temperature values
temperatures=(1.5 1.0 0.9 0.8 0.7 0.65 0.6 0.55 0.5 0.475)

# Command to create the system
#create_cmd="mpirun lmp -var configfile ../Inputs/n360/kalj_n360_create.lmp -var id 1 -in ../Inputs/create_3d_binary.lmp"

# Command to anneal the system from one temperature to another
anneal_cmd="mpirun lmp -var id 1 -in ../Inputs/anneal_3d_binary.lmp"

mpirun lmp -var configfile ../Inputs/n360/kalj_n360_create.lmp -var id 1 -in ../Inputs/create_3d_binary.lmp

# Loop through each temperature for equilibration
for temp in "${temperatures[@]}"; do
        #prev_temp=$(awk "BEGIN {print $temp + 0.5}")
        anneal_file="../Inputs/n360/kalj_n360_T${temp}.lmp"
        $anneal_cmd -var configfile "$anneal_file"
done

# Additional command if running 0.45 temperature
# $anneal_cmd -var configfile ../Inputs/kalj_n360_T0.45.lmp