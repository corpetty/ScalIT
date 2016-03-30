#!/bin/bash
#$ -V
#$ -cwd
#$ -j y
#$ -R y
#$ -S /bin/bash
#$ -N hin_J0
#$ -o $JOB_NAME.o$JOB_ID
#$ -e $JOB_NAME.e$JOB_ID
#$ -q all.q
#$ -pe mpi 12 
unset SGE_ROOT
ulimit -l unlimited
ulimit -s unlimited

../../bin/iterate < r30R30gm470.in > r30R30gm470.out
