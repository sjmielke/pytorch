# PyTorch

PyTorch Version: 0.4.0a0

MARCC NVidia GPU and installed drivers at testing time were: K80 & 384.81.

This job script can be submitted from anywhere, as the `scratch` locations are wired in - at MARCC, we recommend using your local scratch space, but please save your data for long-term archival in `/data/`

Work with this job script `pytorch_job.sh`:

```
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
```

Download this file: `wget https://raw.githubusercontent.com/marcc-hpc/pytorch/0.4.0a0/pytorch_job.sh`
Submit job: `sbatch pytorch_job.sh`
