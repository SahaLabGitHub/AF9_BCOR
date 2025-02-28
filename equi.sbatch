#!/bin/bash

#SBATCH --partition=sahalabgpu
#SBATCH -J 2-CMD_model1
#SBATCH --ntasks=8
##SBATCH --exclusive

source ~/Data/conda/bin/activate
source /sharedapps/spack/share/spack/setup-env.sh
spack env activate Gromacs-GPU
spack env activate gro1882023
spack load gromacs@2023


export CUDA_VISIBLE_DEVICES=2

date
#gmx grompp -f eq.mdp -c minim2.gro -r ions.gro -p topol.top -o equi4.tpr -n index.ndx
#gmx mdrun -v -deffnm nvt -ntomp 4 -ntmpi 2 -npme 1 -nb gpu -bonded gpu -pme gpu 
#gmx grompp -f npt.mdp -c nvt.gro -r nvt.gro -t nvt.cpt -p topol.top -o control_npt.tpr 
#gmx mdrun -v -deffnm control_npt -ntomp 4 -ntmpi 2 -npme 1 -nb gpu -bonded gpu -pme gpu
#gmx grompp -f step5_production.mdp -c control_npt.gro -r control_npt.gro -t control_npt.cpt -p topol.top -o control_md.tpr
gmx mdrun -s control_md_1micS.tpr -cpi state.cpt -noappend -ntomp 4 -ntmpi 2 -npme 1 -nb gpu -bonded gpu -pme gpu
date
