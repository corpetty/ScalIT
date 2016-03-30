#!/bin/bash
#$ -V
#$ -cwd
#$ -j y
#$ -R y
#$ -S /bin/bash
#$ -N r30R30gm500
#$ -o $JOB_NAME.$JOB_ID.hout
#$ -e $JOB_NAME.e$JOB_ID
#$ -q himem  
#$ -pe mpi 1 
unset SGE_ROOT
../../bin/ho2/ho2_o < r30R30gm470.hin > r30R30gm470.hout 
