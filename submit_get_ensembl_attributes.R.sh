module load R/3.0.3
module load 
#bsub -N -u jainsley@gmail.com bsub -R "mem > 70000" R CMD BATCH dummy_code_GO.R
bsub -N -u jainsley@gmail.com bsub -R "mem > 70000" R CMD BATCH get_ensembl_attributes.R
