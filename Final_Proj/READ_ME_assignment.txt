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

2. In the gromacs folder within the charmm-gui-# folder, run the charmm-gui generated README script to minimize energy, equilibrate, and run a production run. 

3. For pressures (0,10,20,30,40), write a script that:
    Changes the lateral (x and y) pressure on the membrane and runs for 50 ns
    Creates a new directory for each pressure 
    Copy the necessary files to each directory
    Submit this job as an array to SLURM
    
4. For each pressure and each lipid, 
    Plot the radius of gyration vs. time
    Plot the MSD vs. time
    Plot the log(MSD) vs. log(time)


