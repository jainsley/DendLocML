sed '1,6d' ./data/gene_association.mgi | cut -f3,5 | sort -u > ./data/gene_GO.mgi
