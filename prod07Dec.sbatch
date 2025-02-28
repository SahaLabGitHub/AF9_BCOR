#!/bin/bash

#SBATCH --partition=sahalabgpu
#SBATCH -J REMD_AF9_450K
#SBATCH --exclusive

source ~/Data/conda/bin/activate
source /sharedapps/spack/share/spack/setup-env.sh
spack env activate gro1252023
spack load gromacs/w3hi5aa

export OMP_NUM_THREADS=2

export CUDA_VISIBLE_DEVICES=0,1,2,3
export CUDA_MPS_PIPE_DIRECTORY=/home/uwm/sharma69/Data/sharma69/Project_leukemia/AF9_REMD/gromacs_tremd/nvidia-mps
export CUDA_MPS_LOG_DIRECTORY=/home/uwm/sharma69/Data/sharma69/Project_leukemia/AF9_REMD/gromacs_tremd/mps_logfiles

./prod23Jan.sh

