#!/bin/bash
#SBATCH -N 1
#SBATCH -n 6
#SBATCH -p gpuk80
#SBATCH --gres=gpu:1
#SBATCH -t 1:0:0

module load cuda/9.0
module load singularity

cd mnist

# redefine SINGULARITY_HOME to mount current working directory to base $HOME
export SINGULARITY_HOME=$PWD:/home/$USER

singularity pull --name pytorch.simg shub://marcc-hpc/pytorch
singularity exec --nv ./pytorch.simg python main.py
