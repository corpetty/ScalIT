#!/bin/bash
#$ -V
#$ -S /bin/bash
#$ -cwd
#$ -R y
#$ -j y
#$ -N pin
#$ -o $JOB_NAME.pout
#$ -e $JOB_NAME.e$JOB_ID
#$ -q himem 
#$ -pe mpi 2 
../../bin/ho2/ho2vBR < 1dDVRBr.pin > 1dDVRBr.pout &
../../bin/ho2/ho2vlr < 1dDVRlr.pin > 1dDVRlr.pout &
wait
