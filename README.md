# **Scripts**

This is a repository for all the scripts that where developed during my internship.

## Contents: 
- run-crup.sh: This script runs the CRUP software through all of the samples of a certain type run and type of sample. Type run and type sample are pased via arguments.<br/> 
For example:<br/> 
`bash run-crup.sh Single_ended Primary_cells`



- filehandling.sh: This script prepares the data for running CRUP. It performs merges and indexes the files. Type run and type sample are passed via arguments.<br/>
For example:<br/>

`bash filehandling.sh Single_ended Cell_lines`

- downloader.py: Calls encode_downloader.py to download the files and saves themand classifies them. The full path directory to the CSV file with the experimetns  to download and the directory where you want to store the downloaded experiments are passed via arguments.<\br>
`python3 downloader.py /full/path/to/the/file.csv path/to/save/the/experiments/`

- psql: This is not a script that can be run as is but an example of the commands that were used to make the files of the grouped data to download that is then used by downloader.py.

*The arguments passed to the filehandling.sh and run-crup.sh scripts have to be written exactly the same as in the folders containing the data*

**CRUP Software repository** 

https://github.com/VerenaHeinrich/CRUP

**CRUP Citation**

https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1860-7

 





