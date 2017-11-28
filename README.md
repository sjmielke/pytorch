# PyTorch

PyTorch Version: X.X.X

MARCC NVidia GPU and installed drivers at testing time were: K80 & 384.81.

Here's how to run it on MARCC systems:

Work with this job script `pytorch_job.sh`:

```
#!/bin/bash
#SBATCH -N 1
#SBATCH -n 6
#SBATCH -p gpu
#SBATCH --gres=gpu:1
#SBATCH -t 1:0:0

module load cuda/9.0           # also locates matching $CUDA_DRIVER location
module load singularity/2.4

mygroup=$(id $USER -Gn) # identify your primary group
mkdir -p /scratch/groups/$mygroup/pytorch
cd /scratch/groups/$mygroup/pytorch

singularity pull --name pytorch shub://marcc-hpc/tensorflow

git clone https://github.com/pytorch/examples
cd examples/mnist
ln -s /scratch/groups/$mygroup/pytorch/pytorch.simg .

# redefine SINGULARITY_HOME to mount current working directory to base $HOME
export SINGULARITY_HOME=$PWD:/home/$USER 

singularity exec --nv ./pytorch.simg python softmax_regression.py

```

Submit job: `sbatch pytorch_job.sh`
