#!/bin/bash 
#SBATCH --job-name=pressure_ecoli
#SBATCH --output=pressure_output_%A_%a.txt  # Output file for each job
#SBATCH --time=24:00:00
#SBATCH --nodes=6
#SBATCH --mem=16GB
#SBATCH --tasks-per-node=40
#SBATCH --cpus-per-task=1
#SBATCH --array=0-4%1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=axe1@nyu.edu

module load gromacs/openmpi/intel/2020.4

pressure_list=(0 10 20 30 40)
pressure=${pressure_list[$SLURM_ARRAY_TASK_ID]}

# Create a directory for the specific pressure value
mkdir -p pressure_${pressure}
cd pressure_${pressure}

# Copy the original MDP file to the pressure directory
cp ../pressure_template.mdp pressure_${pressure}.mdp
cp ../topol.top .
cp -r ../toppar .
cp ../index.ndx .
cp ../step7_9.gro .

# Modify the MDP file or specific parameter value (ref_p) for each pressure
sed -i "s/0 0/${pressure} ${pressure}/" pressure_${pressure}.mdp

# Run GROMACS simulation for each pressure
srun gmx_mpi grompp -f pressure_${pressure}.mdp -c step7_9.gro -p topol.top -o pressure_${pressure}.tpr -n index.ndx
srun gmx_mpi mdrun -v -deffnm pressure_${pressure}


