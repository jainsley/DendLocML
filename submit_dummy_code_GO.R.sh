module load R/3.0.3
#bsub -N -u jainsley@gmail.com bsub -R "mem > 70000" R CMD BATCH dummy_code_GO.R
bsub -N -u jainsley@gmail.com bsub -R "mem > 70000" R CMD BATCH dummy_code_GO_partial.R
