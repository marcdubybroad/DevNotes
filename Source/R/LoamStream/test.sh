#!/bin/bash
#$ -cwd

source /broad/software/scripts/useuse
reuse -q R-3.4

/broad/software/free/Linux/redhat_6_x86_64/pkgs/r_3.4.0/bin/Rscript --vanilla --verbose test.r