sed '1d' ./data/gene_GO_partial_dummy_coded.txt | sed 's/NA/0/g' | sed 's/GO:[0-9]*/1/g' > ./data/gene_GO_dummy_coded_no_header.txt
head -n1 ./data/gene_GO_partial_dummy_coded.txt > ./data/gene_GO_dummy_coded_header.txt
cat ./data/gene_GO_dummy_coded_header.txt ./data/gene_GO_dummy_coded_no_header.txt > ./data/gene_GO_dummy_coded_complete.txt
