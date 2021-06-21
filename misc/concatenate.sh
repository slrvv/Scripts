### concatenation of files
DIRDATA=/project/CRUP_scores/CRUP_scores/ENCODE
DIRRESULTS=/project/CRUP_scores/CRUP_scores/RESULTS
echo "All_files" > info_all.txt
for TYPE_RUN in Single_ended Pair_ended
do
  for TYPE_SAMPLE in Tissues Cell_lines Primary_cells
  do
    for SAMPLE in $(ls -F $DIRDATA/$TYPE_RUN/$TYPE_SAMPLE | grep / )
    do
      echo "$DIRDATA/$TYPE_RUN/$TYPE_SAMPLE/$SAMPLE"
      echo "$DIRDATA/$TYPE_RUN/$TYPE_SAMPLE/$SAMPLE" >> info_all.txt
      echo "$DIRRESULTS/$TYPE_RUN/$TYPE_SAMPLE/$SAMPLE" >> info_all.txt
      cat $DIRDATA/$TYPE_RUN/$TYPE_SAMPLE/${SAMPLE}metadata.txt >> info_all.txt
    done
  done
done
