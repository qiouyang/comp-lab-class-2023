#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=1
#SBATCH --time=2:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=anneal_system
#SBATCH --output=anneal_system.out


module load gromacs/openmpi/intel/2020.4
source /scratch/work/courses/CHEM-GA-2671-2023fa/software/lammps-gcc-30Oct2022/setup_lammps.bash


# Set the paths
CONFIG_PATH=/home/qo210/comp-lab-class/comp-lab-class-2023/Week9/Inputs/n360/
CREATE_SCRIPT=/home/qo210/comp-lab-class/comp-lab-class-2023/Week9/Inputs/create_3d_binary.lmp
ANNEAL_SCRIPT=/home/qo210/comp-lab-class/comp-lab-class-2023/Week9/Inputs/anneal_3d_binary.lmp

# Step 1: Create the system
mpirun lmp -var configfile $CONFIG_PATH/kalj_n360_create.lmp -var id 1 -in $CREATE_SCRIPT

# Step 2: Equilibrate at various temperatures
for temp in 1.5 1.0 0.9 0.8 0.7 0.65 0.6 0.55 0.5 0.475; do
    mpirun lmp -var configfile $CONFIG_PATH/kalj_n360_T${temp}.lmp -var id 1 -in $ANNEAL_SCRIPT
done

# Optionally, cool from temperature 2 to 1.5
mpirun lmp -var configfile $CONFIG_PATH/kalj_n360_T1.5.lmp -var id 1 -in $ANNEAL_SCRIPT

# Optionally, cool from temperature 1.5 to 1
mpirun lmp -var configfile $CONFIG_PATH/kalj_n360_T1.lmp -var id 1 -in $ANNEAL_SCRIPT