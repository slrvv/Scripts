###Simplify
DIR=/project/CRUP_scores/CRUP_scores/ENCODE/Encode_data/Single_ended/Tissues
for TISSUE in adrenal_gland
do
  echo $TISSUE
  for HM in $(ls $DIR/$TISSUE)
  do
    mapfile -t ACC < <( ls $DIR/$TISSUE/$HM )
    #
    rm $DIR/$TISSUE/$HM/all_files.tsv
    DIR2=$DIR/$TISSUE/$HM/${ACC[0]}released
    echo ${ACC[0]}
    rm -rf $DIR2/hg19
    DIR3=$DIR2/GRCh38/alignments/bam/rep1/
    for BAMFILE in $(ls $DIR3)
    do
      mv $DIR3$BAMFILE $DIR/$TISSUE/$HM/
    done
    echo "Removing folders"
    rm -rf $DIR3
    rm -rf $DIR2/GRCh38/alignments/bam/
    rm -rf $DIR2/GRCh38/alignments/
    rm -rf $DIR2/GRCh38/
    rm -rf $DIR2
    rm -rf $DIR/$TISSUE/$HM/${ACC[0]}
  done

done
