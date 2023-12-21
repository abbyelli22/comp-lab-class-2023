#!/bin/bash 
#SBATCH --job-name=rgyr_msd
#SBATCH --output=rgyr_msd_%A_%a.txt # Output file for each job
#SBATCH --time=1:00:00
#SBATCH --nodes=1
#SBATCH --mem=16GB
#SBATCH --tasks-per-node=3
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=ALL
#SBATCH --mail-user=axe1@nyu.edu
#SBATCH --array=0-4%1

module load gromacs/openmpi/intel/2020.4

pressure_list=(0 10 20 30 40)
pressure=${pressure_list[$SLURM_ARRAY_TASK_ID]}

# Create a directory for the specific pressure value
cd ../pressure_${pressure}

#create index file with all 3 lipids
gmx_mpi make_ndx -f step7_9.gro -o msd_index.ndx << EOF

q
EOF
#output: msd_index.ndx file

lipid_index_groups=(13 14 15)

for lipid in "${lipid_index_groups[@]}"; do

    gmx_mpi gyrate -s pressure_${pressure}.tpr -f pressure_${pressure}.trr -o rgyr_pressure_${pressure}_${lipid}.rgyr -n msd_index.ndx << EOF
    $lipid
EOF

    gmx_mpi msd -s pressure_${pressure}.tpr -f pressure_${pressure}.trr -n msd_index.ndx -o msd_pressure_${pressure}_${lipid}.xvg -lateral z << EOF
    $lipid
EOF
done

#output: 3 .rgyr files,one per lipid type
#output: 3 msd.xvg files, one per lipid 

#total: 7 files

