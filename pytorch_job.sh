#!/bin/bash
#SBATCH -N 1
#SBATCH -n 6
#SBATCH -p gpu
#SBATCH --gres=gpu:1
#SBATCH -t 1:0:0

module load cuda/9.0
module load singularity/2.4
module load git

# work in your scratch space with a 'pytorch' folder
mkdir -p /scratch/users/$USER/pytorch
cd /scratch/users/$USER/pytorch

git clone https://github.com/pytorch/examples
cd examples/mnist

# redefine SINGULARITY_HOME to mount current working directory to base $HOME
export SINGULARITY_HOME=$PWD:/home/$USER 

singularity exec --nv /scratch/groups/singularity_images/pytorch.simg python main.py
