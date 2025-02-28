#!/bin/bash
#SBATCH --nodes=1                    	# requests 3 compute servers
#SBATCH --mem=10GB
#SBATCH --cpus-per-task=1            	# uses 1 compute core per task
#SBATCH --ntasks-per-node=20  
#SBATCH --time=24:00:00
#SBATCH --job-name=em_equil_prod
#SBATCH --output=em_equil_prod.out

# Generated by CHARMM-GUI (http://www.charmm-gui.org) v3.7
#
# This folder contains GROMACS formatted CHARMM36 force fields, a pre-optimized PDB structure, and GROMACS inputs.
# All input files were optimized for GROMACS 2019.2 or above, so lower version of GROMACS can cause some errors.
# We adopted the Verlet cut-off scheme for all minimization, equilibration, and production steps because it is 
# faster and more accurate than the group scheme. If you have a trouble with a performance of Verlet scheme while 
# running parallelized simulation, you should check if you are using appropriate command line.
# For MPI parallelizing, we recommand following command:
# mpirun -np $NUM_CPU mpirun gmx_mpi mdrun -ntomp 1

#cd /home/axe1/comp-lab-class/comp-lab-class-2023/FinalProj/charmm-gui-0285482339/gromacs
module load gromacs/openmpi/intel/2020.4

init=step5_input
mini_prefix=step6.0_minimization
equi_prefix=step6.1_equilibration
prod_prefix=step7_production
prod_step=step7

# Minimization
# In the case that there is a problem during minimization using a single precision of GROMACS, please try to use 
# a double precision of GROMACS only for the minimization step.
#-np 1 
gmx_mpi grompp -f ${mini_prefix}.mdp -o ${mini_prefix}.tpr -c ${init}.gro -r ${init}.gro -p topol.top -n index.ndx -maxwarn 2
gmx_mpi mdrun -v -deffnm ${mini_prefix} 


# Equilibration
#-np 1 
gmx_mpi grompp -f ${equi_prefix}.mdp -o ${equi_prefix}.tpr -c ${mini_prefix}.gro -r ${init}.gro -p topol.top -n index.ndx -maxwarn 2
gmx_mpi mdrun -v -deffnm ${equi_prefix}


# Production
cnt=1
cntmax=10

while [ ${cnt} -lt ${cntmax} ]
do
    pcnt=$((${cnt}-1))
    istep=${prod_step}_${cnt}
    pstep=${prod_step}_${pcnt}

    if [ ${cnt} -eq 1 ];then
        pstep=${equi_prefix}
        gmx_mpi grompp -f ${prod_prefix}.mdp -o ${istep}.tpr -c ${pstep}.gro -p topol.top -n index.ndx
    else
        gmx_mpi grompp -f ${prod_prefix}.mdp -o ${istep}.tpr -c ${pstep}.gro -t ${pstep}.cpt -p topol.top -n index.ndx
    fi
        gmx_mpi mdrun -v -deffnm ${istep}
    cnt=$(($cnt+1))
done
