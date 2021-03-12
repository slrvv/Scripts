# **Scripts**

##This is a repository for all the scripts that where developed during my internship

##Contents: 
- run-crup.sh: This script runs the CRUP software through all of the samples of a certain type run and type of sample. Type run and type sample are pased via arguments. 
For example: 
`bash run-crup.sh Primary_cells Single_ended`

The names of type run and type sample have to be the same as the folders containing the data

- filehandling.sh: This script prepares the data for running CRUP. It performs merges and indexes the files. Type run, type sample and sample name are passed via argument.

For example: 
`bash filehandling.sh Single_ended Cell_line HCT116`

Again the names have to be the same as in the folders containing the data. 







