Final Project Computational Chemistry 
Abby Ellingwood

Using Charmm-gui membrane builder and Gromacs, model how the addition of lateral pressure affects the diffusion (mean squared displacement) and compactness (radius of gyration) of the lipids in the E. coli membrane with the large mechanosensitive channel.

1. Create an E. coli membrane in Charmm-gui with the large mechanosensitive channel (https://www.rcsb.org/structure/2OAR ). 
    Each leaflet of the E. coli membrane should have a lipid composition of:
    75% PE	Phosphatidylethanolamine 	DOPE
    20% PG	Phosphatidylglycerol 		DOPG
    5% CL		Cardiolipin 			TOCL1
    * Lipid composition of E.coli membrane based on this paper: 
    https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5472821/#:~:text=1A).-,E.,%2C%20and%20%E2%88%BC5%25%20CL 

    Run ppm 2 to orient.
    Set the length of X and Y to 100A. 
    Choose GROMACS for input generation options. 
    Leave as default for all other options.
    Download the .tgz file, send to your HPC account, and untar.
    
    #### SOLUTION ####
    Output: You should have a charmm-gui-# file with all the Charmm-gui generated files.

2. In the gromacs folder within the charmm-gui-# folder, run the charmm-gui generated README script to minimize energy, equilibrate, and run a production run. 

    #### SOLUTION ####
    Output: You should produce many intermediary files for energy minimization, equilibration, and production. I organized these into 
    folders with the same name as the step (energy_min, equil, and prod). I have put the charmm-gui generated script for energy minimization, equilabration, and production in the run_scripts/testing folder. I used a slightly modified version of this file (energymin_equil_prod.sh). 
    
3. For pressures (0,10,20,30,40), write a script that:
    Changes the lateral (x and y) pressure on the membrane and runs for 50 ns
    Creates a new directory for each pressure 
    Copy the necessary files to each directory
    Submit this job as an array to SLURM
    
    #### SOLUTION ####
    Output: There should be pressure_num folders for each pressure listed above. Each folder will contain the required input files (step7_9.gro, index.ndx, topol.top, toppar folder, .mdp file). In the run_scripts folder, I created a file called run_presssure.sh that creates a directory for each pressure, copies the required files into it, changes the .mdp file to reflect the pressure value (changed ref_p) of that directory, and runs a 50 ns simulation. There will be 7 additional pressure_num files after the simulation finishes. 
   
4. For each pressure and lipid, write a script that computes the radius of gyration and mean squared displacement. 
    
    #### SOLUTION ####
    Output: After running the run_rgyr_msd.sh file in the run_scripts folder, for each pressure_num folder there should be 3 rgyr files and 3 msd files, and a msd_index.ndx file. 
   
4. For each pressure and each lipid, 
    Plot the radius of gyration vs. time
    Plot the MSD vs. time
    Plot the log(MSD) vs. log(time)
    
    #### SOLUTION ####
    Output: Jupyter notebook analysis file called Analysis_rgyr_msd.ipynb creates a folder of all rgyr files (rgyr) and a folder of all msd files (msd). Then it plots rgyr for each pressure and each lipid. Same for MSD in addition to a log log plot. The plots are saved in the Figures folder. 
    
    
#### SOLUTION SUMMARY ####
1. Download membrane with large mechanosensitive channel 2OAR from Charmm-gui.
2. Energy Minimization, equilibration, production run (energymin_equil_prod.sh or charmm-gui_generated_file)
3. Run 50 ns variable pressure simulation (run_pressure.sh)
4. Compute radius of gyration and mean squared displacement (run_rgyr_msd.sh)
4. Analyze and plot in Jupyter notebook (Analysis_rgyr_msd.ipynb)
#### END SOLUTION SUMMARY: HAPPY HOLIDAYS! ####