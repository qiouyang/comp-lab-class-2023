#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00
#SBATCH --mem=8GB
#SBATCH --job-name=density_simulation
#SBATCH --output=density_simulation.out


# Loop from 0.8 to 1.5 in steps of 0.1
for density in $(seq 0.8 0.1 1.5)
do
    log_file="density_${density}.log"
    mpirun lmp -var density $density -in ../Inputs/3dWCA.in -log $log_file
done
