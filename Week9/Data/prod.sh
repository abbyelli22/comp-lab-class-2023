#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --time=4:00:00
#SBATCH --job-name=LAMMPS_Production
#SBATCH --output=production.log

# Load necessary modules (if required)
source /scratch/work/courses/CHEM-GA-2671-2023fa/software/lammps-gcc-30Oct2022/setup_lammps.bash

# Define temperature values
temperatures=(1.5 1.0 0.9 0.8 0.7 0.65 0.6 0.55 0.5 0.475)

# Command to run production simulations
production_cmd="mpirun lmp -var id 1 -in ../Inputs/production_3d_binary.lmp"

# Loop through each temperature for production simulations
for temp in "${temperatures[@]}"; do
    $production_cmd -var temperature "$temp"
done
